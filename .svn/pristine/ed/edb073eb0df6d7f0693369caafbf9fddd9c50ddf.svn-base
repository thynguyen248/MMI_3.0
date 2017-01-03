//
//  MMBidDetail.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 3/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMObject.h"
#import "MMSerialisationDateHelper.h"

@interface MMBidDetail : NSObject<MMObject> {
    NSString *additionalInformation;
    NSString *contactPhoneNumber;
    NSString *deliveryVehicle;
    NSNumber *deliveryWindowDays;
    NSNumber *bidId;
    NSNumber *jobId;
    NSDictionary *links;
    NSDate *pickupDate;
    NSString *status;
    NSNumber *price;
    NSString *userName;
    NSNumber *userRating;
    NSNumber *userId;
    NSDate *createdDate;
}

@property (strong, nonatomic) NSString *additionalInformation;
@property (strong, nonatomic) NSString *contactPhoneNumber;
@property (strong, nonatomic) NSString *deliveryVehicle;
@property (strong, nonatomic) NSNumber *deliveryWindowDays;
@property (strong, nonatomic) NSNumber *bidId;
@property (strong, nonatomic) NSDictionary *links;

@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSNumber *userRating;

@property (strong, nonatomic) NSDate *createdDate;

//New
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSNumber *jobId;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSString *pickupTime;
@property (strong, nonatomic) NSDate *pickupDate;
@property (strong, nonatomic) NSString *deliveryTime;
@property (strong, nonatomic) NSDate *deliveryDate;
@property (strong, nonatomic) NSDate *expiryDate;
@property (strong, nonatomic) NSNumber *deliveryTypeID;


+ (MMBidDetail *) getBidDetailFromDictionary:(NSDictionary *) dict;

+ (NSDictionary *) getDictionaryFromBidDetail:(MMBidDetail *) bidDetail withDateHelper:(id<MMSerialisationDateHelper>) s11nDateHelper;

@end
