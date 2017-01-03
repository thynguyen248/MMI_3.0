//
//  LogoutListenerManagementImpl.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 10/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LogoutNotification.h"

#import "LogoutListener.h"

@interface LogoutNotificationImpl : NSObject <LogoutNotification> {

    NSMutableArray* listeners;
    
}

-(void) addListener: (id<LogoutListener>) listener;

@end
