//
//  MMRestHttpAuthorisedTransmissionImpl.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 8/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestHttpAuthorisedTransmissionImpl.h"

@implementation MMRestHttpAuthorisedTransmissionImpl

@synthesize httpTransmissionDelegate;

- (id) initWithTransmissionDelegate:(id<MMRestHttpTransmission>) delegate {
    self = [super init];
    
    if (self) {
        self.httpTransmissionDelegate = delegate;
        
        return self;
    }
    
    return nil;
}

- (MMRestHttpResponse *) authorisedMethod:(NSString *)method toUrl:(NSString *) url withRequestBody:(NSData *) requestBody additionalRequestHeaders:(NSDictionary *) additionalHeaders andAccessToken:(MMRestAccessToken *) token {
    
    // copy the cookie value out of the access token into the required header in the request
    NSMutableDictionary *requestHeaders = [[NSMutableDictionary alloc] init];
    
    if(token.accessToken != nil && [token.accessToken length] > 0)
    {
        [requestHeaders setValue:token.accessToken forKey:@"Cookie"];
    }
    
    if (additionalHeaders != nil) {
        [requestHeaders addEntriesFromDictionary:additionalHeaders];
    }
    
    MMRestHttpResponse *response = nil;
    
    if (method != nil) {
        if ([method isEqualToString:@"POST"]) {
            response = [httpTransmissionDelegate httpPOST:url withBody:requestBody withHeaderParams:requestHeaders];
        } else if ([method isEqualToString:@"GET"]) {
            response = [httpTransmissionDelegate httpGET:url withBody:requestBody withHeaderParams:requestHeaders];
        } else if ([method isEqualToString:@"PUT"]) {
            response = [httpTransmissionDelegate httpPUT:url withBody:requestBody withHeaderParams:requestHeaders];
        }
    }
    
    return response;
}

@end
