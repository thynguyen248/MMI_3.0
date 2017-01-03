//
//  LogoutListenerManagementImpl.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 10/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "LogoutNotificationImpl.h"

@implementation LogoutNotificationImpl



-(id) init{
    self = [super init];
    if (self){
        listeners = [[NSMutableArray alloc] init];
        return self;
    } else return nil;
}



-(void) addListener: (id<LogoutListener>) listener{
    [listeners addObject:listener];
}


-(void) notifyLogout{
    
    for(id<LogoutListener> listener in listeners){
        [listener onLogout];
    }
    
}

@end
