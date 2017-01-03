//
//  MMCanOfferIndemnityResponseSerialisationUnitTest.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 23/04/13.
//
//

#import "MMCanOfferIndemnityResponseSerialisationUnitTest.h"
#import "MMCanOfferIndemnityResponseSerialisation.h"
#import "MMCanOfferIndemnityResponse.h"

@implementation MMCanOfferIndemnityResponseSerialisationUnitTest

-(void) testDeserialiseTrue {
    NSString* response = @"{\"canOfferIndemnity\":true }";

    MMCanOfferIndemnityResponseSerialisation* serialiser = [[MMCanOfferIndemnityResponseSerialisation alloc] init];
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    MMCanOfferIndemnityResponse* respObj = [serialiser deserialiseData:data];
    
    STAssertNotNil(respObj, @"Response object should not be nil");
    STAssertTrue(respObj.canOffer, @"Can offer should be true");
    STAssertTrue(respObj.userExists, @"User exists should be true");
}

-(void) testDeserialiseFalse {
    NSString* response = @"{\"canOfferIndemnity\":false }";
    
    MMCanOfferIndemnityResponseSerialisation* serialiser = [[MMCanOfferIndemnityResponseSerialisation alloc] init];
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    MMCanOfferIndemnityResponse* respObj = [serialiser deserialiseData:data];
    
    STAssertNotNil(respObj, @"Response object should not be nil");
    STAssertFalse(respObj.canOffer, @"Can offer should be false");
    STAssertTrue(respObj.userExists, @"User exists should be true");
}

-(void) testDeserialiseDoesNotExist {
    NSString* response = @"{\"canOfferIndemnity\":null }";
    
    MMCanOfferIndemnityResponseSerialisation* serialiser = [[MMCanOfferIndemnityResponseSerialisation alloc] init];
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    MMCanOfferIndemnityResponse* respObj = [serialiser deserialiseData:data];
    
    STAssertNotNil(respObj, @"Response object should not be nil");
    STAssertFalse(respObj.canOffer, @"Can offer should be false");
    STAssertFalse(respObj.userExists, @"User exists should be false");
}

@end
