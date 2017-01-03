//
//  MMBidCreationSerialisationUnitTest.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 14/03/13.
//
//

#import "MMBidCreationRequestSerialisationUnitTest.h"
#import "MMBidCreationRequestSerialisation.h"
#import "MMBidDetail.h"
#import "MMBidCreationRequest.h"
#import "UnitTestHelper.h"
#import "OCMock.h"

@interface MMBidCreationRequestSerialisation(Privates)

@end


@implementation MMBidCreationSerialisationUnitTest

-(MMBidCreationRequest*) mockBidCreationRequest:(MMBidDetail *) bidDetail {
    id mock = [OCMockObject mockForClass:[MMBidCreationRequest class]];
    
    [[[mock expect] andReturn:bidDetail] bidDetail];
    
    return mock;
}

-(MMBidDetail*) mockBidDetail:(NSInteger) userId jobId:(NSInteger)jobId price:(NSInteger) price
pickupTime:(NSString *) pickupTime pickupDate:(NSDate *)pickupDate deliveryTime:(NSString *) deliveryTime
deliveryDate:(NSDate *)deliveryDate expiryDate:(NSDate *)expiryDate deliveryTypeID:(NSInteger)deliveryTypeID
acceptedConditions:(NSString*) acceptedConditions {
    id mock = [OCMockObject mockForClass:[MMBidDetail class]];
    
    [[[mock expect] andReturn:[NSNumber numberWithInt:userId] ] userId];
    [[[mock expect] andReturn:[NSNumber numberWithInt:jobId] ] jobId];
    [[[mock expect] andReturn:[NSNumber numberWithInt:price] ] price];
    [[[mock expect] andReturn:pickupTime ] pickupTime];
    [[[mock expect] andReturn:pickupDate ] pickupDate];
    [[[mock expect] andReturn:deliveryTime ] deliveryTime];
    [[[mock expect] andReturn:deliveryDate ] deliveryDate];
    [[[mock expect] andReturn:expiryDate ] expiryDate];
    [[[mock expect] andReturn:[NSNumber numberWithInt:deliveryTypeID] ] deliveryTypeID];
    
    return mock;
}

-(id<MMSerialisationDateHelper>) mockDateHelper {
    id mock = [OCMockObject mockForProtocol:@protocol(MMSerialisationDateHelper)];
    
    return mock;
}

-(void) addStringFromDateExpectation:(id) mock date:(NSDate *)date {
    [[[mock expect] andReturn:@"12/01/2013"] toStringFromDateTime:date];
}

-(void) testSerialiseFailureNilInput {
    id dateHelper = [self mockDateHelper];
    
    MMBidCreationRequestSerialisation* underTest = [[MMBidCreationRequestSerialisation alloc] initWithDateS11nHelper:dateHelper];
    @try {
        [underTest serialise:nil];
        STFail(@"Expected exception did not occur");
    } @catch(NSException* exception) {
        STAssertTrue([exception.reason hasPrefix:@"Could not serialise"], @"Wrong exception text");
    }
}

-(void) testSerialiseFailureWrongInput {
    id dateHelper = [self mockDateHelper];
    
    MMBidCreationRequestSerialisation* underTest = [[MMBidCreationRequestSerialisation alloc] initWithDateS11nHelper:dateHelper];
    @try {
        //Just pass in any object that's not an MMBidCreationRequest
        [underTest serialise:dateHelper];
        STFail(@"Expected exception did not occur");
    } @catch(NSException* exception) {
        STAssertTrue([exception.reason hasPrefix:@"Could not serialise"], @"Wrong exception text");
    }
}

-(void) testSerialiseSuccess {
    @try {
        id dateHelper = [self mockDateHelper];
                
        MMBidCreationRequestSerialisation* underTest = [[MMBidCreationRequestSerialisation alloc] initWithDateS11nHelper:dateHelper];
    
        NSDate* pickupDate = [NSDate date];
        NSDate* deliveryDate = [NSDate date];
        NSDate* expiryDate = [NSDate date];
    
        [self addStringFromDateExpectation:dateHelper date:pickupDate];
        [self addStringFromDateExpectation:dateHelper date:deliveryDate];
        [self addStringFromDateExpectation:dateHelper date:expiryDate];
    
        id bidDetails = [self mockBidDetail:1 jobId:2 price:3 pickupTime:@"Before 8am" pickupDate:pickupDate deliveryTime:@"After 6pm" deliveryDate:deliveryDate expiryDate:expiryDate deliveryTypeID:7 acceptedConditions:@"YES"];
        MMBidCreationRequest* creationRequest = [[MMBidCreationRequest alloc] init];
        creationRequest.bidDetail = bidDetails;
    
        NSData* data = [underTest serialise:creationRequest];
        STAssertNotNil(data, @"Result data is nil");
        STAssertFalse(data.length == 0, @"Data has 0 length");
        [dateHelper verify];
        [bidDetails verify];
    } @catch(NSException *exception) {
        STFail(@"Unexpected exception occurred");
    }
}

-(void) testDeserialiseFailure {
    id dateHelper = [self mockDateHelper];
    
    MMBidCreationRequestSerialisation* underTest = [[MMBidCreationRequestSerialisation alloc] initWithDateS11nHelper:dateHelper];
    @try {
        [underTest deserialiseData:nil];
        STFail(@"Expected exception did not occur");
    } @catch(NSException* exception) {
        STAssertTrue([exception.reason hasPrefix:@"Deserialisation not implemented"], @"Wrong exception text");
    }
}

@end
