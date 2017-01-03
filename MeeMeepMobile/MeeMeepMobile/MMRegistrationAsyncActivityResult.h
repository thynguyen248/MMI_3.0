//
//  MMRegistrationActivityResult.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMAsyncActivityResult.h"

enum MMAsyncRegistrationResultEnum {
    MMAsyncRegistrationResultFailure = 0,
    MMAsyncRegistrationResultSuccess = 1,
    MMAsyncRegistrationResultUndefined = 2
};

typedef enum MMAsyncRegistrationResultEnum MMAsyncRegistrationResult;

@interface MMRegistrationAsyncActivityResult : NSObject<MMAsyncActivityResult>

@property (assign, nonatomic) MMAsyncRegistrationResult status;

@end
