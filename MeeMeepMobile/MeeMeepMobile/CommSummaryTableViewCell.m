//
//  CommSummaryTableViewCell.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 8/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "CommSummaryTableViewCell.h"

#import "GUICommon.h"

@implementation CommSummaryTableViewCell

@synthesize lblUsername;

@synthesize rating_star1, rating_star2, rating_star3, rating_star4, rating_star5;

@synthesize lblCurrentBid, lblCurrentBidNote, lblMessageCount;

@synthesize bidView, messageView;

@synthesize lblRatingNote;


#define StarImageEnabled @"Star2.png";
#define StarImageDisabled @"Star2_Grey.png";




-(IBAction)bidViewClick:(id)sender{
    [delegate conversationSummaryCellDidReturnBidSummary: bidMessageGroup.bidSummary andUserId:bidMessageGroup.userId];
}


-(IBAction)messageViewClick:(id)sender{
    [delegate conversationSummaryCellDidReturnMessageGroup: bidMessageGroup.messageGroup];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



-(void) updateComponents{
    //Update components

    //Labels and stuff
    
    
    
    //Stars
   
    BOOL ratingExists;
    if ((bidMessageGroup) && (bidMessageGroup.bidSummary)) ratingExists = true; else ratingExists=false;
    
    NSNumber* rating;
    rating = [GUICommon formatForNumber: bidMessageGroup.bidSummary.userRating];

    //Hide or show rating components depending on whether rating exists
    [lblRatingNote setHidden:!ratingExists];
    for (UIImageView* star in stars){
            [star setHidden:!ratingExists];
    }
    
    if (ratingExists){
        //Set rating according to bid rating
        rating = bidMessageGroup.bidSummary.userRating;
        UIImageView* star;
        for (NSInteger i = 0; i<[stars count]; i++){
            star = [stars objectAtIndex:i];
            NSString* enabledImage = StarImageEnabled;
            NSString* disabledImage = StarImageDisabled;
            if (i<[rating intValue]) 
                [star setImage:[UIImage imageNamed:enabledImage]];
            else
                [star setImage:[UIImage imageNamed:disabledImage]];
        }
    }
    
}



-(void) setupCellWithBidMessageGroup: (MMBidMessageGroupDetail*) bmDetail andDelegate: (id<CommSummaryCellDelegate>) d{  
    
    delegate = d;
    
    bidMessageGroup = bmDetail;
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //Load star images into array
    stars = [[NSArray alloc] initWithObjects:rating_star1, rating_star2, rating_star3, rating_star4, rating_star5, nil];
    
    //Set username
    [lblUsername setText:[GUICommon formatForString:bidMessageGroup.username]];
    
    
    BOOL hasBid;
    if (bidMessageGroup.bidSummary) hasBid = true; else hasBid = false;
    
    BOOL hasMessages;
    if ((!bidMessageGroup.messageGroup)||([bidMessageGroup.messageGroup.messages count] == 0)) hasMessages = false; else hasMessages = true;
    
    NSArray* normalColors;
    NSArray* highlightedColors;

    
    if (hasBid){
        [lblCurrentBid setText:[GUICommon formatCurrency:bidMessageGroup.bidSummary.price]];
        
        //Style bid view
        if ([bidMessageGroup.bidSummary.status isEqualToString:@"Closed"]){
            [lblCurrentBidNote setText:@"closed bid"];
            [lblCurrentBid setText:[GUICommon formatCurrency:bidMessageGroup.bidSummary.price]];
            normalColors = [GUICommon MeeMeepButtonGradientGrayed];
            highlightedColors =  [GUICommon MeeMeepButtonGradientGrayedHighlighted];
            [bidView setGradientColor:highlightedColors forState:UIControlStateHighlighted];
            [bidView setGradientColor:normalColors forState:UIControlStateNormal];
        } else{
            if ([bidMessageGroup.bidSummary.status isEqualToString:@"Accepted"])
                [lblCurrentBidNote setText:@"accepted bid"];
            else [lblCurrentBidNote setText:@"current bid"];
            normalColors = [GUICommon MeeMeepActionButtonGradient];
            highlightedColors =  [GUICommon MeeMeepActionButtonGradientHighlighted];
            [bidView setGradientColor:highlightedColors forState:UIControlStateHighlighted];
            [bidView setGradientColor:normalColors forState:UIControlStateNormal];
        }
    } else{
        [lblCurrentBid setText:@"0"];
        [bidView setBackgroundColor:[UIColor clearColor]];
        [bidView setUserInteractionEnabled:FALSE];
    }

    
    if (hasMessages){
        [lblMessageCount setText: [NSString stringWithFormat:@"%d", [bidMessageGroup.messageGroup.messages count]]];
    } else{
        [lblMessageCount setText:@"0"];
    }
    
    // Style message view    
    normalColors = [GUICommon MeeMeepButtonGradientOrange];            
    highlightedColors = [GUICommon MeeMeepButtonGradientOrangeHighlighted];
    [messageView setGradientColor:highlightedColors forState:UIControlStateHighlighted];
    [messageView setGradientColor:normalColors forState:UIControlStateNormal];
    
    
    [self updateComponents];
    
}



@end
