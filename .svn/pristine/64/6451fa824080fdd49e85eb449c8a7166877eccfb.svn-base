//
//  MMRetrieveMyJobSummaryListActivity.m
//  MeeMeepMobile
//
//  Created by Julian Raff on 26/03/13.
//
//

#import "MMRetrieveMatchingJobSummaryListActivity.h"

#import "MMRetrieveJobsSummaryListActivityResult.h"

@implementation MMRetrieveMatchingJobSummaryListActivity

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD; {
    self = [super initWithActivityDelegate:d restDelegate:restD];
    if (self) {
        return self;
    }
    
    return nil;
    
}


- (id<MMAsyncActivityResult>) performAction {
    // retrieve the jobs from the API;
    
    // initialise API first
    id<MMRestClient> restClient = [restDelegate getRestClient];
    
    id<MMRestUserClient> userClient = [restClient getUserClient];
    
    NSArray *jobSummaryList = [userClient getMatchingJobsForUserWithToken:[restDelegate getAccessToken]];
    
    MMRetrieveJobsSummaryListActivityResult *result = [[MMRetrieveJobsSummaryListActivityResult alloc] init];
    
    result.jobSummaryList = jobSummaryList;
    
    return result;
}

@end
