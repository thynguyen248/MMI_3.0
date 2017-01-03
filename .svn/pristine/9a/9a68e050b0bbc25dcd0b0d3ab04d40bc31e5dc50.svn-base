//
//  MMRetrieveBidSummaryAsyncActivity.m
//  ;;
//
//  Created by Greg Soertsz on 24/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRetrieveBidSummaryAsyncActivity.h"
#import "MMRetrieveBidSummaryListActvityResult.h"
#import "MMRestJobsClient.h"

@implementation MMRetrieveBidSummaryAsyncActivity

@synthesize jobId;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>)restD forJobId:(NSNumber *) jId {
    self = [super initWithActivityDelegate:d restDelegate:restD];
    if (self) {
        self.jobId = jId;
        return self;
    }
    
    return nil;
}

- (id<MMAsyncActivityResult>) performAction {
    if (self.jobId == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Job Id to to retrieve bids was nil" userInfo:nil];
    
    id<MMRestClient> restClient = [restDelegate getRestClient];
    MMRestAccessToken *currentToken = [restDelegate getAccessToken];
    
    id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
    
    MMRetrieveBidSummaryListActvityResult *res = [[MMRetrieveBidSummaryListActvityResult alloc] init];
    
    NSArray *bidSummaryList = [jobsClient getBidSummaryListForJobId:self.jobId andAccessToken:currentToken];
    
    if (bidSummaryList == nil) @throw [NSException exceptionWithName:NSGenericException reason:@"Bid summary was empty" userInfo:nil];
    
    res.retrievedBidSummaryList = bidSummaryList;
        
    return res;
}

@end
