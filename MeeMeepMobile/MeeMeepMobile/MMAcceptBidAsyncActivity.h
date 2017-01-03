//
//  MMAcceptBidAsyncActivity.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 25/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMReAuthenticatingActivity.h"
#import "MMRestClient.h"
#import "MMBidDetail.h"
#import "MMRestAccessToken.h"
#import "MMBidAcceptRequest.h"

@interface MMAcceptBidAsyncActivity : MMReAuthenticatingActivity

@property (strong, nonatomic) MMBidAcceptRequest* bidAccept;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD andBidAccept:(MMBidAcceptRequest*) acceptBid;

@end
