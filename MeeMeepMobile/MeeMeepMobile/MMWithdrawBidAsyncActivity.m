//
//  MMRejectBidAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 25/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMWithdrawBidAsyncActivity.h"
#import "MMWithdrawBidAsyncActivityResult.h"

@implementation MMWithdrawBidAsyncActivity

@synthesize bidIdToReject;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD bidIdToReject:(NSNumber *) bidId {
    self = [super initWithActivityDelegate:d restDelegate:restD];
    if (self) {
        self.bidIdToReject = bidId;
        return self;
    }
    
    return nil;
}

- (id<MMAsyncActivityResult>) performAction {
    
    if (self.bidIdToReject == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Bid Id to Reject was nil" userInfo:nil];
    
    MMWithdrawBidAsyncActivityResult *bidRejectResult = [[MMWithdrawBidAsyncActivityResult alloc] init];

    bidRejectResult.bidRejectStatus = MMAsyncBidRejectResultUndefined;
    
    id<MMRestClient> restClient = [restDelegate getRestClient];
    MMRestAccessToken *currentToken = [restDelegate getAccessToken];
    
    id<MMRestBidClient> bidClient = [restClient getBidClient];
    
    BOOL bidRejected = [bidClient withdrawBidWithId:self.bidIdToReject andAccessToken:currentToken];
     
    if (bidRejected) {
        bidRejectResult.bidRejectStatus = MMAsyncBidRejectResultSuccess;
    } else {
        bidRejectResult.bidRejectStatus = MMAsyncBidRejectResultFailure;
    }
    
    return bidRejectResult;
}

@end
