//
//  MMCreateJobAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 30/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMCreateJobAsyncActivity.h"
#import "MMCreateJobActivityResult.h"


@implementation MMCreateJobAsyncActivity

@synthesize jobToCreate;

- (id)initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD jobToCreate:(MMJobDetail *) job {
    self = [super initWithActivityDelegate:d restDelegate:restD];
    if (self) {
        self.jobToCreate = job;
        jobCreated = NO;
        return self;
    }
    return nil;
}


- (id<MMAsyncActivityResult>) performAction {
    if (self.jobToCreate == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Job detail to create was nil" userInfo:nil];
    
    MMCreateJobActivityResult *result = [[MMCreateJobActivityResult alloc] init];
    result.jobCreatedStatus = MMAsyncCreateJobStatusUndefined;
    
    id<MMRestClient> restClient = [restDelegate getRestClient];
    MMRestAccessToken *currentToken = [restDelegate getAccessToken];
    
    id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
    
    jobCreated = [jobsClient createJobWithDetail:self.jobToCreate andAccessToken:currentToken];
    
    if (jobCreated) {
        result.jobCreatedStatus = MMAsyncCreateJobStatusSuccess;
    } else {
        result.jobCreatedStatus = MMAsyncCreateJobStatusFailure;
    }
    
    return result;
}


@end
