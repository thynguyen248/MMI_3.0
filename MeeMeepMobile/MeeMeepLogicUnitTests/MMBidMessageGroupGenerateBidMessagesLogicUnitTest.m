//
//  MMBidMessageGroupGenerateBidMessagesLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 21/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "MMBidMessageGroupGenerateBidMessagesLogicUnitTest.h"
#import "MMBidMessageGroupDetail.h"
#import "BidMessageGroupSortingUtils.h"

@implementation MMBidMessageGroupGenerateBidMessagesLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void) testGenerateBidMessageGroupDetailsForBidSummaries_Test1
{
    /*
        0   |   BidSummary1  |   MessageGroup1
        1   |   BidSummary2  |   MessageGroup2
    */
    
    
    //Resources for userId: 0
    //
    //BidSummaries
    MMBidSummary* bidSummary1 = [[MMBidSummary alloc] init];
    [bidSummary1 setUserId:[NSNumber numberWithInt:0]];
    //MessageGroups
    MMMessageGroup* messageGroup1 = [[MMMessageGroup alloc] init];
    MMMessageDetail* messageGroup1Message1 = [[MMMessageDetail alloc] init];
    [messageGroup1 setUserId:[NSNumber numberWithInt:0]];
    messageGroup1.messages = [[NSArray alloc] initWithObjects: messageGroup1Message1, nil];

    //Resources for userId: 1
    //
    //BidSummaries
    MMBidSummary* bidSummary2 = [[MMBidSummary alloc] init];
    [bidSummary2 setUserId:[NSNumber numberWithInt:1]];
    //MessageGroups
    MMMessageGroup* messageGroup2 = [[MMMessageGroup alloc] init];
    MMMessageDetail* messageGroup2Message1 = [[MMMessageDetail alloc] init];
    [messageGroup2 setUserId:[NSNumber numberWithInt:1]];
    messageGroup2.messages = [[NSArray alloc] initWithObjects: messageGroup2Message1, nil];
    
    
    NSArray* bidSummaries = [[NSArray alloc] initWithObjects: bidSummary1, bidSummary2, nil];
    NSArray* messageGroups = [[NSArray alloc] initWithObjects:messageGroup1, messageGroup2, nil];
    MMJobDetail* job = [[MMJobDetail alloc] init];
    job.title = @"jobTitle";
    
    NSArray* results = [MMBidMessageGroupDetail generateBidMessageGroupDetailsForBidSummaries:bidSummaries andMessageGroups:messageGroups job:job];
    
    
    STAssertTrue([results count] == 2, @"Incorrect number of bidMessageGroups");
    
    
    MMBidMessageGroupDetail* bmg;
    
    bmg = [results objectAtIndex:0];
    
    STAssertTrue(bmg.bidSummary == bidSummary1, @"BidMessageGroup is not linked to expected bid summary");
    STAssertTrue(bmg.messageGroup == messageGroup1, @"BidMessageGroup is not linked to expected message group");
    
    bmg = [results objectAtIndex:1];
    
    STAssertTrue(bmg.bidSummary == bidSummary2, @"BidMessageGroup is not linked to expected bid summary");
    STAssertTrue(bmg.messageGroup == messageGroup2, @"BidMessageGroup is not linked to expected message group");
    
}



// All code under test must be linked into the Unit Test bundle
- (void) testGenerateBidMessageGroupDetailsForBidSummaries_Test2
{
    /*
        0   |   BidSummary2  |   NULL
        1   |   NULL         |   MessageGroup1
    */
    
    
    //Resources for userId: 0
    //
    //BidSummaries
    MMBidSummary* bidSummary2 = [[MMBidSummary alloc] init];
    [bidSummary2 setUserId:[NSNumber numberWithInt:1]];
    
    
    //Resources for userId: 1
    //
    //MessageGroups
    MMMessageGroup* messageGroup1 = [[MMMessageGroup alloc] init];
    MMMessageDetail* messageGroup1Message1 = [[MMMessageDetail alloc] init];
    [messageGroup1 setUserId:[NSNumber numberWithInt:0]];
    messageGroup1.messages = [[NSArray alloc] initWithObjects: messageGroup1Message1, nil];
    
    
    NSArray* bidSummaries = [[NSArray alloc] initWithObjects: bidSummary2, nil];
    NSArray* messageGroups = [[NSArray alloc] initWithObjects:messageGroup1, nil];
    MMJobDetail* job = [[MMJobDetail alloc] init];
    job.title = @"jobTitle";
    
    NSArray* results = [MMBidMessageGroupDetail generateBidMessageGroupDetailsForBidSummaries:bidSummaries andMessageGroups:messageGroups job:job];

    
    
    STAssertTrue([results count] == 2, @"Incorrect number of bidMessageGroups");
    
    
    MMBidMessageGroupDetail* bmg;
    
    
    bmg = [results objectAtIndex:0];
    STAssertTrue(bmg.bidSummary == bidSummary2, @"BidMessageGroup is not linked to expected bid summary");
    STAssertTrue(bmg.messageGroup.messages.count == 0, @"BidMessageGroup is linked to a message group with no messages");
    
    bmg = [results objectAtIndex:1];
    STAssertTrue(bmg.bidSummary == nil, @"BidMessageGroup is not linked to expected bid summary");
    STAssertTrue(bmg.messageGroup == messageGroup1, @"BidMessageGroup is not linked to expected message group");
    
}




-(void) testSortGreatestPrice_Test1{

    //BidMessageGroup1
    MMBidMessageGroupDetail* bmg1 = [[MMBidMessageGroupDetail alloc] init];
    MMBidSummary* bidSummary1 = [[MMBidSummary alloc] init];
    [bidSummary1 setPrice:[NSNumber numberWithInt:35]];
    [bmg1 setBidSummary:bidSummary1];
    
    //BidMessageGroup2
    MMBidMessageGroupDetail* bmg2 = [[MMBidMessageGroupDetail alloc] init];
    MMBidSummary* bidSummary2 = [[MMBidSummary alloc] init];
    [bidSummary2 setPrice:[NSNumber numberWithInt:20]];
    [bmg2 setBidSummary:bidSummary2];
    
    //BidMessageGroup3
    MMBidMessageGroupDetail* bmg3 = [[MMBidMessageGroupDetail alloc] init];
    MMBidSummary* bidSummary3 = [[MMBidSummary alloc] init];
    [bidSummary3 setPrice:[NSNumber numberWithInt:5]];
    [bmg3 setBidSummary:bidSummary3];
    
    NSArray* sortedBmgs = [[NSArray alloc] initWithObjects:bmg1,bmg2,bmg3, nil];
    sortedBmgs = [BidMessageGroupSortingUtils sortBidMessageGroupsGreatestPrice:sortedBmgs];
    
    STAssertTrue([sortedBmgs objectAtIndex:0] == bmg1, @"This is not the highest value");
    STAssertTrue([sortedBmgs objectAtIndex:2] == bmg3, @"This is not the lowest value");
}

-(void) testSortGreatestPrice_Test2NULLPRICE{
    
    //TESTING ITEM PRICE = NULL
    
    //BidMessageGroup1
    MMBidMessageGroupDetail* bmg1 = [[MMBidMessageGroupDetail alloc] init];
    MMBidSummary* bidSummary1 = [[MMBidSummary alloc] init];
    [bidSummary1 setPrice:[NSNumber numberWithInt:35]];
    [bmg1 setBidSummary:bidSummary1];
    
    //BidMessageGroup2
    MMBidMessageGroupDetail* bmg2 = [[MMBidMessageGroupDetail alloc] init];
    MMBidSummary* bidSummary2 = [[MMBidSummary alloc] init];
    [bmg2 setBidSummary:bidSummary2];
    
    
    NSArray* sortedBmgs = [[NSArray alloc] initWithObjects:bmg1,bmg2, nil];
    sortedBmgs = [BidMessageGroupSortingUtils sortBidMessageGroupsGreatestPrice:sortedBmgs];
        
    STAssertTrue([sortedBmgs objectAtIndex:1] == bmg2, @"This is not the lowest value");
    
}

-(void) testfiltersortBidMessageGroupsForMostRecentUserBids{
    
    //BidMessageGroup1
    MMBidSummary* bidSummary1 = [[MMBidSummary alloc] init];
    [bidSummary1 setCreatedDate:[NSDate dateWithTimeIntervalSinceNow:100000]];
    [bidSummary1 setUserId:[NSNumber numberWithInt:1]];
    [bidSummary1 setUserName:@"Bob"];
    [bidSummary1 setPrice:[NSNumber numberWithInt:35]];

    //BidMessageGroup2
    MMBidSummary* bidSummary2 = [[MMBidSummary alloc] init];
    [bidSummary2 setCreatedDate:[NSDate dateWithTimeIntervalSinceNow:300000]];
    [bidSummary2 setUserId:[NSNumber numberWithInt:1]];
    [bidSummary2 setUserName:@"Bob"];
    [bidSummary2 setPrice:[NSNumber numberWithInt:90]];
    
    //BidMessageGroup3
    MMBidSummary* bidSummary3 = [[MMBidSummary alloc] init];
    [bidSummary3 setCreatedDate:[NSDate dateWithTimeIntervalSinceNow:200000]];
    [bidSummary3 setUserId:[NSNumber numberWithInt:1]];
    [bidSummary3 setUserName:@"Bob"];
    [bidSummary3 setPrice:[NSNumber numberWithInt:120]];
    
    NSArray* bidSummaries = [[NSArray alloc] initWithObjects:bidSummary1,bidSummary2,bidSummary3, nil]; 
    NSArray* messageGroups = [[NSArray alloc] init];
    MMJobDetail* jobDetail = [[MMJobDetail alloc] init];
    
    NSArray* bmgArray = [MMBidMessageGroupDetail generateBidMessageGroupDetailsForBidSummaries:bidSummaries andMessageGroups:messageGroups job:jobDetail];
    
    bmgArray = [BidMessageGroupSortingUtils filtersortBidMessageGroupsForMostRecentUserBids:bmgArray];
    
    MMBidMessageGroupDetail* bmg = [bmgArray objectAtIndex:0];
    
    STAssertTrue(bmg.bidSummary == bidSummary2, @"This is not the newest bid");
     
}


-(void) testsortBidMessageGroupsWinnerAtTop{
    //BidMessageGroup1
    MMBidMessageGroupDetail* bmg1 = [[MMBidMessageGroupDetail alloc] init];
    MMBidSummary* bidSummary1 = [[MMBidSummary alloc] init];
    [bidSummary1 setBidId:[NSNumber numberWithInt:5]];
    [bmg1 setBidSummary:bidSummary1];
    
    //BidMessageGroup2
    MMBidMessageGroupDetail* bmg2 = [[MMBidMessageGroupDetail alloc] init];
    MMBidSummary* bidSummary2 = [[MMBidSummary alloc] init];
    [bidSummary2 setBidId:[NSNumber numberWithInt:3]];
    [bmg2 setBidSummary:bidSummary2];
    
    //BidMessageGroup3
    MMBidMessageGroupDetail* bmg3 = [[MMBidMessageGroupDetail alloc] init];
    MMBidSummary* bidSummary3 = [[MMBidSummary alloc] init];
    [bidSummary3 setBidId:[NSNumber numberWithInt:1]];
    [bmg3 setBidSummary:bidSummary3];
    
    //NSArray* bidSummaries = [[NSArray alloc] initWithObjects:bidSummary1,bidSummary2,bidSummary3, nil]; 
    
    
    MMJobDetail* jobDetail = [[MMJobDetail alloc] init];
    [jobDetail setAcceptedBidId:[NSNumber numberWithInt:3]];
    [jobDetail setWinningBidderId:[NSNumber numberWithInt:99]];

    NSArray* bmgArray = [[NSArray alloc] initWithObjects:bmg1, bmg2, bmg3, nil ];
    bmgArray = [BidMessageGroupSortingUtils sortBidMessageGroupsWinnerAtTop:bmgArray ForJob:jobDetail];

    
    MMBidMessageGroupDetail* bmg = [bmgArray objectAtIndex:0];
    
    
    
    STAssertTrue(bmg.bidSummary == bidSummary2, @"This is not the winning bid");
}

@end
