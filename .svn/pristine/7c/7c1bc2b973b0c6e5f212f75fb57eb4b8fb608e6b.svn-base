//
//  JobDateGenerator.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 12/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "JobDateGenerator.h"

@implementation JobDateGenerator

+ (NSDate *) date:(NSDate *) baseDate withTimeBasedOnDate:(NSDate *) date {
    if (baseDate == nil) return nil;
    if (date == nil) return nil;
    
    NSString *currentCalIdentifier = [[NSCalendar currentCalendar] calendarIdentifier];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:currentCalIdentifier];
    
    NSDateComponents *componentsFromBaseDate = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:baseDate];
    
    NSDateComponents *componentsFromTimeDate = [calendar components:(NSHourCalendarUnit | NSSecondCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
    
    //DLog(@"time = [h=%d, m=%d, s=%d, tz=%@]", [componentsFromTimeDate hour], [componentsFromTimeDate minute], [componentsFromTimeDate second], [[componentsFromTimeDate timeZone] description]);
    
    [componentsFromBaseDate setHour:[componentsFromTimeDate hour]];
    [componentsFromBaseDate setMinute:[componentsFromTimeDate minute]];
    [componentsFromBaseDate setSecond:[componentsFromTimeDate second]];
    
    
    NSDate *finalDate = [calendar dateFromComponents:componentsFromBaseDate];
    
    return finalDate;
}


@end
