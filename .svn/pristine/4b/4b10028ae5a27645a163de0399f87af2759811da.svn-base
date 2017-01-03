//
//  MockGUIRestDeligate.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MockGUIRestDeligate.h"

@implementation MockGUIRestDeligate

@synthesize credentialsManagement;
@synthesize restClient;
@synthesize token;
@synthesize logoutCalled;
@synthesize saveAccessTokenCalled;
@synthesize loadAccessTokenCalled;

- (id) init {
    self = [super init];
    if (self) {
        self.credentialsManagement = nil;
        self.restClient = nil;
        self.token = nil;
        self.logoutCalled = NO;
        self.saveAccessTokenCalled = NO;
        self.loadAccessTokenCalled = NO;
    
        return self;
    }
    
    return nil;
}

- (void) notImplemented {
    @throw [NSException exceptionWithName:NSGenericException reason:@"Not implemented" userInfo:nil];
}

-(id<MMRestClient>) getRestClient {
    return self.restClient;
}

-(id<CredentialsManagement>) getCredentialsManagement {
    return self.credentialsManagement;
}

-(void) showTabIndex: (NSUInteger) tabIndex andPopViewToRoot: (BOOL) popToRoot {
    [self notImplemented];
}

-(void) showLoginDialog: (NSInteger) completionIndex {
    [self notImplemented];
}

-(void) setAccessToken: (MMRestAccessToken*) accessToken {
    self.token = accessToken;
}

-(BOOL) saveAccessToken {
    self.saveAccessTokenCalled = YES;
    return YES;
}

-(BOOL) loadAccessToken {
    self.loadAccessTokenCalled = YES;
    return YES;
}

-(BOOL) isLoggedIn {
    return (!logoutCalled && self.token != nil);
}

-(void) logout {
    self.logoutCalled = YES;
    self.token = nil;
}

-(void) logoutWithoutPop {
    [self logout];
}

-(MMRestAccessToken*) getAccessToken {
    return self.token;
}

-(BOOL) getShouldUpdateMyJobs { [self notImplemented]; return NO; }
-(BOOL) getShouldUpdateRecentJobs { [self notImplemented]; return NO; }
-(BOOL) getShouldUpdateMatchingJobs { [self notImplemented]; return NO; }
-(BOOL) getShouldUpdateJobDetail { [self notImplemented]; return NO; }
-(BOOL) getShouldUpdateBids { [self notImplemented]; return NO; }
-(void) setShouldUpdateMyJobs: (BOOL) updateJobs { [self notImplemented]; }
-(void) setShouldUpdateRecentJobs: (BOOL) updateJobs { [self notImplemented]; }
-(void) setShouldUpdateMatchingJobs: (BOOL) updateJobs { [self notImplemented]; }
-(void) setShouldUpdateJobDetail: (BOOL) updateDetail { [self notImplemented]; }
-(void) setShouldUpdateBids:(BOOL)updateBids { [self notImplemented]; }

-(UIViewController*) getRootViewController { [self notImplemented]; return nil; }

-(UIWindow*) getWindow { [self notImplemented]; return nil; }

@end
