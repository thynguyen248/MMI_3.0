//
//  MMRateUserAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMCompleteJobAsyncActivity.h"
#import "MMAsyncActivityResult.h"
#import "MMCompleteJobAsyncActivityResult.h"

@implementation MMCompleteJobAsyncActivity

@synthesize userRating;
@synthesize jobId;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>)restD rating:(MMUserRating *)rating {
    self = [super initWithActivityDelegate:d restDelegate:restD];
    if (self) {        
        self.userRating = rating;
        return self;
    }
    
    return nil;
}

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>)restD jobId:(NSNumber *)jobID {
    self = [super initWithActivityDelegate:d restDelegate:restD];
    if (self) {
        self.jobId = jobID;
        return self;
    }
    
    return nil;
}

- (id<MMAsyncActivityResult>) performAction {
    MMRestAccessToken *accessToken = [restDelegate getAccessToken];
    
    id<MMRestClient> restClient = [restDelegate getRestClient];
    
    id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
    
    MMCompleteJobAsyncActivityResult *result = [[MMCompleteJobAsyncActivityResult alloc] init];
    result.Status = MMAsyncRateUserResultUndefined;
    
    BOOL success = false;
    
    // As this class is used for both types of 'complete job' need to call the different functions
    
    DLog(@"User Rating: %@", userRating);
    DLog(@"Job ID: %@", jobId);
    
    if(userRating != nil)
    {
        success = [jobsClient customerCompleteJobWithRating:userRating withToken:accessToken];
    }
    else if(jobId != nil)
    {
        success = [jobsClient tpCompleteJob:jobId withToken:accessToken];
    }
    
    if(success) {
        result.Status = MMAsyncRateUserResultSuccess;
        return result;
    } else {
        @throw [NSException exceptionWithName:NSGenericException reason:@"Complete Job failed" userInfo:nil];
    }
}


@end
