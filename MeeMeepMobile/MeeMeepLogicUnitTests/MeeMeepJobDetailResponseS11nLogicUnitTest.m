//
//  MeeMeepJobDetailResponseS11nLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 17/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MeeMeepJobDetailResponseS11nLogicUnitTest.h"

#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"
#import "MMSerialisationDateHelper.h"
#import "MMSerialisationDateHelperImpl.h"
#import "MMJobDetailResponse.h"
#import "MMJobDetailResponseSerialisation.h"
#import "MMJobAddress.h"
#import "MMRestDeserialisationException.h"
#import "MMJobItem.h"

@implementation MeeMeepJobDetailResponseS11nLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testJobDetailResponseDeserialisation {
    
    NSString *jobDetailResponseString = @"{\"success\":true,\"job\":{\"title\":\"Test\",\"auctionWon\":true,\"pickupDateEnd\":null,\"acceptedBid\":null,\"fromLat\":-34.92862119999999,\"dateCreated\":\"2013-02-24T23:30:10Z\",\"affiliateId\":null,\"displayPickupDate\":\"Flexible\",\"toLng\":145.2148612,\"lastUpdated\":\"2013-02-24T23:30:10Z\",\"pickupAddress\":null,\"deliveryAddress\":null,\"specialConsiderations\":[],\"jobCategoryId\":5,\"toLocation\":{\"class\":\"com.meemeep.portal.Location\",\"id\":101,\"address\":\"Sydney, NSW\",\"lat\":-33.8674869,\"lng\":151.2069902},\"deliveryTime\":null,\"deliveryDateEnd\":null,\"pickupDateStart\":null,\"jobCategory\":{\"class\":\"com.meemeep.portal.JobCategory\",\"id\":5,\"lastUpdated\":\"2013-02-24T22:01:35Z\",\"name\":\"General Delivery/Household goods\"},\"indemnityId\":null,\"pickupTime\":null,\"displayDeliveryDate\":\"Flexible\",\"bidding\":false,\"status\":\"JOB_CREATED\",\"totalMessageCount\":0,\"deliveryDateStart\":null,\"fromLng\":138.5999594,\"toLat\":-37.9874598,\"indemnity\":null,\"user\":{\"transportProvider\":false,\"displayName\":\"Cameron M\",\"id\":129},\"affiliate\":null,\"affiliateJobId\":null,\"distance\":757.19,\"acceptedBidId\":null,\"fromLocation\":{\"class\":\"com.meemeep.portal.Location\",\"id\":100,\"address\":\"Melbourne, VIC\",\"lat\":-37.814107,\"lng\":144.96328},\"items\":[{\"height\":3,\"description\":\"Test\",\"dateCreated\":\"2013-02-24T23:30:10Z\",\"weight\":23,\"width\":2,\"jobId\":138,\"imageId\":null,\"length\":1,\"lastUpdated\":\"2013-02-24T23:30:10Z\",\"weightUnit\":\"kgs\",\"id\":137}],\"id\":138}}";
        
    NSData *jobDetailResponseBody = [jobDetailResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    
    MMJobDetailResponseSerialisation *serialisation = [factory getMMJobDetailResponseSerialisation];
    
    MMJobDetailResponse *jobDetailResponse = [serialisation deserialiseData:jobDetailResponseBody];
    
    STAssertNotNil(jobDetailResponse, @"Job detail response nil after serialisation");
    
    MMJobDetail *jobDetail = jobDetailResponse.jobDetail;
    
    // confirm job detail is deserialised correctly
    STAssertTrue([jobDetail.title isEqualToString:@"Test"], @"Title not expected");
    STAssertNil(jobDetail.affiliateID, @"Affilliate ID not expected");
    STAssertNil(jobDetail.affiliateJobID, @"Affilliate Job ID not expected");
    STAssertNil(jobDetail.deliveryTime, @"DeliveryTime not expected");
    STAssertNil(jobDetail.pickupTime, @"PickupTime not expected");
    
    STAssertTrue([jobDetail.fromLocation.address isEqualToString:@"Melbourne, VIC"],
                 @"FromLocation not expected");
    STAssertTrue([jobDetail.toLocation.address isEqualToString:@"Sydney, NSW"], @"ToLocation not expected");
    
    STAssertEquals([jobDetail.distance floatValue], 757.19f, @"Distance not expected");
    STAssertTrue([jobDetail.jobStatus is:JOB_CREATED], @"Job status not expected");
    
    STAssertTrue([jobDetail.items count] == 1, @"Incorrect number of items");
    for(MMJobItem* item in jobDetail.items) {
        STAssertTrue([item.description isEqualToString:@"Test"], @"Incorrect item description");
        STAssertTrue([item.weight isEqualToNumber:[NSNumber numberWithInt:23]], @"Incorrect item weight");
        STAssertTrue([item.weightUnit isEqualToString:@"kgs"], @"Incorrect weight units");
        STAssertTrue([item.width isEqualToNumber:[NSNumber numberWithInt:2]], @"Incorrect item width");
        STAssertTrue([item.length isEqualToNumber:[NSNumber numberWithInt:1]], @"Incorrect item length");
        STAssertTrue([item.height isEqualToNumber:[NSNumber numberWithInt:3]], @"Incorrect item height");

    }
}

- (void) testJobDetailResponseS11nBadInputData {
    @try {
        NSString *jobDetailResponseString = @"Bogus";
        
        //Broken input
        
        NSData *jobDetailResponseBody = [jobDetailResponseString dataUsingEncoding:NSUTF8StringEncoding];
        
        id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
        
        MMJobDetailResponseSerialisation *serialisation = [factory getMMJobDetailResponseSerialisation];
        [serialisation deserialiseData:jobDetailResponseBody];
        STFail(@"Should not have reached here!");
    } @catch (NSException *ex) {
        STAssertTrue([ex isKindOfClass:[MMRestDeserialisationException class]], @"Exception was not of expected type");
    }
}

- (void) testJobDetailResponseS11nNilInputData {
    @try {
        id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
        
        MMJobDetailResponseSerialisation *serialisation = [factory getMMJobDetailResponseSerialisation];
        [serialisation deserialiseData:nil];
        STFail(@"Should not have reached here!");
    } @catch (NSException *ex) {
        STAssertTrue([ex isKindOfClass:[MMRestDeserialisationException class]], @"Exception was not of expected type");
    }
}

@end
