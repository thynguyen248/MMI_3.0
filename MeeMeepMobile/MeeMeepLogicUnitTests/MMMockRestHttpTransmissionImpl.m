//
//  MMMockRestHttpTransmissionImpl.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 4/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMMockRestHttpTransmissionImpl.h"
#import "MMMockHttpTransmissionResponseMatcher.h"

@implementation MMMockRestHttpTransmissionImpl

@synthesize getResponseMatcher;
@synthesize putResponseMatcher;
@synthesize postResponseMatcher;

- (id) initWithResponseMatchers:(id<MMMockHttpTransmissionResponseMatcher>) getMatcher put:(id<MMMockHttpTransmissionResponseMatcher>) putMatcher post:(id<MMMockHttpTransmissionResponseMatcher>) postMatcher {
    self = [super init];
    if (self) {
        self.getResponseMatcher = getMatcher;
        self.putResponseMatcher = putMatcher;
        self.postResponseMatcher = postMatcher;
        return self;
    }
    
    return nil;
}

- (MMRestHttpResponse *) httpGET:(NSString *) url 
            withBody:(NSData *) requestBody 
    withHeaderParams:(NSDictionary *) params {
    
    // FIX ME - should be populating headers if available
    MMRestHttpResponse *response = [getResponseMatcher responseMatchingUrl:url andParams:params];
    return response;
}

- (MMRestHttpResponse *) httpPUT:(NSString *) url 
            withBody:(NSData *) requestBody 
    withHeaderParams:(NSDictionary *) params {
    
    // FIX ME - should be populating headers and response params if available
    MMRestHttpResponse *response = [putResponseMatcher responseMatchingUrl:url andParams:params];
    
    return response;
}

- (MMRestHttpResponse *) httpPOST:(NSString *) url 
             withBody:(NSData *) requestBody 
     withHeaderParams:(NSDictionary *) params {
    
    MMRestHttpResponse *response = [postResponseMatcher responseMatchingUrl:url andParams:params];
    
    return response;
}

@end
