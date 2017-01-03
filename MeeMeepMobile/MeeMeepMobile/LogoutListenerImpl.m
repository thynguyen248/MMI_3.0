//
//  LogoutListenerImpl.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 10/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "LogoutListenerImpl.h"

@implementation LogoutListenerImpl


@synthesize wasCalled;

- (id) init {
    self = [super init];
    if (self) {
        wasCalled = NO;
        return self;
    } else return nil;
}

-(void) onLogout{
    wasCalled = YES;
}

@end
