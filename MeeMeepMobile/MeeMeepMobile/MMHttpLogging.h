//
//  MMHttpLogging.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 18/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MMHttpLogging <NSObject>

- (void) logHttpRequestBody:(NSData *) body forURL:(NSString *) url withMethod:(NSString *) method withHeaders:(NSDictionary *) headers;
- (void) logHttpResponseBody:(NSData *) body headers:(NSDictionary *) h andResponseCode:(NSInteger) rc;

@end
