//
//  MMBidDetail.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 3/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMBidDetail.h"
#import "MMSerialisationUtils.h"

@implementation MMBidDetail

@synthesize additionalInformation;
@synthesize contactPhoneNumber;
@synthesize deliveryVehicle;
@synthesize deliveryWindowDays;
@synthesize bidId;
@synthesize jobId;
@synthesize links;
@synthesize pickupDate;
@synthesize price;
@synthesize status;
@synthesize userName;
@synthesize userId;
@synthesize userRating;
@synthesize createdDate;

@synthesize pickupTime;
@synthesize deliveryDate;
@synthesize deliveryTime;
@synthesize expiryDate;
@synthesize deliveryTypeID;

+ (MMBidDetail *) getBidDetailFromDictionary:(NSDictionary *) dict {
    if (dict == nil) @throw [[NSException alloc] initWithName:NSInvalidArgumentException reason:@"Input dictionary was nil" userInfo:nil];
    
    MMBidDetail *bidDetail = [[MMBidDetail alloc] init];
    
    bidDetail.price = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"amount"]];
    bidDetail.status = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"status"]];
    bidDetail.jobId = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"jobId"]];
    bidDetail.bidId = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"id"]];
    bidDetail.userRating = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"rating"]];
    DLog(@"****** Rating is: %@", bidDetail.userRating);
    
    // User
    NSDictionary* userDictionary = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"user"]];
    bidDetail.userName = [MMSerialisationUtils nilIfNSNull:[userDictionary objectForKey:@"displayName"]];
    bidDetail.userId = [MMSerialisationUtils nilIfNSNull:[userDictionary objectForKey:@"id"]];
    
    // Delivery Type
    NSDictionary* deliveryTypeDictionary = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"deliveryType"]];
    bidDetail.deliveryVehicle = [MMSerialisationUtils nilIfNSNull:[deliveryTypeDictionary objectForKey:@"type"]];
    
    // Dates
    bidDetail.pickupDate = [MMSerialisationUtils getDateFromRFC3339String:[MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"pickupDateStart"]]];
    bidDetail.pickupTime = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"pickupTime"]];
    
    bidDetail.deliveryDate = [MMSerialisationUtils getDateFromRFC3339String:[MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"deliveryDateEnd"]]];
    bidDetail.deliveryTime = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"deliveryTime"]];
    
    bidDetail.expiryDate = [MMSerialisationUtils getDateFromRFC3339String:[MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"expiryDate"]]];
    
    return bidDetail;
}

+(NSDictionary *) getDictionaryFromBidDetail:(MMBidDetail *) bidDetail withDateHelper:(id<MMSerialisationDateHelper>) s11nDateHelper {
    
    if (bidDetail == nil) @throw [[NSException alloc] initWithName:NSInvalidArgumentException reason:@"Input bid detail object was nil" userInfo:nil];
    if (s11nDateHelper == nil) @throw [[NSException alloc] initWithName:NSInvalidArgumentException reason:@"Date serialisation helper was nil" userInfo:nil];
    
    NSMutableDictionary *detailDictionary = [[NSMutableDictionary alloc] init];
    
    [detailDictionary setValue:[MMSerialisationUtils nsNullForNil:bidDetail.userId] forKey:@"user.id"];
    [detailDictionary setValue:[MMSerialisationUtils nsNullForNil:bidDetail.jobId] forKey:@"job.id"];
    [detailDictionary setValue:[MMSerialisationUtils nsNullForNil:bidDetail.price] forKey:@"amount"];
    
    NSDate* pickupDate = bidDetail.pickupDate;
    [detailDictionary setValue:(([pickupDate isKindOfClass:[NSNull class]]) ? pickupDate : [s11nDateHelper toStringFromDateTime:pickupDate]) forKey:@"pickupDatePicker_value"];
    [detailDictionary setValue:[MMSerialisationUtils nsNullForNil:bidDetail.pickupTime] forKey:@"pickupTime"];
    NSDate* deliveryDate = bidDetail.deliveryDate;
    [detailDictionary setValue:(([deliveryDate isKindOfClass:[NSNull class]]) ? deliveryDate : [s11nDateHelper toStringFromDateTime:deliveryDate]) forKey:@"deliveryDatePicker_value"];
    [detailDictionary setValue:[MMSerialisationUtils nsNullForNil:bidDetail.deliveryTime] forKey:@"deliveryTime"];
    NSDate* expiryDate = bidDetail.expiryDate;
    [detailDictionary setValue:(([expiryDate isKindOfClass:[NSNull class]]) ? expiryDate : [s11nDateHelper toStringFromDateTime:expiryDate]) forKey:@"expiryDatePicker_value"];
    [detailDictionary setValue:[MMSerialisationUtils nsNullForNil:bidDetail.deliveryTypeID] forKey:@"deliveryType.id"];
    
    return detailDictionary;
}


@end
