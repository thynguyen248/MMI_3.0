//
//  MeeMeepExceptionHandlingLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MeeMeepExceptionHandlingLogicUnitTest.h"
#import "MMRestException.h"
#import "MMRestDeserialisationException.h"

@implementation MeeMeepExceptionHandlingLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testHandleExceptionNarrowCatchOfVarious {
    
    BOOL narrowCatch = NO;
    BOOL broadCatch = NO;
    BOOL broadestCatch = NO;
    
    @try {
        MMRestDeserialisationException *s11nEx = [[MMRestDeserialisationException alloc] initWithReason:@"Just because" userInfo:nil nestedException:nil containedError:nil serialisedData:nil];
        
        @throw s11nEx;

    // these catch blocks must be in sequence from most specific to least specific
    } @catch (MMRestDeserialisationException *outerEx) {
        narrowCatch = YES;
    } @catch (MMRestException *outerEx) {
        broadCatch = YES;
    } @catch (NSException *ex) {
        broadestCatch = YES;
    }
    
    STAssertTrue(narrowCatch, @"Narrow catch should have occurred!");
    STAssertFalse(broadCatch, @"Broad catch should not have occurred!");
    STAssertFalse(broadestCatch, @"Broadest catch should not have occurred!");
}

- (void) testHandleBroadCatchOfVarious {
    BOOL narrowCatch = NO;
    BOOL broadCatch = NO;
    BOOL broadestCatch = NO;
    
    @try {
        MMRestException *ex = [[MMRestException alloc] initWithReason:@"No particular reason" userInfo:nil nestedException:nil containedError:nil];
        
        @throw ex;
        
    // these catch blocks must be in sequence from most specific to least specific
    } @catch (MMRestDeserialisationException *outerEx) {
        narrowCatch = YES;
    } @catch (MMRestException *outerEx) {
        broadCatch = YES;
    } @catch (NSException *ex) {
        broadestCatch = YES;
    }
    
    STAssertFalse(narrowCatch, @"Narrow catch should not have occurred!");
    STAssertTrue(broadCatch, @"Broad catch should have occurred!");
    STAssertFalse(broadestCatch, @"Broadest catch should not have occurred!");
}    

@end
