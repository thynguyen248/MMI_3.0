//
//  MMCreateBidAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMCreateBidAsyncActivity.h"
#import "MMAsyncActivityResult.h"
#import "MMCreateBidActivityResult.h"

@implementation MMCreateBidAsyncActivity

@synthesize bidToCreate;
@synthesize jobId;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD bidToCreate:(MMBidDetail *) bid forJobId:(NSInteger) jid {

    self = [super initWithActivityDelegate:d restDelegate:restD];
    if (self) {        
        self.bidToCreate = bid;
        self.jobId = jid;
        return self;
    }
    
    return nil;
}

// NEEDS UNIT Test update
- (id<MMAsyncActivityResult>) performAction {
    if (self.bidToCreate == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Bid to create was nil" userInfo:nil];
    if (self.jobId < 0) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Job ID was invalid" userInfo:nil];
    
    // use the jobs client to create a bid
    MMRestAccessToken *accessToken = [restDelegate getAccessToken];
    
    id<MMRestClient> restClient = [self.restDelegate getRestClient];
    
    MMCreateBidActivityResult *result = [[MMCreateBidActivityResult alloc] init];
    result.bidCreateStatus = MMAsyncBidCreateResultUndefined;
    
    id<MMRestBidClient> bidClient = [restClient getBidClient];
    
    if([bidClient createBidWithDetail:self.bidToCreate forJobWithId:self.jobId withAccessToken:accessToken]) {
        result.bidCreateStatus = MMAsyncBidCreateResultSuccess;
        return result;
    } else {
        @throw [NSException exceptionWithName:NSGenericException reason:@"Bid creation failed" userInfo:nil];
    }
}


@end
