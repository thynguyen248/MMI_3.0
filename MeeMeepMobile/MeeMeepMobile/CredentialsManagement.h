//
//  CredentialsManagement.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Credentials.h"

@protocol CredentialsManagement <NSObject>

- (void) storeCredentials:(Credentials *) creds;
- (Credentials *) getCredentials;

@end
