//
//  MMRateUserActivityResult.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMAsyncActivityResult.h"

enum MMAsyncRateUserResultEnum {
    MMAsyncRateUserResultFailure = 0,
    MMAsyncRateUserResultSuccess = 1,
    MMAsyncRateUserResultUndefined = 2
};

typedef enum MMAsyncRateUserResultEnum MMAsyncRateUserResult;

@interface MMCompleteJobAsyncActivityResult : NSObject<MMAsyncActivityResult> {
    MMAsyncRateUserResult status;
}

@property (assign, nonatomic) MMAsyncRateUserResult status;

@end
