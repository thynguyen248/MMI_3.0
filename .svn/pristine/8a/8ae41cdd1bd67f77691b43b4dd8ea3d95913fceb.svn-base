//
//  MMRestErrorLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 1/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestErrorLogicUnitTest.h"
#import "MMRestError.h"
#import "MMErrorUtils.h"
#import "MMRestHttpResponse.h"
#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"

@implementation MMRestErrorLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testErrorDetailFromDictionary {
    NSMutableDictionary *jsonResultDict = [[NSMutableDictionary alloc] init];
    [jsonResultDict setValue:@"Details" forKey:@"error"];
    [jsonResultDict setValue:[NSNumber numberWithInt:400] forKey:@"StatusCode"];
//    [jsonResultDict setValue:@"Reason" forKey:@"Reason"];
    
    MMRestError *resultError = [MMRestError errorFromDictionary:jsonResultDict];
    STAssertNotNil(resultError, @"Resting JSON object was nil");
    STAssertTrue([resultError.detail isEqualToString:@"Details"], @"Details was not as expected");
    //STAssertTrue([resultError.statusCode intValue] == 400, @"Status code was not as expected");
    STAssertTrue([resultError.reason isEqualToString:@"Details"], @"Reason was not as expected");
}

- (void) testErrorFromMMRestError {
    MMRestError *mmRestError = [[MMRestError alloc] initWithDetail:@"Some major error" reason:@"This is the reason" statusCode:[NSNumber numberWithInt:456]];
    
    NSError *derivedError = [mmRestError error];
    
    STAssertTrue([mmRestError.detail isEqualToString:derivedError.localizedDescription], @"Description was not the same as detail!");
    STAssertTrue([mmRestError.reason isEqualToString:derivedError.localizedFailureReason], @"Reason was not the same");
} 

- (void) testThrowMMExceptionOnRestError {
    
    NSString *errorResponseString = @"{\"Links\":null,\"Details\":\"Transaction Failed\",\"Reason\":\"The request was not valid\",\"StatusCode\":400}";
    NSData *errorResponseData = [errorResponseString dataUsingEncoding:NSUTF8StringEncoding];

    MMRestHttpResponse *dudRemoteResponse = [[MMRestHttpResponse alloc] initWithBody:errorResponseData responseCode:400 headers:nil params:nil orLocalError:nil];
    dudRemoteResponse.isRemoteRestError = YES;
    
    id<MMSerialisationFactory> fact = [[MMSerialisationFactoryImpl alloc] init];
    
    @try {
        
        [MMErrorUtils throwMMExceptionForResponseOnError:dudRemoteResponse withReason:@"Remote error received" deserialisedWith:[fact getMMRestErrorSerialisation]];
        
        STFail(@"Should not have got here"); 
    } @catch (NSException *anyEx) {
        STAssertTrue([anyEx isKindOfClass:[MMException class]], @"Exception was not correct type");
        MMException *ex = (MMException *) anyEx;
        
        NSError *error = ex.containedError;
        STAssertTrue(error.code == 400, @"Status code was not nil");
    }
}

- (void) testThrowMMExceptionOnLocalError {
    
    NSMutableDictionary *errUserInfo = [[NSMutableDictionary alloc] init];
    [errUserInfo setValue:@"Not connected to internet" forKey:NSLocalizedDescriptionKey];
    [errUserInfo setValue:@"Connection settings" forKey:NSLocalizedFailureReasonErrorKey];
    
    NSError *localError = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:NSURLErrorNotConnectedToInternet userInfo:errUserInfo];
    
    MMRestHttpResponse *dudRemoteResponse = [[MMRestHttpResponse alloc] initWithBody:nil responseCode:400 headers:nil params:nil orLocalError:localError];
    
    id<MMSerialisationFactory> fact = [[MMSerialisationFactoryImpl alloc] init];
    
    @try {
        
        [MMErrorUtils throwMMExceptionForResponseOnError:dudRemoteResponse withReason:@"Remote error received" deserialisedWith:[fact getMMRestErrorSerialisation]];
        
        STFail(@"Should not have got here"); 
    } @catch (NSException *anyEx) {
        STAssertTrue([anyEx isKindOfClass:[MMException class]], @"Exception was not correct type");
        MMException *ex = (MMException *) anyEx;
        
        NSError *error = ex.containedError;
        STAssertTrue(error.code == NSURLErrorNotConnectedToInternet, @"Status code was not nil");
    }
}
@end
