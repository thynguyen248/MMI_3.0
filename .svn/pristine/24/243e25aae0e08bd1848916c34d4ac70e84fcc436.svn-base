//
//  KeychainCredentialsManagementImpl.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KeychainCredentialsManagementImpl.h"
#import <Security/Security.h>

@implementation KeychainCredentialsManagementImpl

- (void) storeCredentials:(Credentials *) creds {
    NSMutableDictionary *searchQuery = [self newSearchDictionary:@"MeeMeepCredentials"];
    
    NSData *existing = [self searchKeychainCopyMatching:@"MeeMeepCredentials"];
    
    if (existing) { 
        SecItemDelete((CFDictionaryRef) searchQuery);
        //[existing release];
    }
    
    NSData *credentialData = [self encodeCredentials:creds];
    [searchQuery setObject:credentialData forKey:(id)kSecValueData];
    OSStatus status = SecItemAdd((CFDictionaryRef) searchQuery, NULL);
    if (status != errSecSuccess) {
        @throw [NSException exceptionWithName:NSGenericException reason:@"Could not add credential" userInfo:nil];
    }

    [searchQuery release];
}

- (Credentials *) getCredentials {
    // search the dictionary for the keychain item
    NSData *itemData = [self searchKeychainCopyMatching:@"MeeMeepCredentials"];
    
    if (itemData) {
        Credentials *creds = [self decodeCredentials:itemData];
        //[itemData release];
        
        return creds;
    }
    
    return nil;
}

- (NSData *) encodeCredentials:(Credentials *) creds {
    if (creds == nil) return nil;

    NSMutableDictionary *credDict = [[NSMutableDictionary alloc] init];
    [credDict setObject:creds.email forKey:@"email"];
    [credDict setObject:creds.password forKey:@"password"];
    
    NSData *credData = [NSKeyedArchiver archivedDataWithRootObject:credDict];
    
    [credDict release];
    
    return credData;
}

- (Credentials *) decodeCredentials:(NSData *) valueData {
    if (valueData == nil) return nil;

    id obj = [NSKeyedUnarchiver unarchiveObjectWithData:valueData];
    
    if (obj && [obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *credDict = (NSDictionary *) obj;
        
        Credentials *c = [[[Credentials alloc] init] autorelease];
        c.email = [credDict objectForKey:@"email"];
        c.password = [credDict objectForKey:@"password"];
        return c;
    } else return nil;
}

- (NSMutableDictionary *)newSearchDictionary:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];  
	
    [searchDictionary setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(id)kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(id)kSecAttrAccount];
    [searchDictionary setObject:@"com.meemeep.MeeMeepMobile" forKey:(id)kSecAttrService];
	    
    return searchDictionary; 
}

- (NSData *)searchKeychainCopyMatching:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
	
    // Add search attributes
    [searchDictionary setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
	
    // Add search return types
    [searchDictionary setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
	
    NSData *result = nil;
    // unused OSStatus status = 
    SecItemCopyMatching((CFDictionaryRef)searchDictionary, (CFTypeRef *)&result);
    [searchDictionary release];
    return [result autorelease];
}

@end
