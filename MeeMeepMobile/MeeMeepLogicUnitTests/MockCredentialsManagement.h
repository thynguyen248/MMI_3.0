//
//  MockCredentialsManagement.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CredentialsManagement.h"

@interface MockCredentialsManagement : NSObject<CredentialsManagement> {
    Credentials *storedCredentials;
}

@property (strong, nonatomic) Credentials *storedCredentials;

@end
