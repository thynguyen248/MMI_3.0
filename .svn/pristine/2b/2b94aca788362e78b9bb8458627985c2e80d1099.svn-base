//
//  MMRestAuthorisationClientImpl.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 6/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestAuthorisationClientImpl.h"
#import "MMRestAccessToken.h"
#import "MMLoginResponseSerialisation.h"
#import "MMRestHttpAuthorisedTransmissionImpl.h"
#import "MMErrorUtils.h"
#import "MMSerialisationUtils.h"
#import "MMLoginResponse.h"

@implementation MMRestAuthorisationClientImpl

@synthesize httpTransmission;
@synthesize authorisedTransmission;
@synthesize serialisationFactory;
@synthesize baseUrl;
@synthesize loginUrl;
@synthesize logoutUrl;

- (id) initWithTransmission:(id<MMRestHttpTransmission>)tx s11nFactory:(id<MMSerialisationFactory>)factory withBaseUrl:(NSString *)url relativeLoginPath:(NSString *)loginPath andRelativeLogoutPath:(NSString*)logoutPath {
    
    self = [super init];
    if (self) {
        self.httpTransmission = tx;
        self.serialisationFactory = factory;
        self.baseUrl = url;
        self.loginUrl = [url stringByAppendingPathComponent:loginPath];
        self.logoutUrl = [url stringByAppendingPathComponent:logoutPath];
        self.authorisedTransmission = [[MMRestHttpAuthorisedTransmissionImpl alloc] initWithTransmissionDelegate:self.httpTransmission];
        return self;
    }
    
    return nil;
}

- (MMRestAccessToken *) loginWithEmail:(NSString *) email andPassword:(NSString *) password {
    if (email == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"input email was nil" userInfo:nil];
    if (password == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"input password was nil" userInfo:nil];
    
    // determine login url
    
    // create request body
    NSData *loginRequestBody = [[NSString stringWithFormat:@"j_username=%@&j_password=%@&_spring_security_remember_me=true", email, password] dataUsingEncoding:NSUTF8StringEncoding];

    // create request header
    NSMutableDictionary *httpRequestHeaders = [[NSMutableDictionary alloc] init];
    [httpRequestHeaders setValue:@"xmlhttprequest" forKey:@"X-Requested-With"];
    [httpRequestHeaders setValue:@"application/x-www-form-urlencoded" forKey:@"Content-Type"];
    
    
    // Delete all previous cookies
    for(NSHTTPCookie* cook in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies])
    {
        DLog(@"Deleting cookie: %@", cook.properties);
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cook];
    }
    
    // Make the actual request
    MMRestHttpResponse *httpResponse = [self.httpTransmission httpPOST:loginUrl withBody:loginRequestBody withHeaderParams:httpRequestHeaders];
    
    // Throws exception on error - including Incorrect Username and Password :-)
    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not login" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    DLog(@"Login http response: %d", httpResponse.responseCode);
    
    // parse response
    MMLoginResponseSerialisation *responseSerialisation = [serialisationFactory getMMLoginResponseSerialisation];
    
    MMLoginResponse* loginResponse = [responseSerialisation deserialiseData:httpResponse.responseBody];
    
    if(httpResponse.responseCode != 200 || loginResponse.errorMessage)
    {
        NSString* errorMessage = (loginResponse.errorMessage ? loginResponse.errorMessage : @"Unknown error occured");
        DLog(@"Throwing exception: %@", errorMessage);
        MMException *ex = [[MMException alloc] initWithName:NSGenericException reason:errorMessage userInfo:nil nestedError:nil];
        @throw ex;
    }
    
    DLog(@"User ID: %@", loginResponse.userId);
    // Login went well, now get the required cookies
    DLog(@"Login returns success. Now get cookie.");
    
    NSMutableString* cookieValue = [[NSMutableString alloc] init];
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies])
    {
        DLog(@"Found cookie: %@=%@", [cookie name], [cookie value]);
        DLog(@"%@", cookie.properties);
        
        if([[cookie name] isEqualToString:@"AWSELB"] || [[cookie name] isEqualToString:@"JSESSIONID"]) {
            DLog(@"YOINK!");
            if([cookieValue length] > 0) {
                [cookieValue appendString:@";"];
            }
            [cookieValue appendFormat:@"%@=%@", [cookie name], [cookie value]];
        }
    }
    
    if([cookieValue length] == 0) {
        MMException *ex = [[MMException alloc] initWithName:NSGenericException reason:@"No Authentication Cookie" userInfo:nil nestedError:nil];
        @throw ex;
    }
    
    DLog(@"Cookie retrieved: %@", cookieValue);
    
    MMRestAccessToken *token = [[MMRestAccessToken alloc] init];
    token.userId = loginResponse.userId;
    token.userName = loginResponse.userName == nil ? email : loginResponse.userName;
    token.accessToken = cookieValue;
    
    return token;
}

- (void) logoutWith:(MMRestAccessToken *) token {
    if(token.accessToken == nil || [token.accessToken isEqualToString:@""])
    {
        // We don't have a cookie anyway, so won't be able to call logout, may aswell just finish here
        return;
    }
    
    NSMutableDictionary *httpRequestHeaders = [[NSMutableDictionary alloc] init];
    [httpRequestHeaders setValue:@"xmlhttprequest" forKey:@"X-Requested-With"];
    
    MMRestHttpResponse *response = [self.authorisedTransmission authorisedMethod:@"POST" toUrl:logoutUrl withRequestBody:nil additionalRequestHeaders:httpRequestHeaders andAccessToken:token];
    
    if (response.responseCode != 200) {
        // should throw an error here!"
        DLog(@"Error in logging out, response code: %d", response.responseCode);
    }
}

@end
