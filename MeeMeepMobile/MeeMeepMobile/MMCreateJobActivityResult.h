//
//  MMCreateJobActivityResult.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 30/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMAsyncActivityResult.h"
#import "MMJobDetail.h"

enum MMAsyncCreateJobStatusEnum {
    MMAsyncCreateJobStatusSuccess = 1,
    MMAsyncCreateJobStatusSuccessNoCreditCard = 2,
    MMAsyncCreateJobStatusFailure = 3,
    MMAsyncCreateJobStatusUndefined = 0 
};

typedef enum MMAsyncCreateJobStatusEnum MMAsyncCreateJobStatus;

@interface MMCreateJobActivityResult : NSObject <MMAsyncActivityResult> {
    MMAsyncCreateJobStatus jobCreatedStatus;
}

@property (assign, nonatomic) MMAsyncCreateJobStatus jobCreatedStatus;

@end
