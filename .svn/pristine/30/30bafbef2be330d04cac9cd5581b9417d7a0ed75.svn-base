//
//  MMJobDetail.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMJobDetail.h"
#import "MMSerialisationUtils.h"
#import "GUICommon.h"

@implementation MMJobDetail

@synthesize jobId;
@synthesize jobStatus;
@synthesize title;
@synthesize user;
@synthesize fromLocation;
@synthesize toLocation;
@synthesize fromLocationDetailed;
@synthesize toLocationDetailed;
@synthesize affiliateID;
@synthesize affiliateJobID;
@synthesize items;
@synthesize dateOptionSelect;
@synthesize deliveryDate, pickupDate;

@synthesize deliveryDateOptionGroup, pickupDateOptionGroup;
@synthesize urgentDeliverySelector, urgentCollectionSelector;
@synthesize pickupTime, deliveryTime;
@synthesize specialConsiderations;
@synthesize auctionWon;

NSString* const JOB_DATE_OPTION_GROUP_FLEXIBLE = @"flexible";
NSString* const JOB_DATE_OPTION_GROUP_FIXED = @"fixed";

-(id) init {
    if(self = [super init]) {
        self.items = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void) addJobItem:(MMJobItem *) jobItem {
    [self.items addObject:jobItem];
}

-(void) setPickupDate:(NSDate *)initPickupDate {
    pickupDate = [GUICommon stripMinutesAndSecondsFromDateTime:initPickupDate];
}

-(void) setDeliveryDate:(NSDate *)initDeliveryDate {
    deliveryDate = [GUICommon stripMinutesAndSecondsFromDateTime:initDeliveryDate];
}

+ (MMJobDetail *) getJobDetailForDictionary:(NSDictionary *) dictionary withDateSerialiser:(id<MMSerialisationDateHelper>) dateSerialisation {
    if (dictionary == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Input dictionary was nil" userInfo:nil];
    
    MMJobDetail *jobDetail = [[MMJobDetail alloc] init];
    
    @try {
        jobDetail.jobId = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"id"]];
        jobDetail.affiliateJobID = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"affiliateJobId"]];
        jobDetail.deliveryTime = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"deliveryTime"]];
        jobDetail.distance = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"distance"]];
        jobDetail.pickupTime = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"pickupTime"]];
        jobDetail.title = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"title"]];
        jobDetail.distance = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"distance"]];
        
        // ** Complex types
        // Locations
        jobDetail.fromLocation = [MMLocation getLocationForDictionary:[MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"fromLocation"]]];
        jobDetail.toLocation = [MMLocation getLocationForDictionary:[MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"toLocation"]]];
        
        jobDetail.fromLocationDetailed = [MMLocation getLocationForDictionary:[MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"pickupAddress"]]];
        jobDetail.toLocationDetailed = [MMLocation getLocationForDictionary:[MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"deliveryAddress"]]];
        
        // Job status
        jobDetail.jobStatus = [MMJobStatus statusFromString:[MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"status"]]];
        
        // Dates
        jobDetail.deliveryDate = [MMSerialisationUtils getDateFromRFC3339String:[MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"deliveryDateEnd"]]];
        jobDetail.pickupDate = [MMSerialisationUtils getDateFromRFC3339String:[MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"pickupDateStart"]]];
        
        // Affiliate
        NSDictionary* affiliateDictionary = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"affiliate"]];
        if(affiliateDictionary != nil) {
            jobDetail.affiliateID = [MMSerialisationUtils nilIfNSNull:[affiliateDictionary objectForKey:@"id"]];
        }
        
        // Items
        NSArray* items = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"items"]];
        jobDetail.items = [[NSMutableArray alloc] initWithCapacity:[items count]];
        
        for(NSDictionary* itemDictionary in items)
        {
            [jobDetail.items addObject:[MMJobItem getJobItemForDictionary:itemDictionary]];
        }
        
        // Special Considerations
        NSArray* specialConsiderations = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"specialConsiderations"]];
        jobDetail.specialConsiderations = [[NSMutableArray alloc] initWithCapacity:[specialConsiderations count]];
        
        for(NSDictionary* scDictionary in specialConsiderations)
        {
            NSString* sc = [MMSerialisationUtils nilIfNSNull:[scDictionary objectForKey:@"description"]];
            if(sc != nil)
            {
                [jobDetail.specialConsiderations addObject:sc];
            }
        }
        
        // Accepted Bid
        NSDictionary* acceptedBidDict = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"acceptedBid"]];
        if(acceptedBidDict != nil)
        {
            jobDetail.acceptedBidId = [MMSerialisationUtils nilIfNSNull:[acceptedBidDict objectForKey:@"id"]];

            // Winning Bidder
            NSDictionary* winningBidderDict = [MMSerialisationUtils nilIfNSNull:[acceptedBidDict objectForKey:@"user"]];
            if(winningBidderDict != nil)
            {
                jobDetail.winningBidder = [MMSerialisationUtils nilIfNSNull:[winningBidderDict objectForKey:@"displayName"]];
                jobDetail.winningBidderId = [MMSerialisationUtils nilIfNSNull:[winningBidderDict objectForKey:@"id"]];
            }
        }
        
        jobDetail.myBidId = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"myBidId"]];
        
        // User
        NSDictionary* userDict = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"user"]];
        if(userDict != nil)
        {
            jobDetail.user = [MMSerialisationUtils nilIfNSNull:[userDict objectForKey:@"displayName"]];
            jobDetail.userId = [MMSerialisationUtils nilIfNSNull:[userDict objectForKey:@"id"]];
        }
        
    }
    @catch (NSException *exception) {
        DLog(@"Could not convert dictionary to JobDetail, %@", exception);
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Could not convert dictionary to Job Detail" userInfo:nil];
    }
    
    DLog(@"Read Job Detail:%@", jobDetail);
    
    return jobDetail;
}

+ (NSDictionary *) dictionaryFromJobDetail:(MMJobDetail *) jobDetail withDateSerialiser:(id<MMSerialisationDateHelper>) s11nDateHelper {
    if (jobDetail == nil) 
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Input job detail to serialise was nil" userInfo:nil];
    if (s11nDateHelper == nil) 
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Date serialisation helper not provided" userInfo:nil];;
    
    NSDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:jobDetail.fromSuburb] forKey:@"fromLocation"];
    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:jobDetail.toSuburb] forKey:@"toLocation"];
    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:jobDetail.affiliateID] forKey:@"affiliate"];
    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:jobDetail.affiliateJobID]
                  forKey:@"affiliateJobID"];
    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:jobDetail.title] forKey:@"title"];

    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:[jobDetail.jobCategory stringValue]] forKey:@"categorySelect"];

    NSMutableDictionary* itemsDictionary = [[NSMutableDictionary alloc] init];
    NSInteger itemNumber = 0;
    for(MMJobItem* item in jobDetail.items) {
        [itemsDictionary setValue:[MMSerialisationUtils nsNullForNil:[MMJobItem dictionaryFromJobItem:item]]
                           forKey:[[NSNumber numberWithInt:itemNumber] stringValue]];
        
        ++itemNumber;
    }
    
    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:itemsDictionary] forKey:@"item"];
    
    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:jobDetail.dateOptionSelect]
                  forKey:@"dateOptionSelect"];
    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:jobDetail.urgentCollectionSelector]
                  forKey:@"urgentCollectionSelector"];
    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:jobDetail.urgentDeliverySelector]
                  forKey:@"urgentDeliverySelector"];
    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:jobDetail.pickupDateOptionGroup]
                  forKey:@"pickupDateOptionGroup"];
    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:jobDetail.deliveryDateOptionGroup]
                  forKey:@"deliveryDateOptionGroup"];
    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:
                          [s11nDateHelper toStringFromDateTime:jobDetail.pickupDate]]
                  forKey:@"pickupDatePicker_value"];
    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:
                          [s11nDateHelper toStringFromDateTime:jobDetail.deliveryDate]]
                  forKey:@"deliveryDatePicker_value"];
    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:jobDetail.pickupTime]
                  forKey:@"pickupTimeSelect"];
    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:jobDetail.deliveryTime]
                  forKey:@"deliveryTimeSelect"];
    [dictionary setValue:[NSNumber numberWithBool:jobDetail.auctionWon]
                  forKey:@"auctionWonCheckBox"];
    
    [dictionary setValue:[MMSerialisationUtils nilIfNSNull:jobDetail.specialConsiderations] forKey:@"specialConsiderationSelect"];

    return dictionary;
}


@end
