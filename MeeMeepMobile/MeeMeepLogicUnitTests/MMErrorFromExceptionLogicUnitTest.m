//
//  MMErrorFromExceptionLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMErrorFromExceptionLogicUnitTest.h"
#import "MMException.h"
#import "MMErrorUtils.h"

@implementation MMErrorFromExceptionLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testGenerateErrorFromException {

    NSError *setError = nil;
    
    @try {
        @throw [NSException exceptionWithName:NSGenericException reason:@"This is the reason" userInfo:nil];
    } @catch (NSException *ex) {
        setError = [MMErrorUtils errorForException:ex withDomain:nil andCode:nil];
    }

    STAssertNotNil(setError, @"Error was not set");
    STAssertNotNil([setError localizedDescription], @"Localised description not set!");
    STAssertNotNil([setError localizedFailureReason], @"Reason not set");
    
    DLog(@"Error, reason: [%@], description: [%@]", [setError localizedFailureReason], [setError localizedDescription]);
    
}

@end
