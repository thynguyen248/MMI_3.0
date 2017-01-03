//
//  MeeMeepDateTimeSerializationHelperUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MeeMeepDateTimeSerializationHelperUnitTest.h"

#import "MMSerialisationDateHelper.h"
#import "MMSerialisationDateHelperImpl.h"

@implementation MeeMeepDateTimeSerializationHelperUnitTest

// All code under test must be linked into the Unit Test bundle
- (void) testConvertDateToString {
    
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_AU"];
    NSTimeZone *tz = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setLocale:locale];
    [formatter setTimeZone:tz];
    
    id<MMSerialisationDateHelper> s11nDateHelper 
        = [[MMSerialisationDateHelperImpl alloc] initWithDateFormatterToString:formatter toDate:nil];   
    // should be set to a specific date 1970-01-01
    // should get a date formatted in the form of YY-MM-dd
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:0];
    
    NSString *dateString = [s11nDateHelper toStringFromDateTime:date];
    DLog(@"Date string %@", dateString);
    
    STAssertTrue([dateString isEqualToString:@"1970-01-01"], @"Date strings do not match");
    
}

- (void) testConvertStringToDate {
    NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:@"en_AU"];
    NSString *dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSSZZZ'";
    NSTimeZone *timezone = [NSTimeZone systemTimeZone];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    [formatter setTimeZone:timezone];
    [formatter setLocale:locale];
    
    id<MMSerialisationDateHelper> s11nDateHelper 
    = [[MMSerialisationDateHelperImpl alloc] initWithDateFormatterToString:nil toDate:formatter];
    
    NSString *sourceDate = @"2012-01-01T13:45:23.123+1100";
    NSDate *date = [s11nDateHelper toDateTimeFromString:sourceDate];
    
    NSString *extractedDate = [formatter stringFromDate:date];
    
    STAssertTrue([sourceDate isEqualToString:extractedDate], @"Dates were not equal");
}

@end
