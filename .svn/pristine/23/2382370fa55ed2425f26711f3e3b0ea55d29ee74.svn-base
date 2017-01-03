//
//  MMBidSummaryResponseSerialisation.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 1/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMBidSummaryResponseSerialisation.h"
#import "MMBidSummaryResponse.h"
#import "MMBidSummary.h"
#import "MMSerialisationUtils.h"
#import "MMRestDeserialisationException.h"
#import "MMRestNotImplementedException.h"
#import "MMSerialisationUtils.h"

@implementation MMBidSummaryResponseSerialisation

@synthesize dateS11nHelper;

- (id<MMObject>) deserialiseData:(NSData*) data {
    @try {
        NSDictionary* responseDict = [MMSerialisationUtils deserialiseData:data];
        
        NSArray *rawBidArray = [MMSerialisationUtils nilIfNSNull:[responseDict objectForKey:@"bidList"]];
        
        NSMutableArray *bidSummaryList = [[NSMutableArray alloc] init];
        
        for (NSDictionary *bidDict in rawBidArray) {
            // each dictionary is a bid summary - create one
            MMBidSummary *bidSummary = [self getBidSummaryForDictionary:bidDict];
            [bidSummaryList addObject:bidSummary];
        }
        
        MMBidSummaryResponse *response = [[MMBidSummaryResponse alloc] init];
        response.bids = bidSummaryList;
        
        return response;
    } @catch (NSException *anyEx) {
        MMRestDeserialisationException *dex = [[MMRestDeserialisationException alloc] initWithReason:@"Could not deserialise bid summary response data" userInfo:nil nestedException:anyEx containedError:nil serialisedData:nil];
        
        @throw dex;
    }
}

- (MMBidSummary *) getBidSummaryForDictionary:(NSDictionary *) dict {
    if (dict == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Input dictionary was nil" userInfo:nil];
    
    MMBidSummary *bidSummary = [[MMBidSummary alloc] init];
    
    bidSummary.bidId = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"id"]];
    bidSummary.jobId = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"jobId"]];
    
    bidSummary.price = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"amount"]];
    bidSummary.status = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"status"]];
    
    NSDictionary* deliveryTypeDict = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"deliveryType"]];
    bidSummary.deliveryType = [MMSerialisationUtils nilIfNSNull:[deliveryTypeDict objectForKey:@"type"]];
    
    // Dates
    //    "pickupDateEnd":"2013-03-06T04:50:10Z",
    //    "pickupDateStart":"2013-03-05T04:50:10Z",
    id date = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"PickupDate"]];
    bidSummary.pickupDate = (date) ? [self.dateS11nHelper toDateTimeFromString:date] : nil;
    
    //    "deliveryDateStart":"2013-03-08T04:50:10Z",
    //    "deliveryDateEnd":"2013-03-09T04:50:10Z",
    
    //    "dateCreated":"2013-03-05T04:50:10Z",
    id date2 = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"dateCreated"]];
    bidSummary.createdDate = (date2) ? [self.dateS11nHelper toDateTimeFromString:date2] : nil;
    
    //    "lastUpdated":"2013-03-05T04:50:10Z",
    //    "dateAccepted":null,
    //    "expiryDate":null,
    
    // Times
    //    "pickupTime":null,
    //    "deliveryTime":null,
    
    // User
    NSDictionary* userDictionary = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"user"]];
    bidSummary.userName = [MMSerialisationUtils nilIfNSNull:[userDictionary objectForKey:@"displayName"]];
    bidSummary.userId = [MMSerialisationUtils nilIfNSNull:[userDictionary objectForKey:@"id"]];
    bidSummary.userRating = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"rating"]];
    
    return bidSummary;
}

- (NSData*) serialise:(id <MMObject>) object {
    @throw [[MMRestNotImplementedException alloc] initWithReason:@"Bid summary serialisation not implemented!" userInfo:nil];
}

- (id) initWithDateS11nHelper:(id<MMSerialisationDateHelper>) d {
    self = [super init];
    if (self) {
        self.dateS11nHelper = d;
        
        return self;
    }
    
    return nil;
}

@end
