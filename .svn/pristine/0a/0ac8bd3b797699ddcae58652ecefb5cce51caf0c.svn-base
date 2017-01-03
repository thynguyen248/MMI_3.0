//
//  MMrejectBidAsyncActivity.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 25/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMReAuthenticatingActivity.h"
#import "MMBidDetail.h"

@interface MMWithdrawBidAsyncActivity : MMReAuthenticatingActivity {
    NSNumber *bidIdToReject;
}

@property (strong, nonatomic) NSNumber *bidIdToReject;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD bidIdToReject:(NSNumber *) bidId;

@end
