//
//  MMRateUserAsyncActivityLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 30/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRateUserAsyncActivityLogicUnitTest.h"

#import "MMCompleteJobAsyncActivity.h"
#import "MMCompleteJobAsyncActivityResult.h"
#import "MMAsyncActivityResult.h"
#import "MMUserRating.h"
#import "UnitTestHelper.h"
#import "OCMock.h"

@implementation MMRateUserAsyncActivityLogicUnitTest

-(void) internalCompleteJob:(NSNumber *) jobID userID:(MMUserRating *) userRating
             expectedResult:(BOOL) expectedResult {
    id mockAsyncActivityDelegate = [UnitTestHelper mockAsynchActivityDelegate];
    id mockRestDelegate = [UnitTestHelper mockGUIRestDelegate];
    
    id mockRestAccessToken = [UnitTestHelper mockRestAccessToken];
    [UnitTestHelper addGetTokenExpectations:mockRestDelegate accessToken:mockRestAccessToken];
    
    id mockRestClient = [UnitTestHelper mockRestClient];
    [UnitTestHelper addGetRestClientExpectations:mockRestDelegate restClient:mockRestClient];
    
    id mockJobClient = [UnitTestHelper mockRestJobsClient];
    
    [UnitTestHelper addGetClientExpectations:mockRestClient authClient:nil userClient:nil jobsClient:mockJobClient];
    
    MMCompleteJobAsyncActivity* underTest;
    
    if(jobID != nil) {
        underTest = [[MMCompleteJobAsyncActivity alloc] initWithActivityDelegate:mockAsyncActivityDelegate restDelegate:mockRestDelegate
                                                                  jobId:jobID];
        [UnitTestHelper addTPCompleteJobExpectations:mockJobClient jobId:jobID accessToken:mockRestAccessToken result:expectedResult];
    } else {
        underTest = [[MMCompleteJobAsyncActivity alloc] initWithActivityDelegate:mockAsyncActivityDelegate restDelegate:mockRestDelegate rating:userRating];
        
        [UnitTestHelper addCustomerCompleteJobWithRatingExpectations:mockJobClient userRating:userRating accessToken:mockRestAccessToken result:expectedResult];
    }
    
    @try {
        id<MMAsyncActivityResult> result = [underTest performAction];
        if(!expectedResult) {
            STFail(@"Expected exception was not thrown");
            return;
        }
        
        STAssertNotNil(result, @"Result is nil");
        STAssertTrue([result isKindOfClass:[MMCompleteJobAsyncActivityResult class]],
                     @"Wrong class type");
        
        MMCompleteJobAsyncActivityResult* castResult = (MMCompleteJobAsyncActivityResult*)result;
        
        STAssertTrue(castResult.status == MMAsyncRateUserResultSuccess, @"Incorrect status");
    }
    @catch (NSException *exception) {
        if(expectedResult) {
            STFail(@"Unexpected exception");
        } else {
            STAssertEqualObjects(exception.description, @"Complete Job failed",
                                 @"Incorrect exception");
        }
    }
    
    [mockAsyncActivityDelegate verify];
    [mockRestDelegate verify];
    [mockRestAccessToken verify];
    [mockRestClient verify];
}

-(void) testSuccessWithJobID {
    [self internalCompleteJob:[NSNumber numberWithInt:1] userID:nil expectedResult:TRUE];
}

-(void) testFailureWithJobID {
    [self internalCompleteJob:[NSNumber numberWithInt:1] userID:nil expectedResult:FALSE];
}

-(void) testSuccessWithUserRating {
    [self internalCompleteJob:nil userID:[[MMUserRating alloc] init] expectedResult:TRUE];
}

-(void) testFailureWithUserRating {
    [self internalCompleteJob:nil userID:[[MMUserRating alloc] init] expectedResult:FALSE];
}


@end
