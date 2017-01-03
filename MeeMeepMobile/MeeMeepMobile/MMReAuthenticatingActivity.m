//
//  MMReAuthenticatingActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMReAuthenticatingActivity.h"

#import "MMException.h"

@implementation MMReAuthenticatingActivity

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
    if (self.restDelegate == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Rest client to retrieve user jobs was nil" userInfo:nil];
    
    @try {
        return [self performAction];
    } @catch (MMException *ex) {
        if ([ex.containedError code] != 401) @throw ex;
        
        // if we had an access token we had obviously logged in previously
        // log back in.
        if ([restDelegate getAccessToken] != nil) {
            [restDelegate logoutWithoutPop];
            
            // we've lost the session
            // let's login using the stored credentials and retry once
            id<CredentialsManagement> credentialsManagement = [restDelegate getCredentialsManagement];
            Credentials *storedCredentials = [credentialsManagement getCredentials];
            if (storedCredentials == nil) @throw ex;
            
            // try logging in again
            id<MMRestClient> restClient = [restDelegate getRestClient];
            id<MMRestAuthorisationClient> authClient = [restClient getAuthorisationClient];
            MMRestAccessToken *newToken = [authClient loginWithEmail:storedCredentials.email andPassword:storedCredentials.password];
            
            [restDelegate setAccessToken:newToken];
            // try the action again - otherwise throw the exception normally
            return [self performAction];
        } else {
            @throw ex;
        }
    } 
}

- (id<MMAsyncActivityResult>) performAction {
    @throw [NSException exceptionWithName:NSGenericException reason:@"Not implemented" userInfo:nil]; 
}

@end
