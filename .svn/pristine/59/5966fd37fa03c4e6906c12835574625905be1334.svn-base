//
//  BidMessageGroupDetail.h
//  MeeMeepMobile
//
//  Created by John Rowland on 17/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMBidSummary.h"
#import "MMMessageGroup.h"

@interface BidMessageGroupDetail : NSObject{
    NSNumber* userId;
    NSString* username;
    
    MMBidSummary* bidSummary;
    MMMessageGroup* messageGroup;
}


//Produces dictionary containing key-value pairs; {UserId | Username | BidSummary}
+(NSDictionary*) generateUserBidSummaryMappings: (NSArray*) bidSummaries;


//Produces dictionary containing key-value pairs; {UserId | Username | MessageGroup}
+(NSDictionary*) generateUserMessageGroupMappings: (NSArray*) messageGroups;


//Produces array containing arrays of values; { {UserId | Username | BidSummary | MessageGroup} }
+(NSArray*) generateJoinedMappingsForUserBids: (NSArray*) userBids andUserMessageGroups: (NSArray*) userMessageGroups;


//Removes bids with given user Id
+(void) removeBidSummaryWithUserId: (NSNumber*) userId fromUserBidSummaryMappings:(NSDictionary*) mappings;


@end
