//
//  BidSummaryTableViewCell.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 1/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MMBidSummary.h"
#import "GradientButtonControl.h"


@interface BidSummaryTableViewCell : UITableViewCell{
    
    NSArray* stars;
}


@property (nonatomic, retain) IBOutlet UILabel* labelUsername;
@property (nonatomic, strong) IBOutlet UILabel* labelAmount;

@property(nonatomic,strong) IBOutlet UIImageView* rating_star1;
@property(nonatomic,strong) IBOutlet UIImageView* rating_star2;
@property(nonatomic,strong) IBOutlet UIImageView* rating_star3;
@property(nonatomic,strong) IBOutlet UIImageView* rating_star4;
@property(nonatomic,strong) IBOutlet UIImageView* rating_star5;

@property (nonatomic,strong) IBOutlet UILabel* labelRatingNotification;

-(void) setupCellWithBidSummary:(MMBidSummary*) bid;

@end
