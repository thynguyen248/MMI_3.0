//
//  MMRetrieveUserMessagesAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 26/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRetrieveUserMessagesAsyncActivity.h"
#import "MMRetrieveUserMessagesAsyncActivityResult.h"

#import "MMException.h"

@implementation MMRetrieveUserMessagesAsyncActivity

- (MMRetrieveUserMessagesAsyncActivityResult *) performAction {
    // try the operation
    MMRestAccessToken *accessToken = [restDelegate getAccessToken];
    
    id<MMRestClient> restClient = [restDelegate getRestClient];
    
    id<MMRestUserClient> userClient = [restClient getUserClient];
    
    NSArray *messages = [userClient getMessagesForUserWithToken:accessToken];
    
    if (messages == nil) {
        @throw [NSException exceptionWithName:NSGenericException reason:@"user message list was nil after rest operation" userInfo:nil];
    }
    
    MMRetrieveUserMessagesAsyncActivityResult *result = [[MMRetrieveUserMessagesAsyncActivityResult alloc] init];
    
    result.messages = messages;
    
    return result;
}


@end
