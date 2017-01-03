//
//  MMAcceptBidAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 25/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMAcceptBidAsyncActivity.h"
#import "MMAcceptBidAsyncActivityResult.h"

@implementation MMAcceptBidAsyncActivity

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD andBidAccept:(MMBidAcceptRequest*) acceptBid {
    self = [super initWithActivityDelegate:d restDelegate:restD];
    if (self) {
        self.bidAccept = acceptBid;
        return self;
    }
    
    return nil;
}

- (id<MMAsyncActivityResult>) performAction {
    if (self.bidAccept == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Bid to accept was nil" userInfo:nil];
    
    id<MMRestClient> restClient = [restDelegate getRestClient];
    
    MMRestAccessToken *accessToken = [restDelegate getAccessToken];

    MMAcceptBidAsyncActivityResult *bidAcceptResult = [[MMAcceptBidAsyncActivityResult alloc] init];

    id<MMRestBidClient> bidClient = [restClient getBidClient];
    BOOL bidAccepted = [bidClient acceptBid:self.bidAccept andAccessToken:accessToken];
    
    bidAcceptResult.bidAcceptStatus = (bidAccepted) ? MMAsyncBidAcceptResultSuccess : MMAsyncBidAcceptResultFailure;
    
    return bidAcceptResult;
}

@end
