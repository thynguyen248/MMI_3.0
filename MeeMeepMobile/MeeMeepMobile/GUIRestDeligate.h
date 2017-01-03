//
//  restDeligate.h
//  MeeMeepMobile
//
//  
//
//  Created by Aydan Bedingham on 8/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMRestClient.h"
#import "CredentialsManagement.h"

@protocol GUIRestDeligate <NSObject>



-(id<MMRestClient>) getRestClient;

-(id<CredentialsManagement>) getCredentialsManagement;

-(void) showTabIndex: (NSUInteger) tabIndex andPopViewToRoot: (BOOL) popToRoot;

-(void) showLoginDialog: (NSInteger) completionIndex;

-(void) setAccessToken: (MMRestAccessToken*) accessToken;

-(BOOL) saveAccessToken;

-(BOOL) loadAccessToken;

-(BOOL) isLoggedIn;

-(void) logout;

-(void) logoutWithoutPop;

-(MMRestAccessToken*) getAccessToken;

-(MMUserProfile*) getUserProfile;

-(void) setUserProfile:(MMUserProfile*)userProfile;

-(BOOL) getShouldUpdateMyJobs;

-(BOOL) getShouldUpdateRecentJobs;

-(BOOL) getShouldUpdateMatchingJobs;

-(BOOL) getShouldUpdateJobDetail;

-(BOOL) getShouldUpdateBids;

-(void) setShouldUpdateMyJobs: (BOOL) updateJobs;

-(void) setShouldUpdateRecentJobs: (BOOL) updateJobs;

-(void) setShouldUpdateMatchingJobs: (BOOL) updateJobs;

-(void) setShouldUpdateJobDetail: (BOOL) updateDetail;

-(void) setShouldUpdateBids: (BOOL) updateBids;

-(UIViewController*) getRootViewController;

-(UIWindow*) getWindow;

-(MMConfig*) getConfig;

@end
