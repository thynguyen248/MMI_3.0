//
//  CredentialsManagementImpl.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CredentialsManagementImpl.h"

@implementation CredentialsManagementImpl

@synthesize filePath;

- (id) initWithPath:(NSString *) path {
    self = [super init];
    if (self) {
        self.filePath = path;
        return self;
    }
    
    return nil;
}

- (void) storeCredentials:(Credentials *)creds {
    
    NSMutableDictionary * rootObject;
    rootObject = [NSMutableDictionary dictionary];
    
    [rootObject setValue: creds.email forKey:@"email"];
    [rootObject setValue: creds.password forKey:@"password"];
    
    //Delete saved file containing credentials
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:self.filePath error:NULL];
    
    [NSKeyedArchiver archiveRootObject:rootObject toFile: self.filePath];
}

- (Credentials *) getCredentials {
    NSDictionary *rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:self.filePath];
    
    if (rootObject) {
        //an acccess token has been saved
        Credentials *credentials = [[Credentials alloc] init];        
        credentials.email = [rootObject valueForKey:@"email"];
        credentials.password = [rootObject valueForKey:@"password"];

        return credentials;
    } else return nil;
}

@end
