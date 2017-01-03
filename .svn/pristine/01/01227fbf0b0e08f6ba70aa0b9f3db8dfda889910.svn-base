//
//  MeeMeepIsNumberLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 16/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "MeeMeepIsNumberLogicUnitTest.h"

@implementation MeeMeepIsNumberLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)tIsNumberTrue
{
    NSString* aNumber = @"55";
    BOOL isNumber;
    isNumber = [GUICommon isNumber:aNumber];
    STAssertTrue(isNumber, aNumber, @" is not a number");
}


- (void)tIsNumberFalse
{
    NSString* aNumber = @"dfasdf";
    BOOL isNumber;
    isNumber = [GUICommon isNumber:aNumber];
    STAssertTrue(isNumber, aNumber, @" is a number");
}


@end
