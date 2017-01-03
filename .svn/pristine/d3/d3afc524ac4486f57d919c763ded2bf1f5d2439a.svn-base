//
//  MMJobDetail.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "MMJobId.h"
#import "MMObject.h"
#import "MMJobAddress.h"
#import "MMJobItem.h"
#import "MMSerialisationDateHelper.h"
#import "MMJobStatus.h"
#import "MMLocation.h"

FOUNDATION_EXPORT NSString* const JOB_DATE_OPTION_GROUP_FLEXIBLE;
FOUNDATION_EXPORT NSString* const JOB_DATE_OPTION_GROUP_FIXED;

@interface MMJobDetail : NSObject <MMObject>

@property (strong, nonatomic) NSNumber *affiliateJobID;
@property (strong, nonatomic) NSDate* deliveryDate;
@property (strong, nonatomic) NSString* deliveryTime;
@property (strong, nonatomic) NSNumber *affiliateID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *jobCategory;
@property (strong, nonatomic) NSMutableArray* items;
@property (strong, nonatomic) NSDate* pickupDate;
@property (strong, nonatomic) NSString* pickupTime;
@property (strong, nonatomic) NSMutableArray* specialConsiderations;

@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSNumber *userId;


// Display specific
@property (strong, nonatomic) NSNumber *jobId;
@property (strong, nonatomic) MMLocation *fromLocation;
@property (strong, nonatomic) MMLocation *toLocation;
@property (strong, nonatomic) MMLocation *fromLocationDetailed;
@property (strong, nonatomic) MMLocation *toLocationDetailed;
@property (strong, nonatomic) NSNumber* distance;
@property (strong, nonatomic) MMJobStatus *jobStatus;
@property (strong, nonatomic) NSNumber *winningBidderId;
@property (strong, nonatomic) NSString *winningBidder;
@property (strong, nonatomic) NSNumber *acceptedBidId;
@property (strong, nonatomic) NSNumber *myBidId;

// Creation specific
@property (strong, nonatomic) NSString* fromSuburb;
@property (strong, nonatomic) NSString* toSuburb;
@property (strong, nonatomic) NSString* dateOptionSelect;
@property (strong, nonatomic) NSString* urgentCollectionSelector;
@property (strong, nonatomic) NSString* urgentDeliverySelector;
@property (strong, nonatomic) NSString* pickupDateOptionGroup;
@property (strong, nonatomic) NSString* deliveryDateOptionGroup;
@property (nonatomic) BOOL auctionWon;

-(void) addJobItem:(MMJobItem *) jobItem;

+ (MMJobDetail *) getJobDetailForDictionary:(NSDictionary *) dictionary withDateSerialiser:(id<MMSerialisationDateHelper>) dateSerialisation;

+ (NSDictionary *) dictionaryFromJobDetail:(MMJobDetail *) jobDetail withDateSerialiser:(id<MMSerialisationDateHelper>) s11nDateHelper;

@end
