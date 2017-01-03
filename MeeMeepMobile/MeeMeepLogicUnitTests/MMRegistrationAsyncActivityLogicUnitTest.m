//
//  MMRegistrationAsyncActivityLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 30/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRegistrationAsyncActivityLogicUnitTest.h"
#import "MMMockAsyncActivityDelegate.h"
#import "MMRestClientFactory.h"
#import "MMRestClientFactoryImpl.h"
#import "MMRestAuthorisationClient.h"
#import "MMAsyncActivityManagement.h"
#import "MMAsyncActivityManagementImpl.h"
#import "MMRegistrationAsyncActivity.h"
#import "MMRegistrationAsyncActivityResult.h"
#import "MMRestJobsClient.h"

#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"

#import "MMMockHttpTransmissionGetMatcherImpl.h"
#import "MMMockRestHttpTransmissionImpl.h"
#import "MockGUIRestDeligate.h"
#import "MMMockQueuedHttpResponseMatcher.h"
#import "MockCredentialsManagement.h"

@implementation MMRegistrationAsyncActivityLogicUnitTest

// All code under test must be linked into the Unit Test bundle

- (void)setUp
{
    [super setUp];
    
    dataUtils = [[MMLogicUnitTestSupportingDataUtils alloc] init];
    
    [dataUtils putResponseString:@"{\"Links\":[{\"Href\":\"/bids/\",\"Rel\":\"meemeep-bid-summary-list\"},{\"Href\":\"/jobs/\",\"Rel\":\"meemeep-job-summary-list\"},{\"Href\":\"/users/\",\"Rel\":\"meemeep-user-summary-list\"},{\"Href\":\"/authentication/\",\"Rel\":\"meemeep-authentication\"}]}" forKey:@"InitialResponseStringSuccess"];
    
    [dataUtils putResponseString:@"{\"Links\":null,\"Details\":\"Transaction Failed\",\"Reason\":\"The request was not valid\",\"StatusCode\":400}" forKey:@"Remote400Response"];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


- (void) testSuccess {
    
    NSString *meemeepUrl = @"http://fakeapi.meemeep.com.au/api/v1";
    
    NSString *meemeepAuthUrl = [meemeepUrl stringByAppendingPathComponent:@"authentication"];
    NSString *meemeepLoginUrl = [meemeepAuthUrl stringByAppendingPathComponent:@"login"];
    NSString *meemeepUsersUrl = [meemeepUrl stringByAppendingPathComponent:@"users"];
    
    MMMockHttpTransmissionGetMatcherImpl *getMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    MMMockHttpTransmissionGetMatcherImpl *postMatcher = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    MMMockHttpTransmissionGetMatcherImpl *putMatcher = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];

    // responses
    // initial response
    // login
    // 200 ok on create job
    // user profile response (credit card registered)
    
    // initial response
    NSString *initialResponseString = [dataUtils getResponseStringForKey:@"InitialResponseStringSuccess"];
    NSData *initialResponseData = [initialResponseString dataUsingEncoding:NSUTF8StringEncoding];
    MMRestHttpResponse *initialHttpResponse = [[MMRestHttpResponse alloc] initWithBody:initialResponseData responseCode:200 headers:nil params:nil orLocalError:nil];
    [getMatcher addResponse:initialHttpResponse forUrl:meemeepUrl andRequestParams:nil];
    
    // 201 created on post a job
    MMRestHttpResponse *RegistrationResponse = [[MMRestHttpResponse alloc] initWithBody:nil responseCode:201 headers:nil params:nil orLocalError:nil];
    
    [postMatcher addResponse:RegistrationResponse forUrl:usersUrl andRequestParams:nil];
    
    MMMockAsyncActivityDelegate *mockDelegate = [[MMMockAsyncActivityDelegate alloc] init];
    
    // mock out the transmission layer
    id<MMRestHttpTransmission> transmission = 
    [[MMMockRestHttpTransmissionImpl alloc] initWithResponseMatchers:getMatcher put:putMatcher post:postMatcher];
    
    id<MMSerialisationFactory> s11nFactory = [[MMSerialisationFactoryImpl alloc] init];
    
    id<MMRestClientFactory> factory 
    = [[MMRestClientFactoryImpl alloc] initWithTransmission:transmission
                                                s11nFactory:s11nFactory
                                                 meemeepUrl:meemeepUrl];
    
    id<MMRestClient> restClient = [factory createRestClient:NO];
    
    MMUserProfile* profile = [[MMUserProfile alloc] init];
    profile.username = @"testUserName";
    // TODO fill in rest
    
    MMRegistrationAsyncActivity *RegistrationActivity = [[MMRegistrationAsyncActivity alloc] initWithActivityDelegate:mockDelegate restDelegate:mockDelegate userProfile:profile];
    
    id<MMAsyncActivityManagement> activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
    
    [activityManagement dispatchMMAsyncActivity:RegistrationActivity];
    
    DLog(@"Waiting for user regisatration retrieval activity to complete!");
    [RegistrationActivity waitUntilFinished];
        
    id<MMAsyncActivityResult> result = mockDelegate.activityResult;
    
    if ([result isKindOfClass:[MMRegistrationAsyncActivityResult class]]) {
        
        MMRegistrationAsyncActivityResult *RegistrationResult = (MMRegistrationAsyncActivityResult *) result;
        
        STAssertNotNil(RegistrationResult, @"User was not registered!");
        
        STAssertTrue(RegistrationResult.status == MMAsyncRegistrationResultSuccess, @"User was not registered");
    } else {
        STFail(@"Should not have reached this point");
    }
}

- (void) testSuccessFieldFail {
    
    NSString *meemeepUrl = @"http://fakeapi.meemeep.com.au/api/v1";
    
    NSString *meemeepAuthUrl = [meemeepUrl stringByAppendingPathComponent:@"authentication"];
    NSString *meemeepLoginUrl = [meemeepAuthUrl stringByAppendingPathComponent:@"login"];
    NSString *meemeepUsersUrl = [meemeepUrl stringByAppendingPathComponent:@"users"];
    
    MMMockHttpTransmissionGetMatcherImpl *getMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    MMMockHttpTransmissionGetMatcherImpl *postMatcher = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    MMMockHttpTransmissionGetMatcherImpl *putMatcher = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    // responses
    // initial response
    // login
    // 400 bad client request on create job
    
    // initial response
    NSString *initialResponseString = [dataUtils getResponseStringForKey:@"InitialResponseStringSuccess"];
    NSData *initialResponseData = [initialResponseString dataUsingEncoding:NSUTF8StringEncoding];
    MMRestHttpResponse *initialHttpResponse = [[MMRestHttpResponse alloc] initWithBody:initialResponseData responseCode:200 headers:nil params:nil orLocalError:nil];
    [getMatcher addResponse:initialHttpResponse forUrl:meemeepUrl andRequestParams:nil];
    
    NSString *RegistrationResponseString = [dataUtils getResponseStringForKey:@"Remote400Response"];
    NSData *RegistrationResponseData = [RegistrationResponseString dataUsingEncoding:NSUTF8StringEncoding];
    // 400 created on post a job
    MMRestHttpResponse *RegistrationResponse = [[MMRestHttpResponse alloc] initWithBody:RegistrationResponseData responseCode:400 headers:nil params:nil orLocalError:nil];
    RegistrationResponse.isRemoteRestError = YES;
    
    [postMatcher addResponse:RegistrationResponse forUrl:usersUrl andRequestParams:nil];
    
    // mock out the activity delegate
    MMMockAsyncActivityDelegate *mockDelegate = [[MMMockAsyncActivityDelegate alloc] init];
    
    // mock out the transmission layer
    id<MMRestHttpTransmission> transmission = 
    [[MMMockRestHttpTransmissionImpl alloc] initWithResponseMatchers:getMatcher put:putMatcher post:postMatcher];
    
    id<MMSerialisationFactory> s11nFactory = [[MMSerialisationFactoryImpl alloc] init];
    
    id<MMRestClientFactory> factory 
    = [[MMRestClientFactoryImpl alloc] initWithTransmission:transmission
                                                s11nFactory:s11nFactory
                                                 meemeepUrl:meemeepUrl];
    
    id<MMRestClient> restClient = [factory createRestClient:NO];
      
    MockCredentialsManagement *credMgmt = [[MockCredentialsManagement alloc] init];
    Credentials *creds = [[Credentials alloc] init];
    creds.email = email;
    creds.password = password;
    credMgmt.storedCredentials = creds;
    
    MockGUIRestDeligate *mockGUIRestDelegate = [[MockGUIRestDeligate alloc] init];
    mockGUIRestDelegate.token = token;
    mockGUIRestDelegate.credentialsManagement = credMgmt;
    mockGUIRestDelegate.restClient = restClient;
    
    MMUserProfile* profile = [[MMUserProfile alloc] init];
    profile.username = @"testUserName";
    // nothing set
    
    MMRegistrationAsyncActivity *RegistrationActivity = [[MMRegistrationAsyncActivity alloc] initWithActivityDelegate:mockDelegate restDelegate:mockDelegate userProfile:profile];
    
    id<MMAsyncActivityManagement> activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
    
    [activityManagement dispatchMMAsyncActivity:RegistrationsActivity];
    
    DLog(@"Waiting for user registration activity to complete!");
    [RegistrationsActivity waitUntilFinished];
        
    id<MMAsyncActivityResult> result = mockDelegate.activityResult;
    STAssertNil(result, @"Result should not be set");
    
    NSError *error = mockDelegate.activityError;
    
    STAssertNotNil(error, @"Activity error was not set");
    
    STAssertTrue([[error localizedDescription] isEqualToString:@"Transaction Failed"], @"Error description not passed through");
}

@end
