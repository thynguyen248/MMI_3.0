//
//  MMJobGeneratorLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMJobGeneratorLogicUnitTest.h"
#import "JobDateGenerator.h"

@implementation MMJobGeneratorLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testGenerateDateWithTime1 {
    
    NSDateFormatter *inFormatter = [[NSDateFormatter alloc] init];
                                    
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSLocale *locale = [NSLocale currentLocale];
    
    [inFormatter setTimeZone:timeZone];
    [inFormatter setLocale:locale];
    
    NSString *dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS";
    [inFormatter setDateFormat:dateFormat];
    
    NSString *inputDate = @"1970-01-01T12:00:00.000";
    NSString *time = @"2012-01-05T03:15:25.000";
    
    NSDate *baseDate = [inFormatter dateFromString:inputDate];
    NSDate *timeDate = [inFormatter dateFromString:time];
    // assert that the final date has a time of 3pm and a date of the original
    
    NSDate *finalDate = [JobDateGenerator date:baseDate withTimeBasedOnDate:timeDate];
    
    NSString *expectedDate = @"1970-01-01T03:15:25.000";
    
    NSString *resultDate = [inFormatter stringFromDate:finalDate];
    
    DLog(@"Expected: [%@], Final: [%@]", expectedDate, resultDate);
    
    STAssertTrue([expectedDate isEqualToString:resultDate], @"Expected date was not equal to final date");
}

- (void)testGenerateDateWithTime2 {
    
    NSDateFormatter *inFormatter = [[NSDateFormatter alloc] init];
    
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSLocale *locale = [NSLocale currentLocale];
    
    [inFormatter setTimeZone:timeZone];
    [inFormatter setLocale:locale];
    
    NSString *dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS";
    [inFormatter setDateFormat:dateFormat];
    
    NSString *inputDate = @"2013-03-29T12:00:00.000";
    NSString *time = @"2012-01-05T14:17:59.000";
    
    NSDate *baseDate = [inFormatter dateFromString:inputDate];
    NSDate *timeDate = [inFormatter dateFromString:time];
    // assert that the final date has a time of 3pm and a date of the original
    
    NSDate *finalDate = [JobDateGenerator date:baseDate withTimeBasedOnDate:timeDate];
    
    NSString *expectedDate = @"2013-03-29T14:17:59.000";
    
    NSString *resultDate = [inFormatter stringFromDate:finalDate];
    
    DLog(@"Expected: [%@], Final: [%@]", expectedDate, resultDate);
    
    STAssertTrue([expectedDate isEqualToString:resultDate], @"Expected date was not equal to final date");
}

@end
