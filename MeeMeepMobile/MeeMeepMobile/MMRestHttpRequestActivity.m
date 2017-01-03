//
//  MMRestHttpRequestActivity.m
//  ;
//
//  Created by Greg Soertsz on 26/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestHttpRequestActivity.h"
#import "MMErrorUtils.h"
#import <Security/Security.h>
#import "AppDelegateMMRestClientUtils.h"

@implementation MMRestHttpRequestActivity

@synthesize request;
@synthesize response;
@synthesize requestError;
@synthesize receivedData;
@synthesize requestCompleted;
@synthesize connection;
@synthesize requestTimeout;

- (id) initWithRequest:(NSMutableURLRequest *)req andTimeout:(NSUInteger) timeout {
    self = [super init];
    if (self) {
        self.request = req;
        self.requestCompleted = NO;
        self.receivedData = nil;
        self.requestTimeout = timeout;
        _expectedRequestCompletionDate = nil;
        return self;
    }
    
    return nil;
}

- (BOOL) isReady {
    DLog(@"Readiness queried...");
    return YES;
}

- (void) main {
    
    // create a NSURLConnection with the request
    if ([NSURLConnection canHandleRequest:self.request]) {
        self.connection = [NSURLConnection connectionWithRequest:self.request delegate:self];
        if (self.connection != nil) {
            [self.connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            [self.connection start];
            
            // start a timer here?
            _expectedRequestCompletionDate = [NSDate dateWithTimeIntervalSinceNow:self.requestTimeout];
            
            NSTimeInterval checkInterval = (NSTimeInterval) 2.0;
            
            NSTimer *httpTimer = [NSTimer scheduledTimerWithTimeInterval:checkInterval target:self selector:@selector(httpTimerExpired) userInfo:nil repeats:YES];
            
            DLog(@"starting timer...");
            [[NSRunLoop currentRunLoop] addTimer:httpTimer forMode:NSDefaultRunLoopMode];
            
            DLog(@"main method called");
            while (!self.requestCompleted) {
                // run the default mode run loop blocking for 2 seconds on each input
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
                DLog(@"Waiting for connection to finish loading...");
            }
            
            DLog(@"Request loading complete, cleaning up timers and connections...");
            [httpTimer invalidate];
            [self.connection unscheduleFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            
            // if there is a local error, then set the reponses local error appropriately along with the code and return it.
            // otherwise sweep up the remote response details.
            if (self.requestError) {
                self.response = [[MMRestHttpResponse alloc] initWithBody:nil responseCode:self.requestError.code headers:nil params:nil orLocalError:self.requestError];
            } else {
                if (self.receivedData != nil && [self.receivedData length] > 0) {
                    // put this data in the response
                    if (self.response != nil) {
                        self.response.responseBody = self.receivedData;
                    }
                    
                    // if we received data but not a 200 error code then its a remote rest error
                    if (self.response.responseCode >= 400 || self.response.responseCode >= 500) {
                        self.response.isRemoteRestError = YES;
                    }
                }
            }
        }
    } else {
        DLog(@"Could not handle request");
    }
    
    DLog(@"Main method complete!");
}

- (void) httpTimerExpired {
    DLog(@"HTTP timer event expired");
    
    NSDate *eventTime = [NSDate dateWithTimeIntervalSinceNow:0];
    // if I received this notification outside the expected completion window
    if ([eventTime compare:_expectedRequestCompletionDate] == NSOrderedDescending) {
        DLog(@"Http time out occurred!!");
        // if the difference between these two dates is greater than the timeout
        //if (++_requestDurationSeconds > self.requestTimeout) {
        [self.connection cancel];
        NSString *errorDescription = @"HTTP Timeout";
        NSString *errorFailureReason = @"Timeout contacting remote server";
        NSMutableDictionary *errorInfo = [[NSMutableDictionary alloc] init];
        [errorInfo setValue:errorDescription forKey:NSLocalizedDescriptionKey];
        [errorInfo setValue:errorFailureReason forKey:NSLocalizedFailureReasonErrorKey];
        
        NSError *localTimeoutError = [NSError errorWithDomain:MMApplicationDomain code:DEFAULT_MM_ERROR_CODE userInfo:errorInfo];
        self.requestError = localTimeoutError;
        [self connectionLoadingComplete];
    }
    //[self connection:self.connection didFailWithError:localTimeoutError];
}

- (void) connectionLoadingComplete {
    DLog(@"Connection loading complete...signalling internal condition!");
    self.requestCompleted = YES;
    DLog(@"Internal condition signalled");
}

#pragma mark - NSURLConnectionDelegate methods

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.requestError = error;
    DLog(@"Received an error: %@", [error localizedDescription]);
    // TODO need to parse the error and set the exception
    [self connectionLoadingComplete];
}

#pragma mark - NSURLConnectionDataDelegate methods
// look up other optional methods via NSURLConnectionDataDelegate header file

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString *bodyDataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    DLog(@"Received some data: [%@]", bodyDataString);
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    if (self.receivedData == nil) {
        self.receivedData = [[NSMutableData alloc] init];
        [self.receivedData setLength:0];
    }
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)resp {
    // we received a response from the http connection attempt
    
    // map through the http response detail
    DLog(@"Response received from URL: %@", [resp.URL description]);
    // compose the start of the response
    if ([resp isKindOfClass:[NSHTTPURLResponse class]]) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) resp;
        DLog(@"Code: [%d]", httpResponse.statusCode);
        
        self.response = [[MMRestHttpResponse alloc] initWithBody:nil responseCode:httpResponse.statusCode headers:httpResponse.allHeaderFields params:nil orLocalError:nil];
    }
    
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // wrap everything up.
    DLog(@"Connection did finish loading...");
    [self connectionLoadingComplete];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    DLog(@"Was asked about [%@]", protectionSpace.authenticationMethod);
    
    return ([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]
            || [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodDefault]);
}


- (void) connection:(NSURLConnection *) urlConnection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    DLog(@"Did receive authentication challenge: [%@]", challenge.protectionSpace.authenticationMethod);
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        DLog(@"Signalling trust for host: %@", [challenge.protectionSpace host]);
    }
    else if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodDefault])
    {
        // The following code is now needed if we are using the staging environment
        NSString *authorizationUsername = [[AppDelegateMMRestClientUtils getMMRestConfiguration] objectForKey:@"MeeMeepRestClientURLAuthorizationUsername"];
        NSString *authorizationPassword = [[AppDelegateMMRestClientUtils getMMRestConfiguration] objectForKey:@"MeeMeepRestClientURLAuthorizationPassword"];
        
        if(authorizationUsername != nil && ![authorizationUsername isEqualToString:@""]
           && authorizationPassword != nil && ![authorizationPassword isEqualToString:@""])
        {
            NSURLCredential *newCredential = [NSURLCredential credentialWithUser:authorizationUsername
                                                                        password:authorizationPassword
                                                                     persistence:NSURLCredentialPersistenceForSession];
            
            [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
            
            DLog(@"Signalling trust for host: %@", [challenge.protectionSpace host]);
        }
    }
    else
    {
        DLog(@"Not supporting [%@]", challenge.protectionSpace.authenticationMethod);
    }
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}


- (NSURLRequest *)connection: (NSURLConnection *)connection
             willSendRequest: (NSURLRequest *)sendRequest
            redirectResponse: (NSURLResponse *)redirectResponse;
{
    if (redirectResponse) {
        
        DLog(@"Received a sneaky redirect from: %@", [redirectResponse URL] );
        DLog(@"Received a sneaky redirect to: %@", [sendRequest URL] );
        
        /*
         * Received a redirect.
         * We don't want to follow standards, that's overrated!
         * Instead we're going to send a copy of our original request
         * but with the redirected URL
         */
        
        // Copy original request
        NSMutableURLRequest *copyRequest = [self.request mutableCopy];
        
        // Change the url
        [copyRequest setURL: [sendRequest URL]];
        
        // Send again
        return copyRequest;
    }
    
    // Not a redirect, just a change of request. For example, changing a request for http://www.apple.com to http://www.apple.com/
    // Just accept and return the sendRequest
    return sendRequest;
}

@end
