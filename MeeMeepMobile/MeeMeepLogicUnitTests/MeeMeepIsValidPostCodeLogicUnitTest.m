//
//  MeeMeepIsValidPostCodeLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 16/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "MeeMeepIsValidPostCodeLogicUnitTest.h"

@implementation MeeMeepIsValidPostCodeLogicUnitTest



/*
 NSW     1000-2599, 2619-2898, 2921-2999     (1*** 2***)
 ACT     0200-0299, 2600-2618, 2900-2920     (0*** & 2***)
 VIC     3000-3999, 8000-8999                (3*** & 8***)
 QLD     4000-4999, 9000-9999                (4*** & 9***)
 SA      5000-5799, 5800-5999                (5***)
 WA      6000-6797, 6800-6999                (6***)
 TAS     7000-7799, 7800-7999                (7***)
 NT      0800-0899, 0900-0999                (0***)
 */


- (void)IsValidPostCodeLogicUnitTestAbbreviationsTrue
{
    NSString* stateName;
    NSString* postCode;
    BOOL isState;
    
    stateName = @"NSW";
    postCode = @"2000";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertTrue(isState, stateName, @" is not a state");
    
    stateName = @"ACT";
    postCode = @"0250";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertTrue(isState, stateName, @" is not a state");

    stateName = @"VIC";
    postCode = @"3764";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertTrue(isState, stateName, @" is not a state");

    stateName = @"QLD";
    postCode = @"4500";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertTrue(isState, stateName, @" is not a state");
    
    stateName = @"SA";
    postCode = @"5700";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertTrue(isState, stateName, @" is not a state");
    
    stateName = @"WA";
    postCode = @"6700";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertTrue(isState, stateName, @" is not a state");

    stateName = @"TAS";
    postCode = @"7500";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertTrue(isState, stateName, @" is not a state");

    stateName = @"NT";
    postCode = @"0855";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertTrue(isState, stateName, @" is not a state");
}


- (void)IsValidPostCodeLogicUnitTestTrue
{
    NSString* stateName;
    NSString* postCode;
    BOOL isState;
    
    stateName = @"New South Whales";
    postCode = @"2000";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertTrue(isState, stateName, @" is not a state");
    
    stateName = @"Australian Capital Territory";
    postCode = @"0250";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertTrue(isState, stateName, @" is not a state");
    
    stateName = @"Victoria";
    postCode = @"3764";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertTrue(isState, stateName, @" is not a state");
    
    stateName = @"Queensland";
    postCode = @"4500";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertTrue(isState, stateName, @" is not a state");
    
    stateName = @"South Australia";
    postCode = @"5700";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertTrue(isState, stateName, @" is not a state");
    
    stateName = @"Western Australia";
    postCode = @"6700";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertTrue(isState, stateName, @" is not a state");
    
    stateName = @"Tasmania";
    postCode = @"7500";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertTrue(isState, stateName, @" is not a state");
    
    stateName = @"Northern Territory";
    postCode = @"0855";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertTrue(isState, stateName, @" is not a state");
}

- (void)IsValidPostCodeLogicUnitTestInvalidState
{
    NSString* stateName;
    NSString* postCode;
    BOOL isState;
    
    stateName = @"New South Walls";
    postCode = @"2000";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertFalse(isState, stateName, @" is not a state");
}

- (void)IsValidPostCodeLogicUnitTestInvalidPostCode
{
    NSString* stateName;
    NSString* postCode;
    BOOL isState;
    
    stateName = @"VIC";
    postCode = @"2000";
    isState=[GUICommon isValidPostCode:postCode forState:stateName];
    STAssertFalse(isState, stateName, @" is not a state");
}


@end
