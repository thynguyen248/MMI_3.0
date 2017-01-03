//
//  MMCreateMessageActivityResult.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMAsyncActivityResult.h"

enum MMAsyncCreateMessageResultEnum {
    MMAsyncCreateMessageResultFailure = 0,
    MMAsyncCreateMessageResultSuccess = 1,
    MMAsyncCreateMessageResultUndefined = 2
};

typedef enum MMAsyncCreateMessageResultEnum MMAsyncCreateMessageResult;

@interface MMCreateMessageAsyncActivityResult : NSObject<MMAsyncActivityResult> {
    MMAsyncCreateMessageResult status;
}

@property (assign, nonatomic) MMAsyncCreateMessageResult status;

@end
