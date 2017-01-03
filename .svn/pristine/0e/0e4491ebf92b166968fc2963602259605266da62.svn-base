//
//  BidMessageGroupDetail.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 17/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMBidSummary.h"
#import "MMMessageGroup.h"
#import "MMJobDetail.h"

#import "MMJobDetail.h"

@interface MMBidMessageGroupDetail : NSObject{
    NSNumber* userId;
    NSString* username;
    
    MMBidSummary* bidSummary;
    MMMessageGroup* messageGroup;
}

@property (nonatomic,strong) NSNumber* userId;
@property (nonatomic,strong) NSString* username; 

@property (nonatomic,strong) MMBidSummary* bidSummary;
@property (nonatomic,strong) MMMessageGroup* messageGroup;

/*
//Produces dictionary containing key-value pairs; {UserId | Username | BidSummary}
+(NSDictionary*) generateUserBidSummaryMappings: (NSArray*) bidSummaries;


//Produces dictionary containing key-value pairs; {UserId | Username | MessageGroup}
+(NSDictionary*) generateUserMessageGroupMappings: (NSArray*) messageGroups;


//Produces array containing arrays of values; { {UserId | Username | BidSummary | MessageGroup} }
+(NSArray*) generateJoinedMappingsForBidSummaries: (NSArray*) bidSummaries andMessageGroups: (NSArray*) messageGroups;


+(MMBidMessageGroupDetail*) generateBidMessageGroupDetailWithAttributes: (NSArray*) attributes;

+(NSArray*) generateBidMessageGroupDetailsUsingArray: (NSArray*) arrayOfAttributes;
 
 */

+(NSArray*) generateBidMessageGroupDetailsForBidSummaries: (NSArray*) bidSummaries andMessageGroups: (NSArray*) messageGroups job:(MMJobDetail*)thisJob;


@end
