//
//  MMLoginAsyncActivity.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 22/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMAsyncActivity.h"

#import "MMRestClient.h"
#import "CredentialsManagement.h"

@interface MMLoginAsyncActivity : MMAsyncActivity {
    id<MMRestClient> restClient;
    NSString *email;
    NSString *password;
    
    id<CredentialsManagement> credentialsManagement;
}

@property (strong, nonatomic) id<MMRestClient> restClient;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) id<CredentialsManagement> credentialsManagement;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>) d andRestClient:(id<MMRestClient>) restClient loginEmail:(NSString *) email loginPassword:(NSString *) password credentialsManagement:(id<CredentialsManagement>) credManagement;

@end
