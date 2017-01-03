//
//  MeeMeepRecentJobSummaryResponseSerialisationLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MeeMeepRecentJobSummaryResponseS11nLogicUnitTest.h"
#import "MMRecentJobSummaryResponseSerialisation.h"
#import "MMRecentSummaryJobsResponse.h"
#import "MMJobSummary.h"
#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"
#import "MMRestDeserialisationException.h"
#import "MMRestNotImplementedException.h"
#import "MMLocation.h"

@implementation MeeMeepRecentJobSummaryResponseS11nLogicUnitTest

// All code under test must be linked into the Unit Test bundle

- (void)testSummaryJobsResponseDeserialisation {
    
    NSString *summaryJobsResponse = @"{\"jobs\":[{\"id\":240,\"title\":\"Camera, Chair\",\"status\":\"JOB_CREATED\",\"fromLocation\":{\"class\":\"com.meemeep.portal.Location\",\"id\":100,\"address\":\"Melbourne, VIC\",\"lat\":-37.814107,\"lng\":144.96328},\"toLocation\":{\"class\":\"com.meemeep.portal.Location\",\"id\":101,\"address\":\"Sydney, NSW\",\"lat\":-33.8674869,\"lng\":151.2069902},\"pickupDateStart\":\"2013-05-01T22:23:26Z\",\"deliveryDateEnd\":\"2013-05-04T22:23:26Z\",\"expiryDate\":\"2013-05-06T22:23:26Z\"},{\"id\":231,\"title\":\"Desk\",\"status\":\"BID_ACCEPTED\",\"fromLocation\":{\"class\":\"com.meemeep.portal.Location\",\"id\":98,\"address\":\"Croydon, VIC\",\"lat\":-37.796322,\"lng\":145.281036},\"toLocation\":{\"class\":\"com.meemeep.portal.Location\",\"id\":99,\"address\":\"Kilsyth, VIC\",\"lat\":-37.8022711,\"lng\":145.3078976},\"pickupDateStart\":\"2013-05-01T22:23:25Z\",\"deliveryDateEnd\":\"2013-05-04T22:23:25Z\",\"expiryDate\":\"2013-05-06T22:23:25Z\"}]}";
    
    DLog(@"summary jobs response = |%@|", summaryJobsResponse);
    
    NSData *responseData = [summaryJobsResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    
    MMRecentJobSummaryResponseSerialisation *serialisation 
        = [factory getMMRecentJobSummaryResponseSerialisation];
    
    MMRecentSummaryJobsResponse *response = [serialisation deserialiseData:responseData];
    
    STAssertNotNil(response, @"Oh no! could not deseralise response data!");
    STAssertEquals([response.jobs count], (NSUInteger)2, @"Wrong number of jobs parsed");
    
    MMJobSummary *firstJobSummary = [response.jobs objectAtIndex:0];
    
    STAssertNotNil(firstJobSummary, @"First job was nil!!");
    
    MMLocation *jobPickupLocation = firstJobSummary.fromLocation;
    
    STAssertNotNil(jobPickupLocation, @"Pickup suburb was nil");
    STAssertEqualObjects(jobPickupLocation.address, @"Melbourne, VIC",
                         @"Job pickup suburb was not correct value");
    
    // drop off suburb
    MMLocation *jobDropoffLocation = firstJobSummary.toLocation;
    STAssertNotNil(jobDropoffLocation, @"Drop off suburb was nil");
    STAssertEqualObjects(jobDropoffLocation.address, @"Sydney, NSW",
                         @"Job pickup suburb was not correct value");
    
    // id
    STAssertNotNil(firstJobSummary.jobId, @"Job id was nil");
    STAssertTrue([firstJobSummary.jobId isEqualToNumber:[NSNumber numberWithInt:240]], @"Job id was not expected");
    
    // job status
    STAssertNotNil(firstJobSummary.jobStatus, @"Job status was nil");
    STAssertTrue([firstJobSummary.jobStatus is:JOB_CREATED], @"Job status was not expected");
    
    // title
    
    STAssertTrue([firstJobSummary.title isEqualToString:@"Camera, Chair"], @"Incorrect job title");

}

- (void) testSummaryJobsResponseS11nBadData {
    @try {
        NSString *summaryJobsResponse = @"Bogus";
        
        // missing a leading '"' on JobStatus for the jobid 200
        
        NSData *responseData = [summaryJobsResponse dataUsingEncoding:NSUTF8StringEncoding];
        
        id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
        
        MMRecentJobSummaryResponseSerialisation *serialisation 
        = [factory getMMRecentJobSummaryResponseSerialisation];
        
        [serialisation deserialiseData:responseData];
        STFail(@"Should not have got to this point!");
        
    } @catch (NSException *anyEx) {
        STAssertTrue([anyEx isKindOfClass:[MMRestDeserialisationException class]], @"Exception type was not expected");
    }
}

- (void) testSummaryJobsResponseS11nNilData {
    @try {
        id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
        
        MMRecentJobSummaryResponseSerialisation *serialisation 
        = [factory getMMRecentJobSummaryResponseSerialisation];
        
        [serialisation deserialiseData:nil];
        STFail(@"Should not have got to this point!");
        
    } @catch (NSException *anyEx) {
        STAssertTrue([anyEx isKindOfClass:[MMRestDeserialisationException class]], @"Exception type was not expected");
    }
}

@end
