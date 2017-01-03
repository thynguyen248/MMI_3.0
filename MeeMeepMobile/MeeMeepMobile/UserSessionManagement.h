//
//  UserSessionManagement.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 10/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestAccessToken.h"


#import "MMRestClient.h"



@protocol UserSessionManagement <NSObject>

-(BOOL) isLoggedIn;

-(void) logout;

-(MMRestAccessToken*) getAccessToken;


-(MMRestAccessToken*) loginWith: (NSString*) email andPassword: (NSString*) password;

@end
