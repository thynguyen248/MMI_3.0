//
//  MMRetrievejobMessagesAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 26/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRetrievejobMessagesAsyncActivity.h"
#import "MMRetrievejobMessagesAsyncActivityResult.h"

#import "MMException.h"

@implementation MMRetrieveJobMessagesAsyncActivity

@synthesize jobId;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>)restD jobId:(NSNumber*)aJobId {
    self = [super initWithActivityDelegate:d restDelegate:restD];
    if (self) {
        self.jobId = aJobId;
        return self;
    }
    
    return nil;
    
}

- (MMRetrieveJobMessagesAsyncActivityResult *) performAction {
    // try the operation
    MMRestAccessToken *accessToken = [restDelegate getAccessToken];
    
    id<MMRestClient> restClient = [restDelegate getRestClient];
    
    id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
    
    NSArray *jobMessages = [jobsClient getMessagesForJobWithId:jobId withToken:accessToken];
    
    if (jobMessages == nil) {
        @throw [NSException exceptionWithName:NSGenericException reason:@"jobs message list was nil after rest operation" userInfo:nil];
    }
    
    MMRetrieveJobMessagesAsyncActivityResult *result = [[MMRetrieveJobMessagesAsyncActivityResult alloc] init];
    
    result.messages = jobMessages;
    
    return result;
}


@end
