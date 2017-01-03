//
//  EditableRatingTableViewCell.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 3/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "RatingTableViewCell.h"


#define StarImageEnabled @"Star.png";
#define StarImageDisabled @"Star_Grey.png";

@implementation RatingTableViewCell

@synthesize btnStar1, btnStar2, btnStar3, btnStar4, btnStar5;



-(void) setRating: (NSInteger) ratingValue{
    rating = ratingValue;
    
    UIButton* star;
    for (NSInteger i = 0; i<[stars count]; i++){
        star = [stars objectAtIndex:i];

        NSString* enabledImage = StarImageEnabled;
        NSString* disabledImage = StarImageDisabled;
        
        if (i < rating) 
            [star setImage:[UIImage imageNamed:enabledImage] forState:UIControlStateNormal];
        else
            [star setImage:[UIImage imageNamed:disabledImage] forState:UIControlStateNormal];
         
    }
    
    [delegate onRatingChange:rating];
}


//Should really be in init
-(void) setUpCellWithRating: (NSInteger) ratingValue isEditable: (BOOL) isEditable andDelegate:(id<RatingTableViewCellDelegate>)del {
    delegate = del;
    stars = [[NSArray alloc] initWithObjects:btnStar1, btnStar2, btnStar3, btnStar4, btnStar5, nil];
    [self setRating:ratingValue];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (isEditable==false) [self setUserInteractionEnabled:FALSE];
}


-(NSInteger) getRating{
    return rating;
}


-(IBAction)btnStar1Click:(id)sender{
    [self setRating:1];
}


-(IBAction)btnStar2Click:(id)sender{
    [self setRating:2];
}

-(IBAction)btnStar3Click:(id)sender{
    [self setRating:3];
}

-(IBAction)btnStar4Click:(id)sender{
    [self setRating:4];
}

-(IBAction)btnStar5Click:(id)sender{
    [self setRating:5];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
