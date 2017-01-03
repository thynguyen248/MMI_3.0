//
//  MeeMeepGetRemainingTimeStringLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 20/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MeeMeepGetRemainingTimeStringLogicUnitTest.h"
#import "GUICommon.h"

@implementation MeeMeepGetRemainingTimeStringLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testTime1 {
    NSInteger days = 5;
    NSInteger hours = 4;
    NSInteger minutes = 35;
    
    NSString *expected = @"5 days 4 hours 35 minutes";
    
    // 5 days 4 hours 35 mins?
    
    NSString *actual = [GUICommon timeStringForJobDays:days hours:hours minutes:minutes];
    
    STAssertTrue([expected isEqualToString:actual], @"Time string was not as expected");
}

- (void)testTime2 {
    NSInteger days = -1;
    NSInteger hours = 0;
    NSInteger minutes = 35;
    
    NSString *expected = @"35 minutes";
    
    NSString *actual = [GUICommon timeStringForJobDays:days hours:hours minutes:minutes];
    
    STAssertTrue([expected isEqualToString:actual], @"Time string was not as expected");
}

- (void)testTime3 {
    NSInteger days = -1;
    NSInteger hours = 4;
    NSInteger minutes = 35;
    
    NSString *expected = @"4 hours 35 minutes";
    
    NSString *actual = [GUICommon timeStringForJobDays:days hours:hours minutes:minutes];
    
    STAssertTrue([expected isEqualToString:actual], @"Time string was not as expected");
}

- (void)testTime4 {
    NSInteger days = -1;
    NSInteger hours = 1;
    NSInteger minutes = 1;
    
    NSString *expected = @"1 hour 1 minute";
    
    NSString *actual = [GUICommon timeStringForJobDays:days hours:hours minutes:minutes];
    
    STAssertTrue([expected isEqualToString:actual], @"Time string was not as expected");
}





@end
