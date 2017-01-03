//
//  MMLogoutAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 2/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMLogoutAsyncActivity.h"
#import "MMLogoutActivityResult.h"
#import "CredentialsManagement.h"

@implementation MMLogoutAsyncActivity

@synthesize restDelegate;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD {
    self = [super initWithActivityDelegate:d];
    if (self) {
        self.restDelegate = restD;
        return self;
    }
    
    return nil;
}

- (id<MMAsyncActivityResult>) doWork {
    if (self.restDelegate == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate to log out with was nil" userInfo:nil];

    id<MMRestClient> restClient = [restDelegate getRestClient];
    
    id<MMRestAuthorisationClient> authClient = [restClient getAuthorisationClient];
    
    MMRestAccessToken *currentToken = [restDelegate getAccessToken];
    
    @try {
        [authClient logoutWith:currentToken];
        // clear the password credential
        
        // remove session state information from the app
        [self.restDelegate logoutWithoutPop];
    } @catch (NSException *anyEx) {
        DLog(@"Server not available");
        // logout should always be successful
    }
    
    // don't try to remove the users credentials
    // but consider bringing into this transaction, clearing the session from the rest deligate
    
    MMLogoutActivityResult *res = [[MMLogoutActivityResult alloc] init];
    
    return res;
}

@end
