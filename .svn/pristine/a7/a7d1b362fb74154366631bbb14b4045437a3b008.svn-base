//
//  MeeMeepFileSystemSavingLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 10/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "MeeMeepFileSystemSavingLogicUnitTest.h"

#import "FileSystemImpl.h"

@implementation MeeMeepFileSystemSavingLogicUnitTest


-(void) testFileSystemSavingSuccess{
    BOOL errorOccured = false;
    
    MMRestAccessToken* accessToken = [[MMRestAccessToken alloc] init];
    accessToken.userId = [NSNumber numberWithInt:4];
    accessToken.accessToken = @"BLARG";
    
    FileSystemImpl* fileSystem = [[FileSystemImpl alloc] init];
    
    @try {
        [fileSystem saveAccessToken:accessToken];
    }
    @catch (NSException *exception) {
        errorOccured=true;
    }
    
    STAssertFalse(errorOccured, @"Could not save access token");
}




-(void) testFileSystemSavingFailed{
    BOOL errorOccured = false;
    
    MMRestAccessToken* accessToken;
    
    FileSystemImpl* fileSystem = [[FileSystemImpl alloc] init];
    
    @try {
        [fileSystem saveAccessToken:accessToken];
    }
    @catch (NSException *exception) {
        errorOccured=true;
    }
    
    STAssertTrue(errorOccured, @"Should not have been able to save accesstoken - it doesnt exist");
}





@end