//
//  MMErrorUtils.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMException.h"
#import "MMRestHttpResponse.h"
#import "MMRestErrorSerialisation.h"

extern NSString *MMApplicationDomain;
extern NSInteger DEFAULT_MM_ERROR_CODE;

@interface MMErrorUtils : NSObject

+ (NSError *) errorForException:(NSException *) exception withDomain:(NSString *) domain andCode:(NSNumber *) code;

+ (void) throwMMExceptionForResponseOnError:(MMRestHttpResponse *) response withReason:(NSString *) reason deserialisedWith:(MMRestErrorSerialisation *) errorS11n;
@end
