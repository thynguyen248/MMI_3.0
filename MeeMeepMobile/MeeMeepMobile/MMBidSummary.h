//
//  MMBidSummary.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 1/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMObject.h"

@interface MMBidSummary : NSObject<MMObject>

@property (strong, nonatomic) NSNumber *bidId;
@property (strong, nonatomic) NSDate *pickupDate;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSNumber *userRating;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSNumber *jobId;
@property (strong, nonatomic) NSDate *createdDate;

@property (strong, nonatomic) NSString *deliveryType;


@end
