//
//  MMAcceptBidAsyncActivityResult.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 25/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMAsyncActivityResult.h"

extern NSString *BID_ACCEPT_FAIL_CC_NOT_REGISTERED;
extern NSString *BID_ACCEPT_SUCCESS;
 
enum MMAsyncBidAcceptResultEnum {
    MMAsyncBidAcceptResultFailure = 0,
    MMAsyncBidAcceptResultCreditCardNotRegistered = 1,
    MMAsyncBidAcceptResultSuccess = 2,
    MMAsyncBidAcceptResultUndefined = 3
};

typedef enum MMAsyncBidAcceptResultEnum MMAsyncBidAcceptResult;

@interface MMAcceptBidAsyncActivityResult : NSObject<MMAsyncActivityResult> {
    MMAsyncBidAcceptResult bidAcceptStatus;
}

@property (assign, nonatomic) MMAsyncBidAcceptResult bidAcceptStatus;

@end
