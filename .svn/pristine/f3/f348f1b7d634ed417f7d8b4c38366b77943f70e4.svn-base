//
//  MMJobSearchAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMJobSearchAsyncActivity.h"
#import "MMNamedJobSearchRequest.h"
#import "MMJobSearchAsyncActivityResult.h"

@implementation MMJobSearchAsyncActivity

- (id<MMAsyncActivityResult>) performAction {
    id<MMRestClient> restClient = [restDelegate getRestClient];
    MMRestAccessToken *token = [restDelegate getAccessToken];
    id<MMRestUserClient> userClient = [restClient getUserClient];
    
    MMJobSearchAsyncActivityResult *activityResult = [[MMJobSearchAsyncActivityResult alloc] init];
    
    // get Posted jobs
    activityResult.postedArray = [userClient getMyPostedJobsWithAccessToken:token];
    
    // get Moving jobs if transport provider
    if([[restDelegate getUserProfile] isTransportProvider]) {
        activityResult.movingDictionary = [userClient getMyMovingJobsWithAccessToken:token];
    }
    return activityResult;
}

@end
