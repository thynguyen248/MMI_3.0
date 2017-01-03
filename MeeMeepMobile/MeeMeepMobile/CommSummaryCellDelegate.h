//
//  CommSummaryCellDelegate.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 9/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMMessageGroup.h"
#import "MMBidSummary.h"


@protocol CommSummaryCellDelegate <NSObject>

-(void) conversationSummaryCellDidReturnBidSummary: (MMBidSummary*) bidSummary andUserId: (NSNumber*) otherUserId;

-(void) conversationSummaryCellDidReturnMessageGroup:(MMMessageGroup*)messageGroup;

@end
