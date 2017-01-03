//
//  MeeMeepLogicUnitTests.m
//  MeeMeepLogicUnitTests
//
//  Created by Greg Soertsz on 24/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MeeMeepLogicUnitTests.h"

#import "MMRestClientFactory.h"
#import "MMRestClientFactoryImpl.h"
#import "MMRestClient.h"
#import "MMJobDetail.h"

#import "AppDelegateMMRestClientUtils.h"

@implementation MeeMeepLogicUnitTests

- (void) setUp {
    
    [super setUp];
    
    meemeepURL = [[AppDelegateMMRestClientUtils getMMRestConfiguration] objectForKey:@"MeeMeepRestClientURL"];
}


- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testCreateRestClient {
        
    id<MMRestClientFactory> factory = [[MMRestClientFactoryImpl alloc] initWithUrl:meemeepURL];
    id<MMRestClient> client = [factory createRestClient:YES];
    
    STAssertNotNil(client, @"Created client was nil");
}

- (void) testSerialiseObject {
    // we should test that an expected response is marshalled properly
//    
//    NSString *jsonObject = @"Some data that should be JSON";
//    NSData *jsonObjectAsData = [jsonObject dataUsingEncoding:NSUTF8StringEncoding];
//    STAssertNotNil(jsonObjectAsData, @"Should not be nil!");
//    
//    id<MMSerialisationFactory> mockFactory = nil; // find something for this
//    id<MMRestHttpTransmission> mockTx = nil;
//    
//    id<MMRestClientFactory> factory 
//            = [[MMRestClientFactoryImpl alloc] 
//                    initWithTransmission:mockTx 
//                    s11nFactory:mockFactory
//                    meemeepUrl:nil];
//    
//    id<MMRestClient> restClient = [factory createRestClient:YES];
//    
//    id<MMRestJobsClient> jobsClient = [restClient getJobsClient];
//    
//    NSArray * jobArray = [jobsClient getRecentlyPostedSummaryJobs];
//    
//    STAssertNil(jobArray, @"This should be nil!");
}

@end
