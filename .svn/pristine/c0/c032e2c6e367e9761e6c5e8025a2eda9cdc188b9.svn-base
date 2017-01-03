//
//  MMRejectBidAsyncActivityResult.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 25/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMAsyncActivityResult.h"
 
enum MMAsyncBidRejectResultEnum {
    MMAsyncBidRejectResultFailure = 0,
    MMAsyncBidRejectResultSuccess = 1,
    MMAsyncBidRejectResultUndefined = 2
};

typedef enum MMAsyncBidRejectResultEnum MMAsyncBidRejectResult;

@interface MMWithdrawBidAsyncActivityResult : NSObject<MMAsyncActivityResult> {
    MMAsyncBidRejectResult bidRejectStatus;
}

@property (assign, nonatomic) MMAsyncBidRejectResult bidRejectStatus;

@end
