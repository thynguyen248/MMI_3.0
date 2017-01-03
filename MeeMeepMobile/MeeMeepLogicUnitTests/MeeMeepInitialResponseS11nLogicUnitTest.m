//
//  MeeMeepInitialResponseS11nLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MeeMeepInitialResponseS11nLogicUnitTest.h"
#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"
#import "MMInitialResponseSerialisation.h"
#import "MMInitialResponse.h"
#import "MMRestDeserialisationException.h"
#import "MMRestNotImplementedException.h"

@implementation MeeMeepInitialResponseS11nLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testInitialResponseSerialisation1 {
    
    NSString *initialResponseString = @"{\"Links\":[{\"Href\":\"/bids/\",\"Rel\":\"meemeep-bid-summary-list\"},{\"Href\":\"/jobs/\",\"Rel\":\"meemeep-job-summary-list\"},{\"Href\":\"/users/\",\"Rel\":\"meemeep-user-summary-list\"},{\"Href\":\"/authentication/\",\"Rel\":\"meemeep-authentication\"}]}";
    
    NSData *data = [initialResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    
    MMInitialResponseSerialisation *serialisation = [factory getMMInitialResponseSerialisation];
    
    MMInitialResponse *response = [serialisation deserialiseData:data];
    
    NSDictionary *domains = response.domainLinks;
    
    STAssertNotNil(domains, @"domains from initial response was nil");
    
    NSString *summaryJobsListLink = [domains objectForKey:@"meemeep-job-summary-list"];
    
    STAssertNotNil(summaryJobsListLink, @"No value for summary jobs list");
    
    NSString *summaryUsersListLink = [domains objectForKey:@"meemeep-user-summary-list"];
    
    STAssertNotNil(summaryUsersListLink, @"No domain for summary users list");
    
    NSString *authLink = [domains objectForKey:@"meemeep-authentication"];
    
    STAssertNotNil(authLink, @"No domain for authentication");
}

- (void) testInitialResponseS11nInputDataIsNil {
    NSData *inputData = nil;
    
    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    
    MMInitialResponseSerialisation *serialisation = [factory getMMInitialResponseSerialisation];
    
    @try {
        [serialisation deserialiseData:inputData];
        
        STFail(@"Should never have reached this line!");
    } @catch (NSException *ex) {
        STAssertNotNil(ex, @"Exception was expected but was nil!");
        
        STAssertTrue([ex isKindOfClass:[MMRestDeserialisationException class]], @"Exception was not of expected type");
    }
}

- (void) testInitialResponseS11nInputDataBadJSON {
    NSString *initialResponseString = @"{\"Links\":[{\"Href\":\"/bids/\",\"Rel\":\"meemeep-bid-summary-list\"},{\"Href\":\"/jobs/\",\"Rel\":\"meemeep-job-summary-list\"},{\"Href\":\"/users/\",\"Rel\":\"meemeep-user-summary-list\"},{\"Href\":\"/authentication/\",\"Rel\":\"meemeep-authentication\"]}"; // contains missing trailing '}'
    
    NSData *data = [initialResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    
    MMInitialResponseSerialisation *serialisation = [factory getMMInitialResponseSerialisation];
    
    @try {
        [serialisation deserialiseData:data];
        STFail(@"Should never have reached this point!");
    } @catch (NSException *ex) {
        STAssertNotNil(ex, @"Exception was expected but was nil!");
        
        STAssertTrue([ex isKindOfClass:[MMRestDeserialisationException class]], @"Exception was not of expected type");
    }
}

- (void) testInitialResponseS11nInputNilData {
    NSString *initialResponseString = nil;
    
    NSData *data = [initialResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    
    MMInitialResponseSerialisation *serialisation = [factory getMMInitialResponseSerialisation];
    
    @try {
        [serialisation deserialiseData:data];
        STFail(@"Should never have reached this point!");
    } @catch (NSException *ex) {
        STAssertNotNil(ex, @"Exception was expected but was nil!");
        
        STAssertTrue([ex isKindOfClass:[MMRestDeserialisationException class]], @"Exception was not of expected type");
    }
}

- (void) testSerialiseNotImplemented {
    @try {
        id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
        
        MMInitialResponseSerialisation *serialisation = [factory getMMInitialResponseSerialisation];
        
        [serialisation serialise:nil];
        
    } @catch (NSException *ex) {
        STAssertNotNil(ex, @"Caught exception was nil?");
        
        STAssertTrue([ex isKindOfClass:[MMRestNotImplementedException class]], @"Exception was not of the expected kind!");
    }
}

@end
