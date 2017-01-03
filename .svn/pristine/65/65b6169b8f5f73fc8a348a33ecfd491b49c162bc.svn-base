//
//  MMRestHttpTransmissionImpl.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/NSURLConnection.h>
#import "MMRestHttpTransmissionImpl.h"
#import "MMHttpNSLogLogging.h"
#import "MMRestHttpException.h"

#import "MMRestHttpRequestActivity.h"
#import "MMAsyncActivityManagementImpl.h"

static NSString *HTTP_METHOD_GET = @"GET";
static NSString *HTTP_METHOD_PUT = @"PUT";
static NSString *HTTP_METHOD_POST = @"POST";

static NSUInteger DEFAULT_REQUEST_TIMEOUT = 40; // seconds 'til timeout

@implementation MMRestHttpTransmissionImpl

@synthesize logging;
@synthesize httpRequestTimeout;
@synthesize activityManagement;

- (id) init {
    self = [super init];
    if (self) {
        self.logging = [[MMHttpNSLogLogging alloc] init];
        self.httpRequestTimeout = DEFAULT_REQUEST_TIMEOUT;
        self.activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
        return self;
    } else return nil;
}

- (id) initWithLogging:(id<MMHttpLogging>)log {
    self = [super init];
    if (self) {
        self.logging = log;
        self.httpRequestTimeout = DEFAULT_REQUEST_TIMEOUT;
        return self;
    }
    
    return nil;
}

- (id) initWithRequestTimeout:(NSUInteger)timeout andLogging:(id<MMHttpLogging>)log {
    self = [super init];
    if (self) {
        self.httpRequestTimeout = timeout;
        self.logging = log;
        return self;
    }
    
    return nil;
}

- (MMRestHttpResponse *) httpGET:(NSString *) url 
            withBody:(NSData *) requestBody 
    withHeaderParams:(NSDictionary *) params {

    @try {
        if (url == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"URL was nil" userInfo:nil];
        // body can be nil
        // params can be nil

        NSURL *targetUrl = [NSURL URLWithString:url];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:targetUrl];

        [request setHTTPBody:[NSData dataWithData:requestBody]];
        [request setHTTPMethod:HTTP_METHOD_GET];
        [request setHTTPShouldHandleCookies:YES];
        
        // header params are complimentary to default header params
        [self addParams:params toRequest:request];
        
        // copy body parameter data into request body
        if (logging != nil)
            [logging logHttpRequestBody:requestBody forURL:url withMethod:@"GET" withHeaders:request.allHTTPHeaderFields];
        
        MMRestHttpRequestActivity *getActivity = [[MMRestHttpRequestActivity alloc] initWithRequest:request andTimeout:self.httpRequestTimeout];
        [self.activityManagement dispatchMMAsyncActivity:getActivity];
        DLog(@"Waiting for GET operation to complete!");
        [getActivity waitUntilFinished];
        
        MMRestHttpResponse *httpResponse = getActivity.response;
        
        if (logging != nil)
            [logging logHttpResponseBody:httpResponse.responseBody headers:httpResponse.responseHeaders andResponseCode:httpResponse.responseCode];
        
        return httpResponse;
    } @catch (NSException *anyEx) {
        MMRestHttpException *httpEx = [[MMRestHttpException alloc] initWithReason:@"Could not perform GET operation" userInfo:nil nestedException:anyEx containedError:nil forUrl:url usingMethod:HTTP_METHOD_GET withHeaders:params];
        
        @throw httpEx;
    }
    
    return nil;
    
}

- (MMRestHttpResponse *) httpPUT:(NSString *) url 
            withBody:(NSData *) requestBody 
    withHeaderParams:(NSDictionary *) params {
    
    DLog(@"Performing HTTP PUT on url %@", url);
    
    NSURL *targetUrl = [NSURL URLWithString:url];
    
    // formulate the request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:targetUrl];
   
    request.HTTPBody = [NSData dataWithData:requestBody];
    request.HTTPMethod = HTTP_METHOD_PUT;
    [request setHTTPShouldHandleCookies:YES];
    DLog(@"Request timeout: %f", request.timeoutInterval);
    // header params are complimentary to default header params
    
    [self addParams:params toRequest:request];
    
    // copy body parameter data into request body
    
    if (logging != nil)
        [logging logHttpRequestBody:requestBody forURL:url withMethod:@"PUT" withHeaders:request.allHTTPHeaderFields];
    
    MMRestHttpRequestActivity *putActivity = [[MMRestHttpRequestActivity alloc] initWithRequest:request andTimeout:self.httpRequestTimeout];
    [self.activityManagement dispatchMMAsyncActivity:putActivity];
    DLog(@"Waiting for PUT operation to complete!");
    [putActivity waitUntilFinished];
    
    MMRestHttpResponse *httpResponse = putActivity.response;
    
    if (logging != nil)
        [logging logHttpResponseBody:httpResponse.responseBody headers:httpResponse.responseHeaders andResponseCode:httpResponse.responseCode];
    
    return httpResponse;
}

- (MMRestHttpResponse *) httpPOST:(NSString *) url 
             withBody:(NSData *) requestBody 
     withHeaderParams:(NSDictionary *) params {
    
    DLog(@"Performing HTTP POST on url %@", url);
    NSURL *targetUrl = [NSURL URLWithString:url];
    
    // formulate the request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:targetUrl];
    request.HTTPBody = [NSData dataWithData:requestBody];
    request.HTTPMethod = HTTP_METHOD_POST;
    [request setHTTPShouldHandleCookies:YES];
    
    // header params are complimentary to default header params
    [self addParams:params toRequest:request];

    // copy body parameter data into request body
    
    if (logging != nil)
        [logging logHttpRequestBody:requestBody forURL:url withMethod:@"POST" withHeaders:request.allHTTPHeaderFields];
    
    MMRestHttpRequestActivity *postActivity = [[MMRestHttpRequestActivity alloc] initWithRequest:request andTimeout:self.httpRequestTimeout];
    [self.activityManagement dispatchMMAsyncActivity:postActivity];
    DLog(@"Waiting for POST operation to complete!");
    [postActivity waitUntilFinished];
    
    MMRestHttpResponse *httpResponse = postActivity.response;
    
    if (logging != nil) {
        [logging logHttpResponseBody:httpResponse.responseBody headers:httpResponse.responseHeaders andResponseCode:httpResponse.responseCode];
    }
    
    return httpResponse;
}

- (void) addParams:(NSDictionary*)params toRequest:(NSMutableURLRequest*)request {
    bool containsContentType = false;
    
    for (NSString *key in params) {
        if([[key lowercaseString] isEqualToString:@"content-type"]) {
            containsContentType = true;
        }
        
        [request addValue:[params valueForKey:key] forHTTPHeaderField:key];
    }
    
    if(!containsContentType) {
        DLog(@"Adding content type");
        [request addValue:@"application/json" forHTTPHeaderField:@"content-type"];
    }
}

@end
