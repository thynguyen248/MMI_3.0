//
//  MMLoginAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 22/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMLoginAsyncActivity.h"
#import "MMLoginActivityResult.h"
#import "MMRestAuthorisationClient.h"

@implementation MMLoginAsyncActivity

@synthesize restClient;
@synthesize email;
@synthesize password;
@synthesize credentialsManagement;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>) d andRestClient:(id<MMRestClient>) client loginEmail:(NSString *) e loginPassword:(NSString *) pw credentialsManagement:(id<CredentialsManagement>)credManagement {
    self = [super initWithActivityDelegate:d];
    
    if (self) {
        self.email = e;
        self.password = pw;
        self.restClient = client;
        self.credentialsManagement = credManagement;
        return self;
    }
    
    return nil;
}

- (id<MMAsyncActivityResult>) doWork { 
    
    if (!self.email) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Email was nil" userInfo:nil];
    if (!self.password) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Password was nil" userInfo:nil];
    
    id<MMRestAuthorisationClient> authClient = [self.restClient getAuthorisationClient];
    
    MMRestAccessToken *token = [authClient loginWithEmail:self.email andPassword:self.password];
    
    if (token != nil) {
        Credentials *creds = [[Credentials alloc] init];
        creds.email = self.email;
        creds.password = self.password;
        [credentialsManagement storeCredentials:creds];
        
        MMUserProfile* userProfile = [[restClient getUserClient] getUserProfileForToken:token];
        
        MMLoginActivityResult *result = [[MMLoginActivityResult alloc] initWithAccessToken:token andUserProfile:userProfile];
        return result;
    } else {
        @throw [NSException exceptionWithName:NSGenericException reason:@"Token was nil after login" userInfo:nil];
    }

}

@end
