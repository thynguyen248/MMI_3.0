//
//  BidSummaryTableViewCell.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 1/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "BidSummaryTableViewCell.h"

#import "GUICommon.h"

@implementation BidSummaryTableViewCell

@synthesize labelUsername;
@synthesize labelAmount;
@synthesize rating_star1, rating_star2, rating_star3, rating_star4, rating_star5;
@synthesize labelRatingNotification;

NSString* const StarImageEnabled = @"Star2.png";
NSString* const  StarImageDisabled = @"Star2_Grey.png";

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1]];
    //[bgColorView setBackgroundColor: [UIColor lightGrayColor]];
    [self setSelectedBackgroundView:bgColorView];
}

-(void) updateRating: (NSNumber*) rating{
    //Set stars to reflect rating
    for (NSInteger i = 0; i<[stars count]; i++)
    {
        UIImageView* star = [stars objectAtIndex:i];
        
        if (rating != nil && i < [rating intValue])
        {
            [star setImage:[UIImage imageNamed:StarImageEnabled]];
        }
        else
        {
            [star setImage:[UIImage imageNamed:StarImageDisabled]];
        }
    }
}

-(void) updateGUIWithStatus:(NSString*)statusText{
    
    UIColor* labelColor;
    UIColor* backgroundColor;
    
    if ([statusText isEqualToString:@"BID_ACCEPTED"]){
        
        labelColor = [UIColor darkGrayColor];
        backgroundColor = [UIColor lightGrayColor];
        
        [rating_star1 setAlpha:0.6];
        [rating_star2 setAlpha:0.6];
        [rating_star3 setAlpha:0.6];
        [rating_star4 setAlpha:0.6];
        [rating_star5 setAlpha:0.6];
        
    } else {
        labelColor = [UIColor blackColor];
        backgroundColor = [GUICommon MeeMeepBackground];
        
        UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        bgview.opaque = YES;
        bgview.backgroundColor = [UIColor whiteColor];
        [self setBackgroundView:bgview];
        
        [rating_star1 setAlpha:1];
        [rating_star2 setAlpha:1];
        [rating_star3 setAlpha:1];
        [rating_star4 setAlpha:1];
        [rating_star5 setAlpha:1];
    }
    
    //Set label colour
    [labelUsername setTextColor:labelColor];
    [labelRatingNotification setTextColor:labelColor];
    [labelAmount setTextColor:labelColor];
    
    //Set background colour
    UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    bgview.opaque = YES;
    bgview.backgroundColor = backgroundColor;
    [self setBackgroundView:bgview];
}

-(void) setupCellWithBidSummary: (MMBidSummary*) bid {
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //Load star images into array
    stars = [[NSArray alloc] initWithObjects:rating_star1, rating_star2, rating_star3, rating_star4, rating_star5, nil];
    
    labelUsername.text = [GUICommon formatForString: bid.userName];  
    labelAmount.text = [GUICommon formatCurrency:bid.price];

    [self updateRating:bid.userRating];
    
    // TODO: Fix to use BidStatus object
    [self updateGUIWithStatus: [GUICommon formatForString: bid.status]];
}

@end
