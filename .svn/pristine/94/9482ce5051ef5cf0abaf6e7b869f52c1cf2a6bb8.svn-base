//
//  BidMessageGroupSortingUtils.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 24/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMJobDetail.h"
#import "MMBidMessageGroupDetail.h"
#import "GUICommon.h"

@interface BidMessageGroupSortingUtils : NSObject

+(NSArray*) filterAndSortBidMessageGroups: (NSArray*)bidMessageGroups ForJob:(MMJobDetail*) job;

+(NSArray*) filtersortBidMessageGroupsForMostRecentUserBids: (NSArray*)bidMessageGroups;
+(NSArray*) sortBidMessageGroupsWinnerAtTop: (NSArray*)bidMessageGroups ForJob:(MMJobDetail*) job;
+(NSArray*) sortBidMessageGroupsClosedAtBottom: (NSArray*)bidMessageGroups;
+(NSArray*) sortNoMessagesAtBottom: (NSArray*)bidMessageGroups sortByGreatestPrice: (BOOL) sortByPrice;
+(NSArray*) sortBidMessageGroupsGreatestPrice: (NSArray*)bidMessageGroups;

@end
