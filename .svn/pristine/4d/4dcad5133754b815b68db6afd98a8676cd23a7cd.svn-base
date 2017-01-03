//
//  MeeMeepBidDetailResponseS11nLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 3/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MeeMeepBidDetailResponseS11nLogicUnitTest.h"

#import "MMSerialisationDateHelper.h"
#import "MMSerialisationDateHelperImpl.h"
#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"

#import "MMBidDetail.h"
#import "MMBidDetailResponse.h"
#import "MMBidDetailResponseSerialisation.h"

#import "MMRestDeserialisationException.h"

@implementation MeeMeepBidDetailResponseS11nLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testBidDetailResponseS11n {
    
    NSString *bidDetailResponseString = @"{\"bid\": { \"acceptedConditions\": true,\"deliveryType\": { \"class\": \"com.meemeep.portal.DeliveryType\", \"id\": 32, \"lastUpdated\": \"2013-03-20T05:49:21Z\", \"type\": \"Car\" }, \"deliveryDateEnd\": \"2013-03-24T05:49:36Z\", \"lastUpdated\": \"2013-03-20T05:49:36Z\", \"pickupTime\": null, \"amount\": 5, \"status\": \"BID_CREATED\", \"expiryDate\": null, \"pickupDateEnd\": \"2013-03-21T05:49:36Z\", \"jobId\": 154, \"deliveryDateStart\": \"2013-03-23T05:49:36Z\", \"dateAccepted\": null, \"pickupDateStart\": \"2013-03-20T05:49:36Z\", \"dateCreated\": \"2013-03-20T05:49:36Z\", \"deliveryTime\": null, \"user\": { \"id\": 47, \"displayName\": \"Neon\" }, \"id\": 179 } }";
    
    DLog(@"Response data: |%@|", bidDetailResponseString);
    
    NSData *responseData = [bidDetailResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    // create the date formatter
    NSTimeZone *tz = [[NSTimeZone alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSString *dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSSZZZZ";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    [formatter setLocale:locale];
    [formatter setTimeZone:tz];
    
    // create the date helper
    
    id<MMSerialisationDateHelper> dateSerialisation = 
    [[MMSerialisationDateHelperImpl alloc] initWithDateFormatterToString:nil toDate:formatter];
    
    // create the serialisation factory
    
    id<MMSerialisationFactory> factory
    = [[MMSerialisationFactoryImpl alloc] initWithS11nDateHelper:dateSerialisation];
    
    // get the bid summary serialisation object
    
    MMBidDetailResponseSerialisation *bidResponseS11n
    = [factory getMMBidDetailResponseSerialisation];
    
    // serialise the payload
    
    MMBidDetailResponse *response = [bidResponseS11n deserialiseData:responseData];
    
    STAssertNotNil(response, @"Bid detail response was null");
    
    // confirm the payload looks as required
    
    // always check date deserialisation
    
    MMBidDetail *bidDetail = response.bidDetail;
    
    STAssertNotNil(bidDetail, @"Bid detail was nil");
    
    STAssertEquals([bidDetail.bidId intValue], 179, @"Bid ID's did not match");
    
    NSDate *pickupDate = bidDetail.pickupDate;
    
    STAssertNotNil([pickupDate description], @"Date not correctly deserialised");
    
    NSString *username = bidDetail.userName;
    
    STAssertTrue([@"Neon" isEqual:username], @"usernames do not match for first bid!");
    
}

- (void) testBidDetailResponseBadInputData {
    @try {
        NSString *bidDetailResponseString = @"Bogus";
        
        // username is missing a trailing '"' character
        
        DLog(@"Response data: |%@|", bidDetailResponseString);
        
        NSData *responseData = [bidDetailResponseString dataUsingEncoding:NSUTF8StringEncoding];
        
        id<MMSerialisationFactory> factory
        = [[MMSerialisationFactoryImpl alloc] init];
        
        // get the bid summary serialisation object
        
        MMBidDetailResponseSerialisation *bidResponseS11n
        = [factory getMMBidDetailResponseSerialisation];
        
        // serialise the payload
        
        [bidResponseS11n deserialiseData:responseData];
        STFail(@"Should not have reached here!");
    } @catch (NSException *anyEx) {
        STAssertTrue([anyEx isKindOfClass:[MMRestDeserialisationException class]], @"Exception was not of expected type");
    }
}

- (void) testBidDetailResponseNilInputData {
    @try {
        id<MMSerialisationFactory> factory
        = [[MMSerialisationFactoryImpl alloc] init];
        
        // get the bid summary serialisation object
        
        MMBidDetailResponseSerialisation *bidResponseS11n
        = [factory getMMBidDetailResponseSerialisation];
        
        [bidResponseS11n deserialiseData:nil];
        STFail(@"Should not have reached here!");
    } @catch (NSException *anyEx) {
        STAssertTrue([anyEx isKindOfClass:[MMRestDeserialisationException class]], @"Exception was not of expected type");
    }
}



@end
