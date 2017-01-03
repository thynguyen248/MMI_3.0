//
//  MMRetrieveJobSummaryListActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 23/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRetrieveJobSummaryListActivity.h"

#import "MMRetrieveJobsSummaryListActivityResult.h"

@implementation MMRetrieveJobSummaryListActivity

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD; {
    self = [super initWithActivityDelegate:d restDelegate:restD];
    if (self) {
        return self;
    }
    
    return nil;
    
}


- (id<MMAsyncActivityResult>) doWork {    
    // retrieve the jobs from the API;
    
    // initialise API first
    id<MMRestClient> restClient = [restDelegate getRestClient];
    
    id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
    
    NSArray *jobSummaryList = [jobsClient getRecentlyPostedSummaryJobsWithAccessToken:[restDelegate getAccessToken]];
    
    MMRetrieveJobsSummaryListActivityResult *result = [[MMRetrieveJobsSummaryListActivityResult alloc] init];
    
    result.jobSummaryList = jobSummaryList;
    
    return result;            
}

@end
