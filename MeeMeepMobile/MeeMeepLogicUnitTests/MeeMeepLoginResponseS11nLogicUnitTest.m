//
//  MeeMeepLoginResponseS11nLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 7/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MeeMeepLoginResponseS11nLogicUnitTest.h"

#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"
#import "MMLoginResponse.h"
#import "MMRestDeserialisationException.h"
#import "MMRestNotImplementedException.h"

@implementation MeeMeepLoginResponseS11nLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testDeserialiseLoginResponse {
    
    NSString *loginResponseString = @"{\"success\":true,\"id\":49,\"transportProvider\":false}";
    
    NSData *loginResponseData = [loginResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    
    MMLoginResponseSerialisation *responseS11n = [factory getMMLoginResponseSerialisation];
    
    MMLoginResponse *response = [responseS11n deserialiseData:loginResponseData];
            
    STAssertNotNil(response, @"Response was nil");
    
    STAssertTrue([response.userId intValue] == 49, @"Login response user id was not correct");
}

- (void) testDeserialiseLoginResponseBadData {
    @try {
        NSString *loginResponseString = @"Bogus";
        
        NSData *loginResponseData = [loginResponseString dataUsingEncoding:NSUTF8StringEncoding];
        
        id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
        
        MMLoginResponseSerialisation *responseS11n = [factory getMMLoginResponseSerialisation];
        
        [responseS11n deserialiseData:loginResponseData];
        STFail(@"Should never have got here!");
    } @catch (NSException *anyEx) {
        STAssertTrue([anyEx isKindOfClass:[MMRestDeserialisationException class]], @"Exception was not of expected type");
    }
}

- (void) testDeserialiseLoginResponseNilData {
    @try {
        id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
        
        MMLoginResponseSerialisation *responseS11n = [factory getMMLoginResponseSerialisation];
        
        [responseS11n deserialiseData:nil];
        STFail(@"Should never have got here!");
    } @catch (NSException *anyEx) {
        STAssertTrue([anyEx isKindOfClass:[MMRestDeserialisationException class]], @"Exception was not of expected type");
    }
}

@end
