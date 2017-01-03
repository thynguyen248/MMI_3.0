//
//  MMRestJobsClientLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 1/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestJobsClientLogicUnitTest.h"
#import "MMMockRestHttpTransmissionImpl.h"
#import "MMMockHttpTransmissionGetMatcherImpl.h"

#import "MMRestHttpTransmission.h"
#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"
#import "MMRestClientFactory.h"
#import "MMRestClientFactoryImpl.h"
#import "MMException.h"
#import "UnitTestHelper.h"
#import "OCMock.h"

#import "MMJobDetailDataUtils.h"

@implementation MMRestJobsClientLogicUnitTest

#pragma mark - Recent jobs mocked unit tests
// All code under test must be linked into the Unit Test bundle
- (void) testRetrieveRecentJobsWithHttpMockSuccess {
    
    NSString *meemeepUrl = @"http://fakeapi.meemeep.com.au/api/v1";
    NSString *meemeepJobsUrl = [meemeepUrl stringByAppendingPathComponent:@"public/api/job/list/"];
    
    MMMockHttpTransmissionGetMatcherImpl *getMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    // add response matching here!
    
    NSString *summaryJobsResponse = @"{\"jobs\":[{\"id\":124,\"title\":\"Chair, Table\",\"status\":\"JOB_CREATED\",\"fromLocation\":{\"class\":\"com.meemeep.portal.Location\",\"id\":46,\"address\":\"South Melbourne, VIC\",\"lat\":-37.8323792,\"lng\":144.9604333},\"toLocation\":{\"class\":\"com.meemeep.portal.Location\",\"id\":45,\"address\":\"Brunswick West, VIC\",\"lat\":-37.763542,\"lng\":144.943924},\"pickupDateStart\":\"2013-04-23T04:51:08Z\",\"deliveryDateEnd\":\"2013-04-26T04:51:08Z\",\"expiryDate\":\"2013-04-28T04:51:08Z\"},{\"id\":118,\"title\":\"Item 4\",\"status\":\"JOB_CREATED\",\"fromLocation\":{\"class\":\"com.meemeep.portal.Location\",\"id\":46,\"address\":\"South Melbourne, VIC\",\"lat\":-37.8323792,\"lng\":144.9604333},\"toLocation\":{\"class\":\"com.meemeep.portal.Location\",\"id\":45,\"address\":\"Brunswick West, VIC\",\"lat\":-37.763542,\"lng\":144.943924},\"pickupDateStart\":\"2013-04-23T04:51:07Z\",\"deliveryDateEnd\":\"2013-05-03T04:51:07Z\",\"expiryDate\":\"2013-04-28T04:51:07Z\"}]}";
    
    NSData *summaryJobsResponseData = [summaryJobsResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    MMRestHttpResponse *summaryJobsHttpResponse = [[MMRestHttpResponse alloc] initWithBody:summaryJobsResponseData responseCode:200 headers:nil params:nil orLocalError:nil];
    
    [getMatcher addResponse:summaryJobsHttpResponse forUrl:meemeepJobsUrl andRequestParams:nil];
    
    id<MMRestHttpTransmission> transmission = 
    [[MMMockRestHttpTransmissionImpl alloc] initWithResponseMatchers:getMatcher put:nil post:nil];
    
    id<MMSerialisationFactory> s11nFactory = [[MMSerialisationFactoryImpl alloc] init];
    
    id<MMRestClientFactory> factory 
    = [[MMRestClientFactoryImpl alloc] initWithTransmission:transmission
                                                s11nFactory:s11nFactory
                                                 meemeepUrl:meemeepUrl];
    
    // create an initialised client
    id<MMRestClient> client = [factory createRestClient:YES];
    
    id<MMRestJobsClient> jobsClient = [client getJobsClient];
    
    NSArray *summaryJobs = [jobsClient getRecentlyPostedSummaryJobsWithAccessToken:nil];
    
    STAssertNotNil(summaryJobs, @"Summary jobs object was nil!");
    STAssertEquals([summaryJobs count], (NSUInteger)2, @"Wrong number of jobs returned");
    
    MMJobSummary *firstJobSummary = [summaryJobs objectAtIndex:0];
    
    STAssertEqualObjects(firstJobSummary.jobId, [NSNumber numberWithInt:124], @"Summary job id did not have expected value");
    
    MMJobSummary *secondJobSummary = [summaryJobs objectAtIndex:1];
    
    STAssertEqualObjects(secondJobSummary.jobId, [NSNumber numberWithInt:118], @"Summary job id did not have expected value");
}

- (void) testRetrieveRecentJobsWithHttpMockFailRemote {
    
    NSString *meemeepUrl = @"http://fakeapi.meemeep.com.au/api/v1";
    NSString *meemeepJobsUrl = [meemeepUrl stringByAppendingPathComponent:@"public/api/job/list/"];
    
    MMMockHttpTransmissionGetMatcherImpl *getMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    NSString *summaryJobsResponse = @"{\"errors\":[{\"object\":\"com.meemeep.portal.User\",\"field\":\"username\",\"rejected-value\":\"user\",\"message\":\"Error\"}]}";
    
    NSData *summaryJobsResponseData = [summaryJobsResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    MMRestHttpResponse *summaryJobsHttpResponse = [[MMRestHttpResponse alloc] initWithBody:summaryJobsResponseData responseCode:400 headers:nil params:nil orLocalError:nil];
    summaryJobsHttpResponse.isRemoteRestError = YES;
    
    [getMatcher addResponse:summaryJobsHttpResponse forUrl:meemeepJobsUrl andRequestParams:nil];
    
    id<MMRestHttpTransmission> transmission = 
    [[MMMockRestHttpTransmissionImpl alloc] initWithResponseMatchers:getMatcher put:nil post:nil];
    
    id<MMSerialisationFactory> s11nFactory = [[MMSerialisationFactoryImpl alloc] init];
    
    id<MMRestClientFactory> factory 
    = [[MMRestClientFactoryImpl alloc] initWithTransmission:transmission
                                                s11nFactory:s11nFactory
                                                 meemeepUrl:meemeepUrl];
    
    id<MMRestClient> restClient = [factory createRestClient:YES];
    
    id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
    
    @try {
        [jobsClient getRecentlyPostedSummaryJobsWithAccessToken:nil];
        
        STFail(@"Should not have reached this point");
    } @catch (NSException *ex) {
        STAssertTrue([ex isKindOfClass:[MMException class]], @"Exception was not the correct type!");
    }

}

- (void) testRetrieveRecentJobswithHttpMockFailLocal {
    NSString *meemeepUrl = @"http://fakeapi.meemeep.com.au/api/v1";
    NSString *meemeepJobsUrl = [meemeepUrl stringByAppendingPathComponent:@"public/api/job/list/"];
    
    MMMockHttpTransmissionGetMatcherImpl *getMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    NSString *summaryJobsResponse = @"{\"errors\":[{\"object\":\"com.meemeep.portal.User\",\"field\":\"username\",\"rejected-value\":\"user\",\"message\":\"Error\"}]}";
    
    NSData *summaryJobsResponseData = [summaryJobsResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *sumJobsErrorUserDict = [[NSMutableDictionary alloc] init];
    [sumJobsErrorUserDict setValue:@"Not connected to internet" forKey:NSLocalizedDescriptionKey];
    [sumJobsErrorUserDict setValue:@"application settings" forKey:NSLocalizedFailureReasonErrorKey];
    
     NSError *localError = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:NSURLErrorNotConnectedToInternet userInfo:sumJobsErrorUserDict];
    
    MMRestHttpResponse *summaryJobsHttpResponse = [[MMRestHttpResponse alloc] initWithBody:summaryJobsResponseData responseCode:0 headers:nil params:nil orLocalError:localError];
    
    [getMatcher addResponse:summaryJobsHttpResponse forUrl:meemeepJobsUrl andRequestParams:nil];
    
    id<MMRestHttpTransmission> transmission = 
    [[MMMockRestHttpTransmissionImpl alloc] initWithResponseMatchers:getMatcher put:nil post:nil];
    
    id<MMSerialisationFactory> s11nFactory = [[MMSerialisationFactoryImpl alloc] init];
    
    id<MMRestClientFactory> factory 
    = [[MMRestClientFactoryImpl alloc] initWithTransmission:transmission
                                                s11nFactory:s11nFactory
                                                 meemeepUrl:meemeepUrl];
    
    id<MMRestClient> restClient = [factory createRestClient:YES];
    
    id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
    
    @try {
        [jobsClient getRecentlyPostedSummaryJobsWithAccessToken:nil];
        
        STFail(@"Should not have reached this point");
    } @catch (NSException *ex) {
        STAssertTrue([ex isKindOfClass:[MMException class]], @"Exception was not the correct type!");
        MMException *mex = (MMException *) ex;
        NSError *lError = mex.containedError;
        
        STAssertTrue(lError.code == NSURLErrorNotConnectedToInternet, @"Error code not passed through");
    }
} 

#pragma mark - Create job mocked unit tests

- (void) testCreateJobWithHttpMockSuccess {
    NSString *meemeepUrl = @"http://fakeapi.meemeep.com.au/api/v1";
    NSString *meemeepJobsUrl = [meemeepUrl stringByAppendingPathComponent:@"secure/api/job/save/"];
    
    MMMockHttpTransmissionGetMatcherImpl *getMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    MMMockHttpTransmissionGetMatcherImpl *postMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    // create job success
    MMJobDetail *jobToCreate = [MMJobDetailDataUtils getJobDetailToCreateForUserWithName:nil userId:nil];    
    
    MMRestHttpResponse *createdJobResponse = [[MMRestHttpResponse alloc] initWithBody:nil responseCode:201 headers:nil params:nil orLocalError:nil];
    
    [postMatcher addResponse:createdJobResponse forUrl:meemeepJobsUrl andRequestParams:nil];
    
    id accessToken = [UnitTestHelper mockRestAccessToken];
    [UnitTestHelper addTokenExpectations:accessToken accessToken:nil];
    
    @try {
        id<MMRestHttpTransmission> transmission = 
        [[MMMockRestHttpTransmissionImpl alloc] initWithResponseMatchers:getMatcher put:nil post:postMatcher];
        
        id<MMSerialisationFactory> s11nFactory = [[MMSerialisationFactoryImpl alloc] init];
        
        id<MMRestClientFactory> factory 
        = [[MMRestClientFactoryImpl alloc] initWithTransmission:transmission
                                                    s11nFactory:s11nFactory
                                                     meemeepUrl:meemeepUrl];
        
        id<MMRestClient> restClient = [factory createRestClient:YES];
        

        
        id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
        
        // create a job to create
        
        BOOL jobWasCreated = [jobsClient createJobWithDetail:jobToCreate andAccessToken:accessToken];
        
        STAssertTrue(jobWasCreated, @"Job was not created");
    } @catch (NSException *ex) {
        STFail(@"Should not have thrown an exception");
    }
    
    [accessToken verify];
}

- (void) testCreateJobWithHttpMockFailRemote {
    NSString *meemeepUrl = @"http://fakeapi.meemeep.com.au/api/v1";
    NSString *meemeepJobsUrl = [meemeepUrl stringByAppendingPathComponent:@"secure/api/job/save/"];
    
    MMMockHttpTransmissionGetMatcherImpl *getMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    MMMockHttpTransmissionGetMatcherImpl *postMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    
    // create job success
    MMJobDetail *jobToCreate = [MMJobDetailDataUtils getJobDetailToCreateForUserWithName:nil userId:nil];
    
    NSString *createdJobErrorResponse = @"{\"errors\":[{\"object\":\"com.meemeep.portal.User\",\"field\":\"username\",\"rejected-value\":\"user\",\"message\":\"Error\"}]}";
    
    NSData *createdJobSuccessData = [createdJobErrorResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    MMRestHttpResponse *createdJobResponse = [[MMRestHttpResponse alloc] initWithBody:createdJobSuccessData responseCode:400 headers:nil params:nil orLocalError:nil];
    createdJobResponse.isRemoteRestError = YES;
    
    [postMatcher addResponse:createdJobResponse forUrl:meemeepJobsUrl andRequestParams:nil];
    
    id accessToken = [UnitTestHelper mockRestAccessToken];
    [UnitTestHelper addTokenExpectations:accessToken accessToken:nil];
    
    @try {
        id<MMRestHttpTransmission> transmission = 
        [[MMMockRestHttpTransmissionImpl alloc] initWithResponseMatchers:getMatcher put:nil post:postMatcher];
        
        id<MMSerialisationFactory> s11nFactory = [[MMSerialisationFactoryImpl alloc] init];
        
        id<MMRestClientFactory> factory 
        = [[MMRestClientFactoryImpl alloc] initWithTransmission:transmission
                                                    s11nFactory:s11nFactory
                                                     meemeepUrl:meemeepUrl];
        
        id<MMRestClient> restClient = [factory createRestClient:YES];
        
        id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
        
        // create a job to create
        
        [jobsClient createJobWithDetail:jobToCreate andAccessToken:accessToken];
        STFail(@"Should not have got to this point");
        
    } @catch (NSException *ex) {
        STAssertTrue([ex isKindOfClass:[MMException class]], @"Exception was not expected type");
        MMException *mex = (MMException *) ex;
        NSError *remoteError = mex.containedError;
        STAssertTrue(remoteError.code == 400, @"Returned error code was not expected");
    }
    
    [accessToken verify];
}

- (void) testCreateJobWithHttpMockFailLocal {
    NSString *meemeepUrl = @"http://fakeapi.meemeep.com.au/api/v1";
    NSString *meemeepJobsUrl = [meemeepUrl stringByAppendingPathComponent:@"secure/api/job/save/"];
    
    MMMockHttpTransmissionGetMatcherImpl *getMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    MMMockHttpTransmissionGetMatcherImpl *postMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    // create job
    MMJobDetail *jobToCreate = [MMJobDetailDataUtils getJobDetailToCreateForUserWithName:nil userId:nil];
    
    NSMutableDictionary *errorDict = [[NSMutableDictionary alloc] init];
    [errorDict setValue:@"Not connected to internet" forKey:NSLocalizedDescriptionKey];
    [errorDict setValue:@"Application settings" forKey:NSLocalizedFailureReasonErrorKey];
    
    NSError *localErrorOnCreate = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:NSURLErrorNotConnectedToInternet userInfo:errorDict];
    
    MMRestHttpResponse *createdJobResponse = [[MMRestHttpResponse alloc] initWithBody:nil responseCode:0 headers:nil params:nil orLocalError:localErrorOnCreate];
    
    [postMatcher addResponse:createdJobResponse forUrl:meemeepJobsUrl andRequestParams:nil];
    
    id accessToken = [UnitTestHelper mockRestAccessToken];
    [UnitTestHelper addTokenExpectations:accessToken accessToken:nil];
    
    @try {
        id<MMRestHttpTransmission> transmission = 
        [[MMMockRestHttpTransmissionImpl alloc] initWithResponseMatchers:getMatcher put:nil post:postMatcher];
        
        id<MMSerialisationFactory> s11nFactory = [[MMSerialisationFactoryImpl alloc] init];
        
        id<MMRestClientFactory> factory 
        = [[MMRestClientFactoryImpl alloc] initWithTransmission:transmission
                                                    s11nFactory:s11nFactory
                                                     meemeepUrl:meemeepUrl];
        
        id<MMRestClient> restClient = [factory createRestClient:YES];
        
        id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
        
        // create a job to create
        
        [jobsClient createJobWithDetail:jobToCreate andAccessToken:accessToken];
        STFail(@"Should not have got to this point");
        
    } @catch (NSException *ex) {
        STAssertTrue([ex isKindOfClass:[MMException class]], @"Exception was not expected type");
        MMException *mex = (MMException *) ex;
        NSError *remoteError = mex.containedError;
        STAssertTrue(remoteError.code == NSURLErrorNotConnectedToInternet, @"Returned error code was not expected");
    }

    [accessToken verify];
}

#pragma mark - Retrieve job details unauthenticated mock unit tests

- (void) testRetrieveJobDetailUnauthenticatedWithHttpMockFailLocal {
    
    NSString *meemeepUrl = @"http://fakeapi.meemeep.com.au/api/v1";
    NSString *meemeepJob202Url = [meemeepUrl stringByAppendingPathComponent:@"public/api/job/202/"];
    
    MMMockHttpTransmissionGetMatcherImpl *getMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
        
    NSMutableDictionary *localErrorDict = [[NSMutableDictionary alloc] init];
    [localErrorDict setValue:@"Network not connected" forKey:NSLocalizedDescriptionKey];
    [localErrorDict setValue:@"App settings" forKey:NSLocalizedFailureReasonErrorKey];
    
    NSError *localError = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:NSURLErrorNotConnectedToInternet userInfo:localErrorDict];
    
    MMRestHttpResponse *jobDetailResponse = [[MMRestHttpResponse alloc] initWithBody:nil responseCode:0 headers:nil params:nil orLocalError:localError];
    
    [getMatcher addResponse:jobDetailResponse forUrl:meemeepJob202Url andRequestParams:nil];
    
    @try {
        id<MMRestHttpTransmission> transmission = 
        [[MMMockRestHttpTransmissionImpl alloc] initWithResponseMatchers:getMatcher put:nil post:nil];
        
        id<MMSerialisationFactory> s11nFactory = [[MMSerialisationFactoryImpl alloc] init];
        
        id<MMRestClientFactory> factory 
        = [[MMRestClientFactoryImpl alloc] initWithTransmission:transmission
                                                    s11nFactory:s11nFactory
                                                     meemeepUrl:meemeepUrl];
        
        id<MMRestClient> restClient = [factory createRestClient:YES];
        
        id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
        [jobsClient getJobDetailForJobId:[NSNumber numberWithInt:202] withToken:nil];
        
        STFail(@"Should not have thrown an exception");
        
    } @catch (NSException *ex) {
        STAssertTrue([ex isKindOfClass:[MMException class]], @"Exception was not expected type");
        MMException *mex = (MMException *) ex;
        NSError *remoteError = mex.containedError;
        STAssertTrue(remoteError.code == NSURLErrorNotConnectedToInternet, @"Returned error code was not expected");
    }
}

- (void) testRetrieveJobDetailUnauthenticatedWithHttpMockFailRemote {
    NSString *meemeepUrl = @"http://fakeapi.meemeep.com.au/api/v1";
    NSString *meemeepJob202Url = [meemeepUrl stringByAppendingPathComponent:@"public/api/job/202/"];
    
    MMMockHttpTransmissionGetMatcherImpl *getMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    NSString *jobDetailErrorResponseString = @"{\"errors\":[{\"object\":\"com.meemeep.portal.User\",\"field\":\"username\",\"rejected-value\":\"user\",\"message\":\"Error\"}]}";
    
    NSData *errorResponseData = [jobDetailErrorResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    MMRestHttpResponse *jobDetailResponse = [[MMRestHttpResponse alloc] initWithBody:errorResponseData responseCode:400 headers:nil params:nil orLocalError:nil];
    jobDetailResponse.isRemoteRestError = YES;
    
    [getMatcher addResponse:jobDetailResponse forUrl:meemeepJob202Url andRequestParams:nil];
    
    @try {
        id<MMRestHttpTransmission> transmission = 
        [[MMMockRestHttpTransmissionImpl alloc] initWithResponseMatchers:getMatcher put:nil post:nil];
        
        id<MMSerialisationFactory> s11nFactory = [[MMSerialisationFactoryImpl alloc] init];
        
        id<MMRestClientFactory> factory 
        = [[MMRestClientFactoryImpl alloc] initWithTransmission:transmission
                                                    s11nFactory:s11nFactory
                                                     meemeepUrl:meemeepUrl];
        
        id<MMRestClient> restClient = [factory createRestClient:YES];
        
        id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
        [jobsClient getJobDetailForJobId:[NSNumber numberWithInt:202] withToken:nil];
        
        STFail(@"Should have thrown an exception");
        
    } @catch (NSException *ex) {
        STAssertTrue([ex isKindOfClass:[MMException class]], @"Exception was not expected type");
        MMException *mex = (MMException *) ex;
        NSError *remoteError = mex.containedError;
        STAssertTrue(remoteError.code == 400, @"Returned error code was not expected");
    }
}

- (void) testRetrieveJobDetailUnauthenticatedWithHttpMockSuccess {
    
    NSString *meemeepUrl = @"http://fakeapi.meemeep.com.au/api/v1";
    NSString *meemeepJob202Url = [meemeepUrl stringByAppendingPathComponent:@"public/api/job/202/"];
    
    MMMockHttpTransmissionGetMatcherImpl *getMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
        
    NSString *jobDetailString = @"{\"success\":true,\"job\":{\"pickupDateEnd\":\"2013-04-24T04:51:08Z\",\"affiliateId\":38,\"expired\":false,\"activeBidCount\":3,\"user\":{\"transportProvider\":false,\"hasCreditCardDetails\":true,\"hasBankDetails\":false,\"displayName\":\"Test U\",\"id\":49},\"auctionWon\":false,\"title\":\"Chair, Table\",\"affiliateJobId\":\"123ABC\",\"deliveryDateEnd\":\"2013-04-26T04:51:08Z\",\"deliveryDateStart\":\"2013-04-25T04:51:08Z\",\"bidding\":false,\"lastUpdated\":\"2013-04-23T04:51:09Z\",\"fromLocation\":{\"class\":\"com.meemeep.portal.Location\",\"id\":46,\"address\":\"South Melbourne, VIC\",\"lat\":-37.8323792,\"lng\":144.9604333},\"cancellable\":true,\"affiliate\":{\"class\":\"com.meemeep.portal.Affiliate\",\"id\":38,\"lastUpdated\":\"2013-04-23T04:50:52Z\",\"name\":\"GraysOnline\"},\"distance\":null,\"acceptedBid\":null,\"jobCategoryId\":20,\"fromLocationId\":46,\"toLocation\":{\"class\":\"com.meemeep.portal.Location\",\"id\":45,\"address\":\"Brunswick West, VIC\",\"lat\":-37.763542,\"lng\":144.943924},\"specialConsiderations\":[{\"class\":\"com.meemeep.portal.SpecialConsideration\",\"id\":26,\"description\":\"Tailgate lifter required\",\"lastUpdated\":\"2013-04-23T04:50:52Z\"},{\"class\":\"com.meemeep.portal.SpecialConsideration\",\"id\":25,\"description\":\"Limited access\",\"lastUpdated\":\"2013-04-23T04:50:52Z\"},{\"class\":\"com.meemeep.portal.SpecialConsideration\",\"id\":23,\"description\":\"Forklift already onsite\",\"lastUpdated\":\"2013-04-23T04:50:51Z\"},{\"class\":\"com.meemeep.portal.SpecialConsideration\",\"id\":24,\"description\":\"Forklift required onsite\",\"lastUpdated\":\"2013-04-23T04:50:52Z\"}],\"ownerCompletionDate\":null,\"pickupDateStart\":\"2013-04-23T04:51:08Z\",\"status\":\"JOB_CREATED\",\"ratingId\":128,\"toLocationId\":45,\"deliveryTime\":null,\"dateCreated\":\"2013-04-23T04:51:09Z\",\"pickupTime\":null,\"tpCompletionDate\":null,\"jobCategory\":{\"class\":\"com.meemeep.portal.JobCategory\",\"id\":20,\"lastUpdated\":\"2013-04-23T04:50:51Z\",\"name\":\"Box\"},\"items\":[{\"weight\":2,\"width\":5,\"imageId\":null,\"lotID\":null,\"lastUpdated\":\"2013-04-23T04:51:09Z\",\"dateCreated\":\"2013-04-23T04:51:09Z\",\"description\":\"Chair\",\"height\":15,\"length\":5,\"weightUnit\":null,\"jobId\":124,\"id\":125},{\"width\":5,\"weight\":5,\"lastUpdated\":\"2013-04-23T04:51:09Z\",\"weightUnit\":null,\"height\":5,\"dateCreated\":\"2013-04-23T04:51:09Z\",\"imageId\":null,\"lotID\":null,\"description\":\"Table\",\"length\":5,\"jobId\":124,\"id\":126}],\"totalMessageCount\":5,\"rating\":{\"class\":\"com.meemeep.portal.Rating\",\"id\":128,\"comment\":\"Good job, thanks\",\"job\":{\"class\":\"Job\",\"id\":124},\"reasons\":[],\"stars\":4,\"user\":{\"class\":\"User\",\"id\":53}},\"acceptedBidId\":null,\"id\":202,\"expiryDate\":\"2013-04-28T04:51:08Z\",\"myBidId\":null}}";

    NSData *jobDetailData = [jobDetailString dataUsingEncoding:NSUTF8StringEncoding];
    
    MMRestHttpResponse *jobDetailResponse = [[MMRestHttpResponse alloc] initWithBody:jobDetailData responseCode:200 headers:nil params:nil orLocalError:nil];
    
    [getMatcher addResponse:jobDetailResponse forUrl:meemeepJob202Url andRequestParams:nil];
    
    @try {
        id<MMRestHttpTransmission> transmission = 
        [[MMMockRestHttpTransmissionImpl alloc] initWithResponseMatchers:getMatcher put:nil post:nil];
        
        id<MMSerialisationFactory> s11nFactory = [[MMSerialisationFactoryImpl alloc] init];
        
        id<MMRestClientFactory> factory 
        = [[MMRestClientFactoryImpl alloc] initWithTransmission:transmission
                                                    s11nFactory:s11nFactory
                                                     meemeepUrl:meemeepUrl];
        
        id<MMRestClient> restClient = [factory createRestClient:YES];
        
        id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
        
        MMJobDetail *detail = [jobsClient getJobDetailForJobId:[NSNumber numberWithInt:202] withToken:nil];
        
        STAssertNotNil(detail, @"Retrieved job detail was nil");
        
        STAssertTrue([detail.jobId intValue] == 202, @"Job ID was not as expected");
        
    } @catch (NSException *ex) {
        STFail(@"Should not have thrown an exception");
    }
}

#pragma mark - Bid Creation Unit tests

- (void) testCreateBidForJobWithHttpMockSuccess {
    NSString *meemeepUrl = @"http://fakeapi.meemeep.com.au/api/v1";
    NSString *createBidURL = [meemeepUrl stringByAppendingPathComponent:@"secure/api/job/202/bids"];

    MMMockHttpTransmissionGetMatcherImpl *getMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    MMMockHttpTransmissionGetMatcherImpl *postMatcher = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    MMMockHttpTransmissionGetMatcherImpl *putMatcher = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
        
    MMRestHttpResponse *createBidResponse = [[MMRestHttpResponse alloc] initWithBody:nil responseCode:201 headers:nil params:nil orLocalError:nil];
    
    [postMatcher addResponse:createBidResponse forUrl:createBidURL andRequestParams:nil];
    
    id<MMRestHttpTransmission> transmission = 
    [[MMMockRestHttpTransmissionImpl alloc] initWithResponseMatchers:getMatcher put:putMatcher post:postMatcher];
    
    id<MMSerialisationFactory> s11nFactory = [[MMSerialisationFactoryImpl alloc] init];
    
    id<MMRestClientFactory> factory 
    = [[MMRestClientFactoryImpl alloc] initWithTransmission:transmission
                                                s11nFactory:s11nFactory
                                                 meemeepUrl:meemeepUrl];
    
    id<MMRestClient> restClient = [factory createRestClient:YES];
        
    id accessToken = [UnitTestHelper mockRestAccessToken];
    [UnitTestHelper addTokenExpectations:accessToken accessToken:nil];
    
    
    id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
    
    
    // get any bid
    
    MMBidDetail *bidToCreate = [[MMBidDetail alloc] init];
    bidToCreate.additionalInformation = @"Blah Blah";
    bidToCreate.contactPhoneNumber = @"29837492";
    bidToCreate.deliveryVehicle = @"CAR";
    bidToCreate.deliveryWindowDays = [NSNumber numberWithInt:0];
    bidToCreate.bidId = nil;
    bidToCreate.jobId = [NSNumber numberWithInt:202];
    bidToCreate.pickupDate = [NSDate dateWithTimeIntervalSince1970:0];
    bidToCreate.status = @"Open";
    bidToCreate.price = [NSNumber numberWithInt:10];
    bidToCreate.userName = @"Greg";
    bidToCreate.userId = [NSNumber numberWithInt:341];
    bidToCreate.userRating = [NSNumber numberWithInt:3];
    
    // put bid together
    
    
    BOOL created = [jobsClient createBidWithDetail:bidToCreate forJobWithId:202 withAccessToken:accessToken];
    
    STAssertTrue(created, @"Bid was not created");
    [accessToken verify];
}



- (void) testCreateBidForJobWithHttpMockLocalFail {
    NSString *meemeepUrl = @"http://fakeapi.meemeep.com.au/api/v1";
    NSString *createBidURL = [meemeepUrl stringByAppendingPathComponent:@"secure/api/job/202/bids"];
    
    MMMockHttpTransmissionGetMatcherImpl *getMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    MMMockHttpTransmissionGetMatcherImpl *postMatcher = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    MMMockHttpTransmissionGetMatcherImpl *putMatcher = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
        
    NSMutableDictionary *errorDict = [[NSMutableDictionary alloc] init];
    [errorDict setValue:NSLocalizedDescriptionKey forKey:@"Could not connect to internet"];
    [errorDict setValue:NSLocalizedFailureReasonErrorKey forKey:@"Check application settings"];
     
    NSError *localError = [NSError errorWithDomain:NSCocoaErrorDomain code:NSURLErrorNotConnectedToInternet userInfo:nil];
    MMRestHttpResponse *createBidResponse = [[MMRestHttpResponse alloc] initWithBody:nil responseCode:999 headers:nil params:nil orLocalError:localError];
    
    [postMatcher addResponse:createBidResponse forUrl:createBidURL andRequestParams:nil];
    
    id<MMRestHttpTransmission> transmission = 
    [[MMMockRestHttpTransmissionImpl alloc] initWithResponseMatchers:getMatcher put:putMatcher post:postMatcher];
    
    id<MMSerialisationFactory> s11nFactory = [[MMSerialisationFactoryImpl alloc] init];
    
    id<MMRestClientFactory> factory 
    = [[MMRestClientFactoryImpl alloc] initWithTransmission:transmission
                                                s11nFactory:s11nFactory
                                                 meemeepUrl:meemeepUrl];
    
    id<MMRestClient> restClient = [factory createRestClient:YES];
    
    id accessToken = [UnitTestHelper mockRestAccessToken];
    [UnitTestHelper addTokenExpectations:accessToken accessToken:nil];
    
    id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
    
    // get any bid
    
    MMBidDetail *bidToCreate = [[MMBidDetail alloc] init];
    bidToCreate.additionalInformation = @"Blah Blah";
    bidToCreate.contactPhoneNumber = @"29837492";
    bidToCreate.deliveryVehicle = @"CAR";
    bidToCreate.deliveryWindowDays = [NSNumber numberWithInt:0];
    bidToCreate.bidId = nil;
    bidToCreate.jobId = [NSNumber numberWithInt:202];
    bidToCreate.pickupDate = [NSDate dateWithTimeIntervalSince1970:0];
    bidToCreate.status = @"Open";
    bidToCreate.price = [NSNumber numberWithInt:10];
    bidToCreate.userName = @"Greg";
    bidToCreate.userId = [NSNumber numberWithInt:341];
    bidToCreate.userRating = [NSNumber numberWithInt:3];
    
    // put bid together
    
    @try {
        [jobsClient createBidWithDetail:bidToCreate forJobWithId:202 withAccessToken:accessToken];
        STFail(@"Should not have got here!");
    } @catch (NSException *anyException) {
        STAssertTrue([anyException isKindOfClass:[MMException class]], @"Exception was not correct type");
        MMException *mex = (MMException *) anyException;
        STAssertNotNil(mex.containedError, @"No error delivered");
        STAssertTrue([mex.containedError code] == NSURLErrorNotConnectedToInternet, @"Code was not delivered correctly");
    }
    
    [accessToken verify];
}

- (void) testCreateBidForJobwithHttpMockRemoteFail {
    NSString *meemeepUrl = @"http://fakeapi.meemeep.com.au/api/v1";
    NSString *createBidURL = [meemeepUrl stringByAppendingPathComponent:@"secure/api/job/202/bids"];
    
    MMMockHttpTransmissionGetMatcherImpl *getMatcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    MMMockHttpTransmissionGetMatcherImpl *postMatcher = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    MMMockHttpTransmissionGetMatcherImpl *putMatcher = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    NSString *createBidResponseString = @"{\"errors\":[{\"object\":\"com.meemeep.portal.User\",\"field\":\"username\",\"rejected-value\":\"user\",\"message\":\"Error\"}]}";    
    NSData *createBidResponseData = [createBidResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    MMRestHttpResponse *createBidResponse = [[MMRestHttpResponse alloc] initWithBody:createBidResponseData responseCode:400 headers:nil params:nil orLocalError:nil];
    createBidResponse.isRemoteRestError = YES;
    
    [postMatcher addResponse:createBidResponse forUrl:createBidURL andRequestParams:nil];
    
    id<MMRestHttpTransmission> transmission = 
    [[MMMockRestHttpTransmissionImpl alloc] initWithResponseMatchers:getMatcher put:putMatcher post:postMatcher];
    
    id<MMSerialisationFactory> s11nFactory = [[MMSerialisationFactoryImpl alloc] init];
    
    id<MMRestClientFactory> factory 
    = [[MMRestClientFactoryImpl alloc] initWithTransmission:transmission
                                                s11nFactory:s11nFactory
                                                 meemeepUrl:meemeepUrl];
    
    id<MMRestClient> restClient = [factory createRestClient:YES];
    
    id accessToken = [UnitTestHelper mockRestAccessToken];
    [UnitTestHelper addTokenExpectations:accessToken accessToken:nil];
    
    id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
    
    
    // get any bid
    
    MMBidDetail *bidToCreate = [[MMBidDetail alloc] init];
    bidToCreate.additionalInformation = @"Blah Blah";
    bidToCreate.contactPhoneNumber = @"29837492";
    bidToCreate.deliveryVehicle = @"CAR";
    bidToCreate.deliveryWindowDays = [NSNumber numberWithInt:0];
    bidToCreate.bidId = nil;
    bidToCreate.jobId = [NSNumber numberWithInt:202];
    bidToCreate.pickupDate = [NSDate dateWithTimeIntervalSince1970:0];
    bidToCreate.status = @"Open";
    bidToCreate.price = [NSNumber numberWithInt:10];
    bidToCreate.userName = @"Greg";
    bidToCreate.userId = [NSNumber numberWithInt:341];
    bidToCreate.userRating = [NSNumber numberWithInt:3];
    
    // put bid together
    
    @try {
        [jobsClient createBidWithDetail:bidToCreate forJobWithId:202 withAccessToken:accessToken];
        STFail(@"Should never have reached this point");
    } @catch (NSException *ex) {
        STAssertTrue([ex isKindOfClass:[MMException class]], @"Exception was not correct type");    
        MMException *mex = (MMException *) ex;
        STAssertTrue([mex.containedError code] == 400, @"Error code was not correct");
    }
    
    [accessToken verify];
}



@end
