//
//  MeeMeepSerialisationUtilsLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 17/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MeeMeepSerialisationUtilsLogicUnitTest.h"
#import "MMSerialisationUtils.h"

@implementation MeeMeepSerialisationUtilsLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testSerialisationUtilsNilForNSNull {
    
    id someNumber = [[NSNull alloc] init];
    id someValidNumber = [NSNumber numberWithInt:20];
    
    id target1 = [MMSerialisationUtils nilIfNSNull:someNumber];
    id target2 = [MMSerialisationUtils nilIfNSNull:someValidNumber];
    
    STAssertNil(target1, @"Should have been nil!");
    STAssertTrue([target2 isKindOfClass:[NSNumber class]], @"Should have been a number!");
}

- (void) testSerialisationUtilsNSNullForNil {
    id someNumber = nil;
    id someValidNumber = [NSNumber numberWithInt:20];
    
    id target1 = [MMSerialisationUtils nsNullForNil:someNumber];

    STAssertTrue([target1 isKindOfClass:[NSNull class]], @"Target was not ns null");
    
    id target2 = [MMSerialisationUtils nsNullForNil:someValidNumber];
    
    STAssertTrue([target2 isKindOfClass:[NSNumber class]], @"target was not a ns number");
}

@end
