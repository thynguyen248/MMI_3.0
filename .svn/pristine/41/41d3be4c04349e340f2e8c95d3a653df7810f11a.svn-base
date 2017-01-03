//
//  MMCreateJobAsyncActivityLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 30/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMCreateJobAsyncActivityLogicUnitTest.h"
#import "MMMockAsyncActivityDelegate.h"
#import "MMRestClientFactory.h"
#import "MMRestClientFactoryImpl.h"
#import "MMRestAuthorisationClient.h"
#import "MMAsyncActivityManagement.h"
#import "MMAsyncActivityManagementImpl.h"
#import "MMCreateJobAsyncActivity.h"
#import "MMCreateJobActivityResult.h"
#import "MMRestJobsClient.h"

#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"
#import "MMJobDetailResponseSerialisation.h"
#import "MMJobDetailResponse.h"

#import "MMJobDetailDataUtils.h"

#import "MMMockHttpTransmissionGetMatcherImpl.h"
#import "MMMockRestHttpTransmissionImpl.h"
#import "MockGUIRestDeligate.h"
#import "MMMockQueuedHttpResponseMatcher.h"
#import "MockCredentialsManagement.h"
#import "UnitTestHelper.h"
#import "OCMock.h"

@implementation MMCreateJobAsyncActivityLogicUnitTest

// All code under test must be linked into the Unit Test bundle

-(void) execute:(BOOL) jobCreateResult {
    MMJobDetail *job = [MMJobDetailDataUtils getJobDetailToCreateForUserWithName:@"Symphony" userId:[NSNumber numberWithInt:363]];
    
    id guiRestDelegate = [UnitTestHelper mockGUIRestDelegate];
    id restClient = [UnitTestHelper mockRestClient];
    [UnitTestHelper addGetRestClientExpectations:guiRestDelegate restClient:restClient];
    id accessToken = [UnitTestHelper mockRestAccessToken];
    [UnitTestHelper addGetTokenExpectations:guiRestDelegate accessToken:accessToken];
    id jobsClient = [UnitTestHelper mockRestJobsClient];
    [UnitTestHelper addCreateJobWithDetailExpectations:jobsClient job:job accessToken:accessToken result:jobCreateResult];
    
    [UnitTestHelper addGetClientExpectations:restClient authClient:nil userClient:nil jobsClient:jobsClient];
    
    MMMockAsyncActivityDelegate *activityDelegate = [[MMMockAsyncActivityDelegate alloc] init];
    
    MMCreateJobAsyncActivity *createJobsActivity = [[MMCreateJobAsyncActivity alloc] initWithActivityDelegate:activityDelegate restDelegate:guiRestDelegate jobToCreate:job];
    
    id<MMAsyncActivityManagement> activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
    
    [activityManagement dispatchMMAsyncActivity:createJobsActivity];
    
    // wait for the job to complete
    DLog(@"Waiting for bid detail retrieval activity to complete!");
    [createJobsActivity waitUntilFinished];
    
    // check that the delegate was updated correctly
    
    id<MMAsyncActivityResult> result = activityDelegate.activityResult;
    
    if ([result isKindOfClass:[MMCreateJobActivityResult class]]) {
        
        MMCreateJobActivityResult *createJobResult = (MMCreateJobActivityResult *) result;
        
        STAssertNotNil(createJobResult, @"Job was not created!");
        
        STAssertTrue(jobCreateResult ? createJobResult.jobCreatedStatus == MMAsyncCreateJobStatusSuccess : createJobResult.jobCreatedStatus == MMAsyncCreateJobStatusFailure
                     , @"Job was not created");
    } else {
        STFail(@"Should not have reached this point");
    }
    
    [guiRestDelegate verify];
    [restClient verify];
    [accessToken verify];
    [jobsClient verify];
}

- (void) testSuccess {
    [self execute:TRUE];
}

- (void) testFailure {
    [self execute:FALSE];
}

@end
