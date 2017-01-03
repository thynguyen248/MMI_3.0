//
//  BidMessageGroupSortingUtils.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 24/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "BidMessageGroupSortingUtils.h"

@implementation BidMessageGroupSortingUtils

//Order bias//

//Winning bid at top (May be accepted or closed)
//Greatest price to lowest price
//Messages but no bids






//Get only the most recent bid for each user
+(NSArray*) filtersortBidMessageGroupsForMostRecentUserBids: (NSArray*)bidMessageGroups{
    
    NSMutableDictionary* userBmgs = [[NSMutableDictionary alloc] init];
    
    //Iterate through all entries in bidMessageGroups
    for (MMBidMessageGroupDetail* bmg in bidMessageGroups){
        MMBidMessageGroupDetail* currentUserBmg = [userBmgs objectForKey:bmg.username];
        if (bmg.username){
            if ((!currentUserBmg) || (!currentUserBmg.bidSummary) || (!currentUserBmg.bidSummary.createdDate)){
                //Entry for username has not been set or entry is invalid, so set it to bmg
                [userBmgs setValue:bmg forKey:bmg.username];
            } else {
                if ((bmg.bidSummary) && (bmg.bidSummary.createdDate)){
                    //Set bmg as current User bmg if it is newer
                    NSComparisonResult dateComparisonresult = [bmg.bidSummary.createdDate compare: currentUserBmg.bidSummary.createdDate];
                    if (dateComparisonresult==NSOrderedDescending) [userBmgs setValue:bmg forKey:bmg.username];
                }
            }
        }
    }   
    
    return [userBmgs allValues];
}




//Moves the winning bid to the top
+(NSArray*) sortBidMessageGroupsWinnerAtTop: (NSArray*)bidMessageGroups ForJob:(MMJobDetail*) job{
    if (job.winningBidderId){
        
        BOOL found = NO;
        NSInteger i = 0;
        MMBidMessageGroupDetail* bmg = nil;
        while ((found==NO) & (i<[bidMessageGroups count])){
            bmg = [bidMessageGroups objectAtIndex:i];
            if ((bmg.bidSummary) && (bmg.bidSummary.bidId))
                if ([bmg.bidSummary.bidId isEqualToNumber:job.acceptedBidId]) found = true;
            i++;
        }
        
        if (found==true){
            NSMutableArray* newBmgs = [[NSMutableArray alloc] initWithArray:bidMessageGroups];
            [newBmgs removeObject:bmg];
            [newBmgs insertObject:bmg atIndex:0];
            return newBmgs;
        } else return bidMessageGroups;
        
    } else return bidMessageGroups;
}




//Moves the winning bid to the top
+(NSArray*) sortBidMessageGroupsClosedAtBottom: (NSArray*)bidMessageGroups {
    
    NSMutableArray* a = [[NSMutableArray alloc] initWithArray:bidMessageGroups];
    
    NSMutableArray* closedBmg = [[NSMutableArray alloc] init]; //Bmg's whose bid summaries have status of closed
    
    for(MMBidMessageGroupDetail* bmg in bidMessageGroups){
        if ((bmg.bidSummary) && (bmg.bidSummary.bidId))
            if ([bmg.bidSummary.status isEqualToString:@"Closed"]) [closedBmg addObject:bmg];
    }
    
    [a removeObjectsInArray:closedBmg];
    [a addObjectsFromArray:closedBmg];    
    
    return a;
    
    
}






//Puts in order of highest bid to lowest bid
+(NSArray*) sortBidMessageGroupsGreatestPrice: (NSArray*)bidMessageGroups{
    
    NSMutableArray* priceSortedBmgs = [[NSMutableArray alloc] init];
    
    for (MMBidMessageGroupDetail* bmg in bidMessageGroups){
        
        NSNumber* price;
        
        if (!bmg.bidSummary) price = [NSNumber numberWithInt:0];
        else price = bmg.bidSummary.price;
        
        //Find the bmg in the list of pricesortedbmgs whose bidprice is less than price and add it
        BOOL found = NO;
        int i=0;
        while((i<[priceSortedBmgs count])&&(found==NO)){            
            
            MMBidMessageGroupDetail* tmpBmg = [priceSortedBmgs objectAtIndex:i];
            
            NSNumber* tmpPrice;
            if (!tmpBmg.bidSummary) tmpPrice = [NSNumber numberWithInt:0];
            else tmpPrice = [GUICommon formatForNumber:tmpBmg.bidSummary.price];
            if ([tmpPrice doubleValue]<[price doubleValue]){
                found = YES;
                i--;
            }
            
            i++;
        }
        [priceSortedBmgs insertObject:bmg atIndex:i];
        
    }
    return priceSortedBmgs;
    
}





//Places jobs that have no messages at the bottom
+(NSArray*) sortNoMessagesAtBottom: (NSArray*)bidMessageGroups sortByGreatestPrice: (BOOL) sortByPrice{
    
    NSMutableArray* bmgMain = [[NSMutableArray alloc] initWithArray:bidMessageGroups];
    
    NSMutableArray* bmgWithNoMessages = [[NSMutableArray alloc] init];
    
    //Find all bidmessagegroups that have no messages
    for (MMBidMessageGroupDetail* bmg in bidMessageGroups){
        if ((bmg.messageGroup==nil) || ([bmg.messageGroup.messages count]==0)){
            [bmgWithNoMessages addObject:bmg];
        }
    }
    
    //Remove them from the main array
    [bmgMain removeObjectsInArray:bmgWithNoMessages];
    
    //Sort them by price
    if (sortByPrice==true)
        bmgWithNoMessages = [[NSMutableArray alloc]initWithArray:[self sortBidMessageGroupsGreatestPrice:bmgWithNoMessages]];
    
    //Add them back into the main array
    [bmgMain addObjectsFromArray:bmgWithNoMessages];
    
    return bmgMain;
}



+(NSArray*) filterAndSortBidMessageGroups: (NSArray*)bidMessageGroups ForJob:(MMJobDetail*) job{
    
    bidMessageGroups = [self filtersortBidMessageGroupsForMostRecentUserBids:bidMessageGroups];
    
    bidMessageGroups = [self sortBidMessageGroupsGreatestPrice: bidMessageGroups];
    
    bidMessageGroups = [self sortBidMessageGroupsClosedAtBottom: bidMessageGroups];
    
    bidMessageGroups = [self sortBidMessageGroupsWinnerAtTop:bidMessageGroups ForJob: job];
    
    return bidMessageGroups;
}





@end
