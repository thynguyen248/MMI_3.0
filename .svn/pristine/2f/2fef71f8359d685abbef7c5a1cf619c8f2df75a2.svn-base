//
//  UserSessionManagementImpl.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 10/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "UserSessionManagementImpl.h"

@implementation UserSessionManagementImpl


-(id)initWithRestClient: (id<MMRestClient>) myRestClient andLogoutNotification: (id<LogoutNotification>) notification {
    self = [self init];
    if (self){
        restClient = myRestClient;
        logoutNotification = notification;
        
        fileSystem = [[FileSystemImpl alloc] init];
        
        accessToken = [fileSystem loadAccessToken];
        
        return self;
    } else return nil;    
    
}




-(MMRestAccessToken*) loginWith: (NSString*) email andPassword: (NSString*) password{
    
    id<MMRestAuthorisationClient> authClient = [restClient getAuthorisationClient];
    accessToken = [authClient loginWithEmail:email andPassword:password];
    
    [fileSystem saveAccessToken:accessToken];
    
    return accessToken;
}




-(MMRestAccessToken*) getAccessToken{
    return accessToken;
}




-(BOOL) isLoggedIn{    
    if (accessToken!=nil) return true;
    else return false;
}




-(void) logout{
    
    id<MMRestAuthorisationClient> authClient = [restClient getAuthorisationClient];
    [authClient logoutWith: accessToken];
    accessToken = nil;
    
    [fileSystem deleteAccessToken];
    
    [logoutNotification notifyLogout];
    
}



@end
