//
//  KeychainCredentialsManagementImpl.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CredentialsManagement.h"

@interface KeychainCredentialsManagementImpl : NSObject<CredentialsManagement>

- (NSData *) encodeCredentials:(Credentials *) creds;
- (Credentials *) decodeCredentials:(NSData *) valueData;

- (NSMutableDictionary *)newSearchDictionary:(NSString *)identifier;
- (NSData *)searchKeychainCopyMatching:(NSString *)identifier;

@end
