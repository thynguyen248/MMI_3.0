//
//  BidMessageGroupDetail.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 17/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "MMBidMessageGroupDetail.h"

#import "GUICommon.h"

@implementation MMBidMessageGroupDetail

@synthesize userId, username;
@synthesize bidSummary,messageGroup;


-(id) initWithUserId: (NSNumber*) _userId andUsername: (NSString*) _username andBidSummary: (MMBidSummary*) _bidSummary andMessageGroup: (MMMessageGroup*) _messageGroup {
    self = [super init];
    if (self){
        [self setUserId:_userId];
        [self setUsername:_username];
        [self setBidSummary:_bidSummary];
        [self setMessageGroup:_messageGroup];
    }
    return self;
}



//Maps bids to messages IMPORTANT NOT: Mutliple bids from the same user will be linked to same message
+(NSArray*) generateBidMessageGroupDetailsForBidSummaries: (NSArray*) bidSummaries andMessageGroups: (NSArray*) messageGroups job:(MMJobDetail*)thisJob{

    NSMutableArray* bidMessageGroups = [[NSMutableArray alloc] init];
    
    //List of messages that have not been sorted
    NSMutableArray* unsortedMessages = [[NSMutableArray alloc] initWithArray:messageGroups];
    

    //List used to record messages that have been sorted
    NSMutableArray* sortedMessages = [[NSMutableArray alloc] init];
    
    
    //Create objects for each bid (whether it pertains to a message or not)
    if (bidSummaries)
    for (MMBidSummary* bidSummary in bidSummaries){
        MMMessageGroup* myMessageGroup = nil;
        NSInteger i = 0;
        MMMessageGroup* aMessageGroup;
        if (messageGroups)
        while ((myMessageGroup==nil)&&(i<[messageGroups count])){
            aMessageGroup = [messageGroups objectAtIndex:i];
            if ((aMessageGroup.userId) && (bidSummary.userId)){
                if ([aMessageGroup.userId isEqualToNumber: bidSummary.userId])
                myMessageGroup = aMessageGroup;
                
            }
            i++;
        }
        
        //Record if messages relates to a bid
        if (myMessageGroup!=nil)
            if (![sortedMessages containsObject:myMessageGroup]) [sortedMessages addObject: myMessageGroup];
        
        MMBidMessageGroupDetail* bidMessageGroup = [[MMBidMessageGroupDetail alloc] initWithUserId:bidSummary.userId andUsername:bidSummary.userName andBidSummary:bidSummary andMessageGroup:myMessageGroup];
        
        [bidMessageGroups addObject:bidMessageGroup];
    }
    
    //Remove messages that pertain to bids from list of unsorted
    [unsortedMessages removeObjectsInArray:sortedMessages];
    
    
    //Iterate over remaining unsorted messages (All these messages logically have no bids)
    for (MMMessageGroup* aMessageGroup in unsortedMessages){
        if (aMessageGroup.userId){
            MMBidMessageGroupDetail* bidMessageGroup = [[MMBidMessageGroupDetail alloc] initWithUserId:aMessageGroup.userId andUsername:aMessageGroup.username andBidSummary:nil andMessageGroup:aMessageGroup];
            [bidMessageGroups addObject:bidMessageGroup];
        }
    }

    // insert empty message group for bids with no messages yet (to start a messaging conversation)
    for (MMBidMessageGroupDetail* group in bidMessageGroups) {
        if(group.messageGroup == nil) {
            group.messageGroup = [[MMMessageGroup alloc] init];
            group.messageGroup.jobId = group.bidSummary.jobId;
            group.messageGroup.userId = group.userId;
            group.messageGroup.username = group.username;
            group.messageGroup.messages = [[NSArray alloc] init];
            group.messageGroup.subject = thisJob.title;
        }
    }
    
    return bidMessageGroups;
    
}














@end
