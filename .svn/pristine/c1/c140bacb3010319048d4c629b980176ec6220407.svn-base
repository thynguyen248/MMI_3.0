//
//  MockGUIRestDeligate.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GUIRestDeligate.h"

@interface MockGUIRestDeligate : NSObject<GUIRestDeligate> {
    id<CredentialsManagement> credentialsManagement;
    id<MMRestClient> restClient;
    MMRestAccessToken *token;
    BOOL logoutCalled;
    BOOL saveAccessTokenCalled;
    BOOL loadAccessTokenCalled;
}

@property (strong, nonatomic) id<CredentialsManagement> credentialsManagement;
@property (strong, nonatomic) id<MMRestClient> restClient;
@property (strong, nonatomic) MMRestAccessToken *token;
@property (assign, nonatomic) BOOL logoutCalled;
@property (assign, nonatomic) BOOL saveAccessTokenCalled;
@property (assign, nonatomic) BOOL loadAccessTokenCalled;

- (void) notImplemented;

@end
