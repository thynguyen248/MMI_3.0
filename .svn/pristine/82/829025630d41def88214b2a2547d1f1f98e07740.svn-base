//
//  MeeMeepLogoutNotificationLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 10/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "MeeMeepLogoutNotificationLogicUnitTest.h"


#import "LogoutListener.h"

#import "LogoutListenerImpl.h"

#import "LogoutNotification.h"

#import "LogoutNotificationImpl.h"

@implementation MeeMeepLogoutNotificationLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testLogoutNotificationSuccess {
    
    LogoutNotificationImpl* logoutNotification = [[LogoutNotificationImpl alloc] init];
    
    LogoutListenerImpl* logoutListener = [[LogoutListenerImpl alloc] init];
    
    [logoutNotification addListener:logoutListener];
    STAssertFalse(logoutListener.wasCalled, @"Logout listener not initialised as not called");
    [logoutNotification notifyLogout];
    
    
    STAssertTrue(logoutListener.wasCalled, @"LogoutListener wasnt called");
}

@end
