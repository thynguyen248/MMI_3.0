//
//  MMRegistrationAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRegistrationAsyncActivity.h"
#import "MMAsyncActivityResult.h"
#import "MMRegistrationAsyncActivityResult.h"

@implementation MMRegistrationAsyncActivity

@synthesize userProfile;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>)restD userProfile:(MMNewUser *)profile {
    self = [super initWithActivityDelegate:d restDelegate:restD];
    if (self) {        
        self.userProfile = profile;
        return self;
    }
    
    return nil;
}

- (id<MMAsyncActivityResult>) performAction {
    if (self.userProfile == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"User to register was nil" userInfo:nil];
        
    id<MMRestClient> restClient = [self.restDelegate getRestClient];
    
    id<MMRestUserClient> userClient = [restClient getUserClient];
    
    MMRegistrationAsyncActivityResult *result = [[MMRegistrationAsyncActivityResult alloc] init];
    result.status = MMAsyncRegistrationResultUndefined;
    
    // if so try to post the user profile
    
    if([userClient registerUserProfile:self.userProfile]) {
        result.Status = MMAsyncRegistrationResultSuccess;
        return result;
    } else {
        @throw [NSException exceptionWithName:NSGenericException reason:@"User Profile failed" userInfo:nil];
    }
}


@end
