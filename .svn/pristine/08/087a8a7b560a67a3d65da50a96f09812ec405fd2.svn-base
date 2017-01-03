//
//  BidMessageGroupDetail.m
//  MeeMeepMobile
//
//  Created by John Rowland on 17/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "BidMessageGroupDetail.h"

@implementation BidMessageGroupDetail


+(NSDictionary*) generateUserBidSummaryMappings: (NSArray*) bidSummaries{
    NSMutableDictionary* mappings = [[NSMutableDictionary alloc] init];
    for (MMBidSummary* bidSummary in bidSummaries){
        NSString* username = bidSummary.userName;
        [mappings setValue:bidSummary forKey:username];
    }
    return mappings;
}



+(NSDictionary*) generateUserMessageGroupMappings: (NSArray*) messageGroups{
    NSMutableDictionary* mappings = [[NSMutableDictionary alloc] init];
    for (MMMessageGroup* messageGroup in messageGroups){
        NSString* username = messageGroup.username;
        [mappings setValue:messageGroup forKey:username];
    }
    return mappings;
}


+(NSArray*) generateJoinedMappingsForUserBids: (NSDictionary*) userBids andUserMessageGroups: (NSDictionary*) _userMessageGroups{    
    
    NSMutableArray* mappings = [[NSMutableArray alloc] init];
    
    NSMutableDictionary* userMessageGroups = [[NSMutableDictionary alloc] initWithDictionary:_userMessageGroups];
    
    //Get username from bid summary
    //Get bidSummary from bidSummaries list using username
    //Look for username match in message groups list
        //if match found then capture messageGroup
        //Remove messagegroup from message group list
    //Use data to construct an array of attributes, add to mappings
    for(NSString* username in userBids){
        MMBidSummary* bidSummary = [userBids objectForKey:username];
        MMMessageGroup* messageGroup = [userMessageGroups objectForKey:username]; //Might be nil
        if (messageGroup) [userMessageGroups removeObjectForKey:username]; //Remove it from other list
        NSArray* attributes = [[NSArray alloc] initWithObjects:username,bidSummary,messageGroup, nil]; 
        [mappings addObject:attributes];
    }
    
    //Iterate over entries that remain in user messagegroups - We know that it doesnt match anything in bid summary table or it would have been removed previously
    //Use data to construct an array of attributes, add to mappings
    for(NSString* username in userMessageGroups){
        MMBidSummary* bidSummary = nil; //Will definetly be nil
        MMMessageGroup* messageGroup = [userMessageGroups objectForKey:username];
        NSArray* attributes = [[NSArray alloc] initWithObjects:username,bidSummary,messageGroup, nil]; 
        [mappings addObject:attributes];
    }
    
    
    return mappings;
    
}



/*

+(NSDictionary*) generateUserBidSummary MessageGroupMappings: (NSArray*) messageGroups{
    NSMutableDictionary* mappings = [[NSMutableDictionary alloc] init];
    for (MMMessageGroup* messageGroup in messageGroups){
        NSString* username = messageGroup.username;
        [mappings setValue:messageGroup forKeyPath:username];
    }
    return mappings;
}
*/





//Removes bids with given user Id
+(void) removeBidSummaryWithUserId: (NSNumber*) userId fromUserBidSummaryMappings:(NSDictionary*) mappings {
}

@end
