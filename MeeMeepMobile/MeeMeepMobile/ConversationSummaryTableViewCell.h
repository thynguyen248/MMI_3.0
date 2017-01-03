//
//  ConversationSummaryTableViewCell.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 11/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "MMMessageGroup.h"

#import "ConversationSummaryCellDelegate.h"

#import "GradientButtonControl.h"

@interface ConversationSummaryTableViewCell : UITableViewCell{
    
    id<ConversationSummaryCellDelegate> delegate;
    
    MMMessageGroup* messageGroup;
}



@property (nonatomic,strong) MMMessageGroup* messageGroup;

@property (nonatomic,strong) IBOutlet UILabel* lblUsername;

@property (nonatomic,strong) IBOutlet UILabel* lblSubject;

@property (nonatomic,strong) IBOutlet GradientButtonControl* messageView;

@property (nonatomic,strong) IBOutlet UILabel* lblMessageCount;


-(void) setupCellWithMessageGroup:(MMMessageGroup*) theMessageGroup andDelegate: (id<ConversationSummaryCellDelegate>) d;

-(IBAction)messageViewClick:(id)sender;

@end
