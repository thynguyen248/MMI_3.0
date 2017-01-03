//
//  MMJobSummary.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMObject.h"
#import "MMJobId.h"
#import "MMJobStatus.h"
#import "MMLocation.h"

@interface MMJobSummary : NSObject <MMObject>

@property (strong, nonatomic) MMJobStatus *jobStatus;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *jobId;

@property (strong, nonatomic) MMLocation *fromLocation;
@property (strong, nonatomic) MMLocation *toLocation;

@property (strong, nonatomic) NSDate* deliveryDate;
@property (strong, nonatomic) NSDate* pickupDate;

@property (strong, nonatomic) NSDate* expiryDate;

+ (MMJobSummary*) getJobSummaryFromDictionary:(NSDictionary *) dictionary;

@end
