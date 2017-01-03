//
//  MeeMeepFileSystemLoadingLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 10/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "MeeMeepFileSystemLoadingLogicUnitTest.h"

#import "FileSystemImpl.h"


@implementation MeeMeepFileSystemLoadingLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testMath
{
    STAssertTrue((1 + 1) == 2, @"Compiler isn't feeling well today :-(");
}



-(void) testFileSystemLoadingSuccess{
    /*
    //Make sure access token file exists
    
    BOOL errorOccured = false;
    @try {
        MMRestAccessToken* accessToken1 = [[MMRestAccessToken alloc] init];
        accessToken1.userId = [NSNumber numberWithInt:4];
        accessToken1.accessToken = @"BLARG";
        FileSystemImpl* fileSystem1 = [[FileSystemImpl alloc] init];
        [fileSystem1 saveAccessToken:accessToken1];
    }
    @catch (NSException *exception) {
        errorOccured=true;
    }
    STAssertFalse(errorOccured, @"Error generating access token");
    errorOccured = false;

    
    FileSystemImpl* fileSystem = [[FileSystemImpl alloc] init];
    MMRestAccessToken* accessToken = [fileSystem loadAccessToken];
    
    STAssertNotNil(accessToken, @"Could not load accessToken");
     */
}




-(void) testFileSystemLoadingFailed{
    FileSystemImpl* fileSystem = [[FileSystemImpl alloc] init];
    
    
    //Make sure its deleted
    @try {[fileSystem deleteAccessToken];}@catch (NSException *exception){}

    
    MMRestAccessToken* accessToken = [fileSystem loadAccessToken];
    
    STAssertNil(accessToken, @"Should not have been able to retrieve access token");
}




@end
