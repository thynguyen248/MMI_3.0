//
//  UserSessionManagementImpl.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 10/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "UserSessionManagement.h"

#import "LogoutNotification.h"

#import "MMRestClient.h"


#import "FileSystemImpl.h"


@interface UserSessionManagementImpl : NSObject<UserSessionManagement>{

    id<LogoutNotification> logoutNotification;
    
    MMRestAccessToken* accessToken;
    
    id<MMRestClient> restClient;
    
    id<FileSystem> fileSystem;
    
    
}

-(id)initWithRestClient: (id<MMRestClient>) myRestClient andLogoutNotification: (id<LogoutNotification>) notification;


@end
