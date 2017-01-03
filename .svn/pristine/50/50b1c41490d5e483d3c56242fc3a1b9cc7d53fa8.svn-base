//
//  MMLoginActivityLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 22/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMLoginActivityLogicUnitTest.h"

#import "MMAsyncActivityManagement.h"
#import "MMAsyncActivityManagementImpl.h"
#import "MMLoginAsyncActivity.h"
#import "MMRestAuthorisationClient.h"
#import "MMRestClient.h"
#import "MMRestClientFactoryImpl.h"
#import "MMLoginActivityResult.h"
#import "MMException.h"

#import "MMMockAsyncActivityDelegate.h"

#import "MockCredentialsManagement.h"

#import "AppDelegateMMRestClientUtils.h"
#import "UnitTestHelper.h"
#import "OCMock.h"

@implementation MMLoginActivityLogicUnitTest

- (void) setUp {
    [super setUp];
    
    meemeepURL = [[AppDelegateMMRestClientUtils getMMRestConfiguration] objectForKey:@"MeeMeepRestClientURL"];
}


// All code under test must be linked into the Unit Test bundle
- (void)testLoginSuccess {
    NSString *email = @"user@unico.com.au";
    //NSString *email = @"greg.soertsz@unico.com.au";
    NSString *password = @"testing1";
    
    // mock out the activity delegate
    MMMockAsyncActivityDelegate *mockDelegate = [[MMMockAsyncActivityDelegate alloc] init];
    
    id<CredentialsManagement> mockCredentialsMgmt = [[MockCredentialsManagement alloc] init];
    
    id restClient = [UnitTestHelper mockRestClient];
    id authClient = [UnitTestHelper mockRestAuthorisationClient];
    id userClient = [UnitTestHelper mockRestUserClient];
    [UnitTestHelper addGetClientExpectations:restClient authClient:authClient userClient:userClient jobsClient:nil];
    
    id restAccessToken = [UnitTestHelper mockRestAccessToken];
    id restUserProfile = [UnitTestHelper mockUserProfile];
    
    [UnitTestHelper addGetUserProfileForTokenExpectations:userClient token:restAccessToken returnProfile:restUserProfile exception:nil];
    
    [UnitTestHelper addLoginWithEmailExpectations:authClient email:email password:password returnToken:restAccessToken exception:nil];
    
    MMLoginAsyncActivity *loginActivity = [[MMLoginAsyncActivity alloc] initWithActivityDelegate:mockDelegate andRestClient:restClient loginEmail:email loginPassword:password credentialsManagement:mockCredentialsMgmt];
    
    id<MMAsyncActivityManagement> activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
    
    [activityManagement dispatchMMAsyncActivity:loginActivity];
    
    // wait for the job to complete
    DLog(@"Waiting for login activity to complete!");
    [loginActivity waitUntilFinished];
    
    // check that the delegate was updated correctly
    
    id<MMAsyncActivityResult> result = mockDelegate.activityResult;

    MMLoginActivityResult *loginResult = (MMLoginActivityResult *) result;
        
    MMRestAccessToken *token = loginResult.loginResultAccessToken;
    
    STAssertNotNil(token, @"Received access token was nil");
    STAssertEquals(restAccessToken, token, @"Access token differs");
    
    MMUserProfile* userProfile =  loginResult.loginResultUserProfile;
    STAssertNotNil(token, @"Received user profile was nil");
    STAssertEquals(restUserProfile, userProfile, @"User profile differs");
    
    [restClient verify];
    [authClient verify];
    [userClient verify];
    [restAccessToken verify];
    [restUserProfile verify];
}

- (void)testLoginFailure {
    NSString *email = @"user@unico.com.au";
    NSString *password = @"foobar";
    
    // mock out the activity delegate
    MMMockAsyncActivityDelegate *mockDelegate = [[MMMockAsyncActivityDelegate alloc] init];
    
    id<CredentialsManagement> mockCredentialsMgmt = [[MockCredentialsManagement alloc] init];
    
    id restClient = [UnitTestHelper mockRestClient];
    id authClient = [UnitTestHelper mockRestAuthorisationClient];
    [UnitTestHelper addGetClientExpectations:restClient authClient:authClient userClient:nil jobsClient:nil];
    NSError* restError = [NSError errorWithDomain:@"Error" code:401 userInfo:nil];
    NSException* loginException = [[MMException alloc] initWithReason:@"Error"
                                                             userInfo:nil nestedError:restError];

        
    [UnitTestHelper addLoginWithEmailExpectations:authClient email:email password:password returnToken:nil exception:loginException];
        
    MMLoginAsyncActivity *loginActivity = [[MMLoginAsyncActivity alloc] initWithActivityDelegate:mockDelegate andRestClient:restClient loginEmail:email loginPassword:password credentialsManagement:mockCredentialsMgmt];
    
    id<MMAsyncActivityManagement> activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
    
    [activityManagement dispatchMMAsyncActivity:loginActivity];
    
    // wait for the job to complete
    DLog(@"Waiting for login activity to complete!");
    [loginActivity waitUntilFinished];
    
    // check that the delegate was updated correctly
    
    NSError *error = mockDelegate.activityError;
    STAssertNotNil(error, @"Error object should have been set");
    
    STAssertTrue(error.code == 401, @"Error codes did not match");
    
    STAssertNil([mockCredentialsMgmt getCredentials], @"Credentials should not be set on auth failure");
    // confirm error code was not authorized!
    [restClient verify];
    [authClient verify];
}

@end
