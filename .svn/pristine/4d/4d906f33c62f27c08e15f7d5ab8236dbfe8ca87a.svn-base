//
//  MMRestHttpResponse.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 7/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestHttpResponse.h"

@implementation MMRestHttpResponse

@synthesize responseHeaders;
@synthesize responseParameters;
@synthesize responseCode;
@synthesize responseBody;
@synthesize localError;
@synthesize isRemoteRestError;

- (id) initWithBody:(NSData *) b responseCode:(NSInteger) code headers:(NSDictionary *) headers params:(NSDictionary *) params orLocalError:(NSError *)error {
    self = [super init];
    if (self) {
        self.responseBody = b;
        self.responseCode = code;
        self.responseHeaders = headers;
        self.responseParameters = params;
        self.localError = error;
        self.isRemoteRestError = NO;
        return self;
    }
    
    return nil;
}


@end
