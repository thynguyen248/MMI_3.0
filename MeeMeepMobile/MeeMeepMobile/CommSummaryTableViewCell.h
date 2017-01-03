//
//  CommSummaryTableViewCell.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 8/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "MMBidSummary.h"
#import "MMMessageGroup.h"

#import "CommSummaryCellDelegate.h"
#import "GradientButtonControl.h"


#import "MMBidMessageGroupDetail.h"

@interface CommSummaryTableViewCell : UITableViewCell {
    NSArray* stars;    
    
    MMBidMessageGroupDetail* bidMessageGroup;
    
    id<CommSummaryCellDelegate> delegate;
}

@property (nonatomic,strong) IBOutlet UILabel* lblRatingNote;
@property (nonatomic,strong) IBOutlet UIImageView* rating_star1;
@property (nonatomic,strong) IBOutlet UIImageView* rating_star2;
@property (nonatomic,strong) IBOutlet UIImageView* rating_star3;
@property (nonatomic,strong) IBOutlet UIImageView* rating_star4;
@property (nonatomic,strong) IBOutlet UIImageView* rating_star5;

@property (nonatomic, retain) IBOutlet UILabel* lblUsername;
@property (nonatomic,strong) IBOutlet UILabel* lblCurrentBid;
@property (nonatomic,strong) IBOutlet UILabel* lblCurrentBidNote;
@property (nonatomic,strong) IBOutlet UILabel* lblMessageCount;


@property (nonatomic,strong) IBOutlet GradientButtonControl* bidView;
@property (nonatomic,strong) IBOutlet GradientButtonControl* messageView;



-(IBAction)bidViewClick:(id)sender;
-(IBAction)messageViewClick:(id)sender;

-(void) setupCellWithBidMessageGroup: (MMBidMessageGroupDetail*) bmDetail andDelegate: (id<CommSummaryCellDelegate>) d;

@end
