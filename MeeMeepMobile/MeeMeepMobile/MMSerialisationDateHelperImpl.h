//
//  MMSerialisationDateHelperImpl.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMSerialisationDateHelper.h"

@interface MMSerialisationDateHelperImpl : NSObject<MMSerialisationDateHelper> {

@private
    NSDateFormatter *toStringFormatter;
    NSDateFormatter *toDateFormatter;
}

@property (strong, nonatomic) NSDateFormatter *toStringFormatter;
@property (strong, nonatomic) NSDateFormatter *toDateFormatter;

- (id) initWithDateFormatterToString:(NSDateFormatter *) toStringFormatter toDate:(NSDateFormatter *)toDateFormatter;

@end
