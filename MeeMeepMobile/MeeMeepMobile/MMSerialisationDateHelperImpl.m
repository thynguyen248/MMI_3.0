//
//  MMSerialisationDateHelperImpl.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMSerialisationDateHelperImpl.h"

@implementation MMSerialisationDateHelperImpl 

@synthesize toStringFormatter;
@synthesize toDateFormatter;

- (NSDate *) toDateTimeFromString:(NSString*) dateString {
    if (self.toDateFormatter) {
        //DLog(@"Date string for conversion to date [%@], format string [%@]", dateString, toDateFormatter.dateFormat);
        return [toDateFormatter dateFromString:dateString];
    }
    
    return nil;
}

- (NSString *) toStringFromDateTime:(NSDate *) date {
    if (self.toStringFormatter) {
        //DLog(@"Date string for conversion to string [%@]", toDateFormatter.dateFormat);
        NSString *dateString = [toStringFormatter stringForObjectValue:date];
        
        return dateString;
    }
    
    return nil;
}

- (id) initWithDateFormatterToString:(NSDateFormatter *) tsf toDate:(NSDateFormatter *) tdf {
    self = [super init];
    if (self) {
        self.toStringFormatter = tsf;
        self.toDateFormatter = tdf;
        
        return self;
    }
    
    return nil;
}


@end
