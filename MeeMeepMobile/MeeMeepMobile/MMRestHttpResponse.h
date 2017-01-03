//
//  MMRestHttpResponse.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 7/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMRestHttpResponse : NSObject {
    NSDictionary *responseHeaders;
    NSDictionary *responseParameters;
    NSInteger responseCode;
    NSData *responseBody;
    NSError *localError;
    BOOL isRemoteRestError;
}

@property (strong, nonatomic) NSDictionary *responseHeaders;
@property (strong, nonatomic) NSDictionary *responseParameters;
@property (assign, nonatomic) NSInteger responseCode;
@property (strong, nonatomic) NSData *responseBody;
@property (strong, nonatomic) NSError *localError;
@property (assign, nonatomic) BOOL isRemoteRestError;

- (id) initWithBody:(NSData *) body responseCode:(NSInteger) code headers:(NSDictionary *) responseHeaders params:(NSDictionary *) responseParameters orLocalError:(NSError *) error;

@end
