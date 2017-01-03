//
//  MMRestBidClientLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 3/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestBidClientLogicUnitTest.h"

#import "MMRestHttpResponse.h"
#import "MMMockRestHttpTransmissionImpl.h"
#import "MMMockHttpTransmissionGetMatcherImpl.h"
#import "MMRestBidClientImpl.h"

#import "MMRestHttpTransmission.h"
#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"
#import "MMRestClientFactory.h"
#import "MMRestClientFactoryImpl.h"
#import "MMException.h"
#import "MMRestAuthorisationClient.h"
#import "AppDelegateMMRestClientUtils.h"
#import "UnitTestHelper.h"
#import "OCMock.h"

@implementation MMRestBidClientLogicUnitTest

#pragma mark - Setup / teardown code

-(void) testCreateBidSuccess {
    id httpComms = [UnitTestHelper mockRestHttpTransmission];
    id authorisedHttpComms = [UnitTestHelper mockHttpAuthTransmission];
    id serialisationFactory = [UnitTestHelper mockSerialisationFactory];
    id serialiser = [UnitTestHelper mockBidCreationRequestSerialisation];
    id errorSerialiser = [UnitTestHelper mockRestErrorSerialisation];
    [UnitTestHelper addGetMMRestErrorSerialisation:serialisationFactory result:errorSerialiser];
    [UnitTestHelper addGetMMBidCreationRequestSerialisation:serialisationFactory result:serialiser];
    id data = [UnitTestHelper mockNSData];
    
    NSString* baseURL = @"/base";
    NSString* publicRelativePath = @"public";
    NSString* secureRelativePath = @"secure";
        
    id<MMRestBidClient> bidClient = [[MMRestBidClientImpl alloc] initWithTransmission:httpComms authTrans:authorisedHttpComms s11nFactory:serialisationFactory baseUrl:baseURL andPublicRelativePath:publicRelativePath andSecureRelativePath:secureRelativePath];
    
    NSNumber* jobID = [NSNumber numberWithInt:2];
    MMBidDetail *bidToCreate = [[MMBidDetail alloc] init];
    bidToCreate.userId = [NSNumber numberWithInt:1];
    bidToCreate.jobId = jobID;
    bidToCreate.price = [NSNumber numberWithInt:10];
    bidToCreate.pickupTime = @"Anytime";
    bidToCreate.deliveryTime = @"Anytime";
    bidToCreate.deliveryTypeID = [NSNumber numberWithInt:35];
    bidToCreate.pickupDate = [NSDate date];
    bidToCreate.deliveryDate = [NSDate date];
    bidToCreate.expiryDate = [NSDate date];
    
    [UnitTestHelper addSerialiseExpectations:serialiser input:[OCMArg isNotNil] result:data];
    id accessToken = [UnitTestHelper mockRestAccessToken];
    
    id httpResponse = [UnitTestHelper mockHttpResponse];
    [UnitTestHelper addIsRemoteErrorExpectations:httpResponse result:FALSE];
    [UnitTestHelper addLocalErrorExpectations:httpResponse result:nil];
    [UnitTestHelper addResponseCodeExpectations:httpResponse result:201];
    
    [UnitTestHelper addAuthorisedMethodExpectations:authorisedHttpComms method:@"POST" url:@"/base/secure/save" body:data additionalRequestHeaders:[OCMArg isNotNil] accessToken:accessToken result:httpResponse];
    
    BOOL created = [bidClient createBidWithDetail:bidToCreate forJobWithId:[jobID intValue] withAccessToken:accessToken];
    
    STAssertTrue(created, @"Bid could not be created");
    [httpComms verify];
    [authorisedHttpComms verify];
    [serialiser verify];
    [errorSerialiser verify];
    [serialisationFactory verify];
    [accessToken verify];
    [data verify];
    [httpResponse verify];
}

@end
