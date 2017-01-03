//
//  MMRetrieveJobDetailAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 24/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRetrieveJobDetailAsyncActivity.h"
#import "MMRetrieveJobDetailActivityResult.h"

@implementation MMRetrieveJobDetailAsyncActivity

@synthesize jobIdToRetrieve;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD jobIdToRetrieve:(NSNumber*) jobId {
    self = [super initWithActivityDelegate:d restDelegate:restD];
    if (self) {
        self.jobIdToRetrieve = jobId;
        return self;
    }
    
    return nil;
}

- (id<MMAsyncActivityResult>) performAction {
    if (self.jobIdToRetrieve == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"ID for job detail to retrieve was nil" userInfo:nil];
    
    id<MMRestClient> restClient = [restDelegate getRestClient];
    MMRestAccessToken *currentToken = [restDelegate getAccessToken];

    id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
    
    MMJobDetail *retrievedJobDetail = [jobsClient getJobDetailForJobId:self.jobIdToRetrieve withToken:currentToken];
    
    if (retrievedJobDetail == nil) {
        @throw [NSException exceptionWithName:NSGenericException reason:@"Retrieved job detail was nil" userInfo:nil];
    }
    
    MMRetrieveJobDetailActivityResult *activityResult = [[MMRetrieveJobDetailActivityResult alloc] init];
    
    activityResult.retrievedDetail = retrievedJobDetail;
    
    return activityResult;
}

@end
