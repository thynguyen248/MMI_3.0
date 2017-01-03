//
//  MMGetBidDetailsUnitTest.m
//  MeeMeepMobile
//
//  Created by Julian Raff on 22/03/13.
//
//

#import "MMGetBidDetailsUnitTest.h"
#import "MMBidDetail.h"
#import "MMSerialisationUtils.h"

@implementation MMGetBidDetailsUnitTest

- (void)testUnmarshall {
    @try {
        NSString* response = @"{ \"bid\": { \"acceptedConditions\": true, \"deliveryType\": { \"class\": \"com.meemeep.portal.DeliveryType\", \"id\": 32, \"lastUpdated\": \"2013-03-20T05:49:21Z\", \"type\": \"Car\" }, \"deliveryDateEnd\": \"2013-03-24T05:49:36Z\", \"lastUpdated\": \"2013-03-20T05:49:36Z\", \"pickupTime\": \"Before 8am\", \"amount\": 5, \"status\": \"BID_CREATED\", \"expiryDate\": \"2013-03-20T05:49:36Z\", \"pickupDateEnd\": \"2013-03-21T05:49:36Z\", \"jobId\": 154, \"deliveryDateStart\": \"2013-03-23T05:49:36Z\", \"dateAccepted\": \"2013-03-19T05:49:36Z\", \"pickupDateStart\": \"2013-03-20T05:49:36Z\", \"dateCreated\": \"2013-03-20T05:49:36Z\", \"deliveryTime\": \"After 6pm\", \"user\": { \"id\": 50, \"displayName\": \"Admin U\" }, \"rating\": 4, \"id\": 130 } } ";
        NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *bidResponseDict = [MMSerialisationUtils deserialiseData:data];
        
        MMBidDetail *bidDetail = [MMBidDetail getBidDetailFromDictionary:[bidResponseDict valueForKey:@"bid"]];
        
        STAssertNotNil(bidDetail, @"Unmarshalled bid object is nil");
        
        STAssertTrue([bidDetail.userId isEqualToNumber:[NSNumber numberWithInt:50]], @"User ID is incorrect");
        STAssertTrue([bidDetail.bidId isEqualToNumber:[NSNumber numberWithInt:130]], @"Bid ID is incorrect");
        STAssertTrue([bidDetail.jobId isEqualToNumber:[NSNumber numberWithInt:154]], @"Job ID is incorrect");
        STAssertTrue([bidDetail.price isEqualToNumber:[NSNumber numberWithInt:5]], @"Price is incorrect");
        STAssertTrue([bidDetail.userRating isEqualToNumber:[NSNumber numberWithInt:4]], @"User Rating is incorrect");
        
        STAssertTrue([bidDetail.pickupTime isEqualToString:@"Before 8am"], @"Pickup time is incorrect");
        STAssertTrue([bidDetail.deliveryTime isEqualToString:@"After 6pm"], @"Delivery time is incorrect");
        STAssertTrue([bidDetail.deliveryVehicle isEqualToString:@"Car"], @"Delivery Vehicle is incorrect");
        STAssertTrue([bidDetail.status isEqualToString:@"BID_CREATED"], @"Status is incorrect");
        STAssertTrue([bidDetail.userName isEqualToString:@"Admin U"], @"Username is incorrect");
        
        STAssertTrue([bidDetail.expiryDate isEqualToDate:[MMSerialisationUtils getDateFromRFC3339String:@"2013-03-20T05:49:36Z"]], @"Pickup Date is incorrect");
        STAssertTrue([bidDetail.pickupDate isEqualToDate:[MMSerialisationUtils getDateFromRFC3339String:@"2013-03-20T05:49:36Z"]], @"Pickup Date is incorrect");
        STAssertTrue([bidDetail.deliveryDate isEqualToDate:[MMSerialisationUtils getDateFromRFC3339String:@"2013-03-24T05:49:36Z"]], @"Delivery Date is incorrect");
        
        
//        STAssertTrue([bidDetail.acceptedDate isEqualToDate:[MMSerialisationUtils getDateFromRFC3339String:@"2013-03-19T05:49:36Z"]], @"Pickup Date is incorrect");
        
    }
    @catch (NSException *exception) {
        STFail(@"Unexpected exception occurred");
    }
}

@end
