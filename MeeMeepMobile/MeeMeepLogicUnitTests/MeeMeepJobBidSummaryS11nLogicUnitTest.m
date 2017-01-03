//
//  MeeMeepJobBidSummaryS11nLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 3/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MeeMeepJobBidSummaryS11nLogicUnitTest.h"

#import "MMSerialisationDateHelper.h"
#import "MMSerialisationDateHelperImpl.h"
#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"
#import "MMBidSummaryResponseSerialisation.h"
#import "MMBidSummaryResponse.h"
#import "MMRestDeserialisationException.h"


@implementation MeeMeepJobBidSummaryS11nLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testBidSummaryResponse {
    
    NSString *bidSummaryResponseString = @"{\"success\":true,\"bidList\":[{\"acceptedConditions\":true,\"deliveryDateEnd\":\"2013-05-05T22:23:27Z\",\"pickupDateStart\":\"2013-05-01T22:23:27Z\",\"lastUpdated\":\"2013-05-01T22:23:27Z\",\"jobId\":225,\"amount\":1.1,\"status\":\"BID_CREATED\",\"pickupTime\":null,\"pickupDateEnd\":\"2013-05-02T22:23:27Z\",\"expiryDate\":null,\"deliveryDateStart\":\"2013-05-04T22:23:27Z\",\"dateCreated\":\"2013-05-01T22:23:27Z\",\"dateAccepted\":null,\"deliveryType\":{\"class\":\"com.meemeep.portal.DeliveryType\",\"id\":35,\"lastUpdated\":\"2013-05-01T22:22:56Z\",\"type\":\"Car\"},\"deliveryTime\":null,\"user\":{\"id\":51,\"displayName\":\"Admin U\"},\"id\":246,\"rating\":0,\"ratingCount\":0},{\"acceptedConditions\":true,\"jobId\":225,\"status\":\"BID_CREATED\",\"pickupTime\":null,\"expiryDate\":null,\"lastUpdated\":\"2013-05-01T22:23:27Z\",\"amount\":1.2,\"pickupDateStart\":\"2013-05-01T22:23:27Z\",\"deliveryDateEnd\":\"2013-05-05T22:23:27Z\",\"dateAccepted\":null,\"deliveryDateStart\":\"2013-05-04T22:23:27Z\",\"pickupDateEnd\":\"2013-05-02T22:23:27Z\",\"dateCreated\":\"2013-05-01T22:23:27Z\",\"deliveryType\":{\"class\":\"com.meemeep.portal.DeliveryType\",\"id\":35,\"lastUpdated\":\"2013-05-01T22:22:56Z\",\"type\":\"Car\"},\"deliveryTime\":null,\"user\":{\"id\":53,\"displayName\":\"Bidding U\"},\"id\":249,\"rating\":3,\"ratingCount\":2},{\"lastUpdated\":\"2013-05-01T22:23:27Z\",\"acceptedConditions\":true,\"deliveryDateStart\":\"2013-05-04T22:23:27Z\",\"pickupDateEnd\":\"2013-05-02T22:23:27Z\",\"deliveryDateEnd\":\"2013-05-05T22:23:27Z\",\"jobId\":225,\"status\":\"BID_CREATED\",\"pickupTime\":null,\"pickupDateStart\":\"2013-05-01T22:23:27Z\",\"expiryDate\":null,\"dateCreated\":\"2013-05-01T22:23:27Z\",\"amount\":1.3,\"dateAccepted\":null,\"deliveryType\":{\"class\":\"com.meemeep.portal.DeliveryType\",\"id\":35,\"lastUpdated\":\"2013-05-01T22:22:56Z\",\"type\":\"Car\"},\"deliveryTime\":null,\"user\":{\"id\":51,\"displayName\":\"Admin U\"},\"id\":252,\"rating\":0,\"ratingCount\":0}]}";
    
    DLog(@"Response data: |%@|", bidSummaryResponseString);
    
    NSData *responseData = [bidSummaryResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
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
    
    MMBidSummaryResponseSerialisation *bidResponseS11n
    = [factory getMMBidSummaryResponseSerialisation];
    
    // serialise the payload
    
    MMBidSummaryResponse *response;
    
    @try {
        response = [bidResponseS11n deserialiseData:responseData];
    } @catch (NSException * ex) {
        STFail(@"Failed to parse response");
        return;
    }
    
    STAssertNotNil(response, @"Bid summary response was null");
    
    // confirm the payload looks as required
    
    // check that the payload contains a total of 3 objects
    
    // always check date deserialisation
    
    STAssertTrue([response.bids count] == 3, @"Incorrect number of bid responses");
    
    MMBidSummary *bidSummary = [response.bids objectAtIndex:0];
    
    STAssertEquals([bidSummary.bidId intValue], 246, @"Bid ID's did not match");
    
    STAssertEqualObjects(bidSummary.deliveryType, @"Car", @"Delivery type incorrect");
    
    NSString *username = bidSummary.userName;
    
    STAssertTrue([@"Admin U" isEqual:username], @"usernames do not match for first bid!");
    
    NSInteger userRating = [bidSummary.userRating intValue];
    
    STAssertTrue(userRating == 0, @"User rating was not correct!");
    
    STAssertTrue([bidSummary.status isEqualToString:@"BID_CREATED"], @"Status was not correct");

}

- (void) testBidSummaryS11nBadInputData {
    @try {
        NSString *bidSummaryResponseString = @"Bogus";
        
        // the date pickup date and the user for bid 246 should be nil
        
        NSData *responseData = [bidSummaryResponseString dataUsingEncoding:NSUTF8StringEncoding];
        
        // create the serialisation factory
        
        id<MMSerialisationFactory> factory
        = [[MMSerialisationFactoryImpl alloc] init];
        
        // get the bid summary serialisation object
        
        MMBidSummaryResponseSerialisation *bidResponseS11n
        = [factory getMMBidSummaryResponseSerialisation];
        
        // serialise the payload
        [bidResponseS11n deserialiseData:responseData];
        STFail(@"Should not have reached here!");
    } @catch (NSException *anyEx) {
        STAssertTrue([anyEx isKindOfClass:[MMRestDeserialisationException class]], @"Exception was not of expected type");
    }
}

- (void) testBidSummaryS11nNilInputData {
    @try {
        id<MMSerialisationFactory> factory
        = [[MMSerialisationFactoryImpl alloc] init];
        
        // get the bid summary serialisation object
        
        MMBidSummaryResponseSerialisation *bidResponseS11n
        = [factory getMMBidSummaryResponseSerialisation];
        
        // serialise the payload
        [bidResponseS11n deserialiseData:nil];
        STFail(@"Should not have reached here!");
    } @catch (NSException *anyEx) {
        STAssertTrue([anyEx isKindOfClass:[MMRestDeserialisationException class]], @"Exception was not of expected type");
    }
}

@end
