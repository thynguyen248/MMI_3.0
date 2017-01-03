//
//  MMHttpNSLogLogging.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 18/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMHttpNSLogLogging.h"

@implementation MMHttpNSLogLogging

- (void) logHttpRequestBody:(NSData *) body forURL:(NSString *) url withMethod:(NSString *) method withHeaders:(NSDictionary *) headers {
    
    NSString *payloadString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
    
    DLog(@"Request: [%@] [%@] ------------->", method, url);
    
    for (NSString *key in headers) {
        DLog(@"%@: %@", key, [headers objectForKey:key]);
    }
    
    DLog(@"%@", payloadString);
}


- (void) logHttpResponseBody:(NSData *) body headers:(NSDictionary *) h andResponseCode:(NSInteger) rc {
    
    NSString *payloadString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
    
    DLog(@"Response (%d) <------------", rc);
    
    for (NSString *key in h) {
        DLog(@"%@: %@", key, [h objectForKey:key]);
    }
    
    DLog(@"%@", payloadString);
}


@end
