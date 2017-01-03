//
//  MMRetrieveBidDetailAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 25/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRetrieveBidDetailAsyncActivity.h"
#import "MMRetrieveBidDetailActivityResult.h"

@implementation MMRetrieveBidDetailAsyncActivity

@synthesize bidId;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) rd bidId:(NSNumber *) bId {
    self = [super initWithActivityDelegate:d restDelegate:rd];
    if (self) {
        self.bidId = bId;
        return self;
    }
    
    return nil;
}

- (id<MMAsyncActivityResult>) performAction {
    if (self.bidId == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Bid id to retrieve detail was nil" userInfo:nil];
    
    id<MMRestClient> restClient = [restDelegate getRestClient];
    
    MMRestAccessToken *currentAccessToken = [restDelegate getAccessToken];
    
    id<MMRestBidClient> bidClient = [restClient getBidClient];
    
    MMBidDetail *bidDetail = [bidClient getBidDetailWithId:self.bidId andAccessToken:currentAccessToken];
    
    if (bidDetail == nil) @throw [NSException exceptionWithName:NSGenericException reason:@"Bid detail retrieved was nil" userInfo:nil];
    
    MMRetrieveBidDetailActivityResult *res = [[MMRetrieveBidDetailActivityResult alloc] init];
    
    res.retrievedBidDetail = bidDetail;
    
    return res;
}

@end
