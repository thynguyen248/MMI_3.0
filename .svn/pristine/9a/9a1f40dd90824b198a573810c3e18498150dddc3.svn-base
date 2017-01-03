//
//  MMRestErrorS11nLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 30/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestErrorS11nLogicUnitTest.h"

#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"
#import "MMRestErrorSerialisation.h"
#import "MMRestError.h"
#import "MMRestDeserialisationException.h"

@implementation MMRestErrorS11nLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testDeserialiseErrorSuccess {
    NSString *errorResponse = @"{\"Links\":null,\"error\":\"UserId is required to perform this operation but was not in the request.\",\"Reason\":\"The request was not valid\",\"StatusCode\":400}";
    
    NSData *errorData = [errorResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    
    MMRestErrorSerialisation *s11n = [factory getMMRestErrorSerialisation];
    
    MMRestError *error = [s11n deserialiseData:errorData];
    
    STAssertNotNil(error, @"error was nil");
    
    STAssertTrue([error.detail isEqualToString:@"UserId is required to perform this operation but was not in the request."], @"Error description was not correct");
}

- (void) testDeserialiseErrorBadJSON {
    NSString *badJSONErrorString = @"{\"Links\":null,\"Details\":\"UserId is required to perform this operation but was not in the request.,\"Reason\":\"The request was not valid\",\"StatusCode\":400}";
    
    NSData *errorData = [badJSONErrorString dataUsingEncoding:NSUTF8StringEncoding];
    
    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    
    MMRestErrorSerialisation *s11n = [factory getMMRestErrorSerialisation];

    @try {
        [s11n deserialiseData:errorData];
        STFail(@"Should not have reached this point");
    } @catch (NSException *ex) {
        STAssertTrue([ex isKindOfClass:[MMRestDeserialisationException class]], @"Exception was not of expected type");
    }
}

- (void) testDeserialisationErrorNilInput {    
    
    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    
    MMRestErrorSerialisation *s11n = [factory getMMRestErrorSerialisation];
    
    @try {
        [s11n deserialiseData:nil];
        STFail(@"Should not have reached this point");
    } @catch (NSException *ex) {
        STAssertTrue([ex isKindOfClass:[MMRestDeserialisationException class]], @"Exception was not of expected type");
    }

}

@end
