//
//  ConversationSummaryCellDelegate.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 14/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMMessageGroup.h"

@protocol ConversationSummaryCellDelegate <NSObject>


-(void) conversationSummaryCellDidReturnMessageGroup: (MMMessageGroup*) messageGroup;



@end
