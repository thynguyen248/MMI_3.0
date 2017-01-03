//
//  MMBidAcceptUnitTest.m
//  MeeMeepMobile
//
//  Created by Julian Raff on 3/04/13.
//
//

#import "MMBidAcceptUnitTest.h"

#import "MMBidAcceptRequest.h"
#import "MMJobIndemnity.h"
#import "MMJobAddress.h"
#import "GUICommon.h"

@implementation MMBidAcceptUnitTest
- (void)testMarshallWithIndemnity {
    @try {
        NSNumber* bidId = [NSNumber numberWithInt:123];
        NSString* mobileNumber = @"0412345678";
        NSNumber* indemnityId = [NSNumber numberWithInt:4];
        
        // Setup data
        MMBidAcceptRequest* request = [[MMBidAcceptRequest alloc] init];
        request.mobileNumber = mobileNumber;
        request.bidId = bidId;
        
        MMJobIndemnity* indemnity = [[MMJobIndemnity alloc] init];
        indemnity.indemnityId = indemnityId;
        request.indemnity = indemnity;
        
        request.fromAddress = @"100 Swanston Street";
        request.toAddress = @"5 Queens Road";
        
        // Convert to dictionary
        NSDictionary* dict = [request getAsDictionary];
        
        // Check
        STAssertNotNil(dict, @"Marshalled bid accept object is nil");
        
        STAssertTrue([bidId isEqualToNumber:[dict valueForKey:@"id"]], @"Bid ID is incorrect");
        STAssertTrue([mobileNumber isEqualToString:[dict valueForKey:@"mobileNumber"]], @"Mobile number is incorrect");
        STAssertTrue([indemnityId isEqualToNumber:[dict valueForKey:@"indemnitySelector"]], @"Indemnity ID is incorrect");
        STAssertNotNil([dict valueForKey:@"hasIndemnity"], @"HasIndemnity is nill");
        
        STAssertTrue([@"100 Swanston Street" isEqualToString:[dict valueForKey:@"pickupAddress"]], @"Pickup Address is incorrect");
        STAssertTrue([@"5 Queens Road" isEqualToString:[dict valueForKey:@"deliveryAddress"]], @"Delivery Address is incorrect");
    }
    @catch (NSException *exception) {
        STFail(@"Unexpected exception occurred");
    }
}

- (void)testMarshallWithoutIndemnity {
    @try {
        NSNumber* bidId = [NSNumber numberWithInt:123];
        NSString* mobileNumber = @"0412345678";
        
        // Setup data
        MMBidAcceptRequest* request = [[MMBidAcceptRequest alloc] init];
        request.mobileNumber = mobileNumber;
        request.bidId = bidId;
        
        request.indemnity = [MMJobIndemnity getNoneObject];
        
        request.fromAddress = @"100 Swanston Street";
        request.toAddress = @"5 Queens Road";
        
        // Convert to dictionary
        NSDictionary* dict = [request getAsDictionary];
        
        // Check
        STAssertNotNil(dict, @"Marshalled bid accept object is nil");
        
        STAssertTrue([bidId isEqualToNumber:[dict valueForKey:@"id"]], @"Bid ID is incorrect");
        STAssertTrue([mobileNumber isEqualToString:[dict valueForKey:@"mobileNumber"]], @"Mobile number is incorrect");
        STAssertNil([dict valueForKey:@"indemnitySelector"], @"Indemnity Selector is not nill");
        STAssertNil([dict valueForKey:@"hasIndemnity"], @"HasIndemnity is not nill");
        
        STAssertTrue([@"100 Swanston Street" isEqualToString:[dict valueForKey:@"pickupAddress"]], @"Pickup Address is incorrect");
        STAssertTrue([@"5 Queens Road" isEqualToString:[dict valueForKey:@"deliveryAddress"]], @"Delivery Address is incorrect");
    }
    @catch (NSException *exception) {
        STFail(@"Unexpected exception occurred");
    }
}

@end
