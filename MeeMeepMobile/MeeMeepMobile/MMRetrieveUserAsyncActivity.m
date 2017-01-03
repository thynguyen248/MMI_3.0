//
//  MMRetrieveUserJobsAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Julian Raff on 4/03/13.
//

#import "MMRetrieveUserAsyncActivity.h"
#import "MMRetrieveUserActivityResult.h"

#import "MMException.h"

@implementation MMRetrieveUserAsyncActivity

- (MMRetrieveUserActivityResult *) performAction {
    // try the operation
    MMRestAccessToken *accessToken = [restDelegate getAccessToken];
    
    id<MMRestClient> restClient = [restDelegate getRestClient];
    
    id<MMRestUserClient> userClient = [restClient getUserClient];
    
    MMUserProfile* userProfile = [userClient getUserProfileForToken:accessToken];
    
    MMRetrieveUserActivityResult *result = [[MMRetrieveUserActivityResult alloc] init];
    result.userProfile = userProfile;
    
    return result;
}

@end
