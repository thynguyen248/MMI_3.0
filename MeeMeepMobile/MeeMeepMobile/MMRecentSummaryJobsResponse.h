//
//  MMRecentlyPostedSummaryJobsResponse.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMObject.h"

@interface MMRecentSummaryJobsResponse : NSObject <MMObject> {
    NSArray *jobs;
    NSNumber* totalAvailable;
}

@property (strong, nonatomic) NSArray *jobs;
@property (strong, nonatomic) NSNumber* totalAvailable;

@end
