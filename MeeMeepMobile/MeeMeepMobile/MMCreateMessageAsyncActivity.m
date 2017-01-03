//
//  MMCreateMessageAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMCreateMessageAsyncActivity.h"
#import "MMAsyncActivityResult.h"
#import "MMCreateMessageAsyncActivityResult.h"

@implementation MMCreateMessageAsyncActivity

@synthesize messageToCreate;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>)restD messageToCreate:(MMMessageDetail *)message{

    self = [super initWithActivityDelegate:d restDelegate:restD];
    if (self) {        
        self.messageToCreate = message;
        return self;
    }
    
    return nil;
}

// NEEDS UNIT Test update
- (id<MMAsyncActivityResult>) performAction {
    if (self.messageToCreate == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Message to create was nil" userInfo:nil];
    
    // use the jobs client to create a Message
    MMRestAccessToken *accessToken = [restDelegate getAccessToken];
    
    id<MMRestClient> restClient = [self.restDelegate getRestClient];
        
    MMCreateMessageAsyncActivityResult *result = [[MMCreateMessageAsyncActivityResult alloc] init];
    result.status = MMAsyncCreateMessageResultUndefined;
    
    // if so try to post the provided Message to the job
    
    id<MMRestMessageClient> messageClient = [restClient getMessageClient];
    
    if([messageClient sendMessage:self.messageToCreate withAccessToken:accessToken]) {
        result.status = MMAsyncCreateMessageResultSuccess;
        return result;
    } else {
        @throw [NSException exceptionWithName:NSGenericException reason:@"Message creation failed" userInfo:nil];
    }
}


@end
