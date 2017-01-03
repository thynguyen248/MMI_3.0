//
//  EditableRatingTableViewCell.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 3/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingTableViewCellDelegate.h"

@interface RatingTableViewCell : UITableViewCell{
    NSInteger rating;
    NSArray* stars;
    id<RatingTableViewCellDelegate> delegate;
}

@property (nonatomic,strong) IBOutlet UIButton* btnStar1;
@property (nonatomic,strong) IBOutlet UIButton* btnStar2;
@property (nonatomic,strong) IBOutlet UIButton* btnStar3;
@property (nonatomic,strong) IBOutlet UIButton* btnStar4;
@property (nonatomic,strong) IBOutlet UIButton* btnStar5;

-(void) setUpCellWithRating: (NSInteger) ratingValue isEditable: (BOOL) isEditable andDelegate:(id<RatingTableViewCellDelegate>)delegate;
-(void) setRating: (NSInteger) ratingValue;
-(NSInteger) getRating;

-(IBAction)btnStar1Click:(id)sender;
-(IBAction)btnStar2Click:(id)sender;
-(IBAction)btnStar3Click:(id)sender;
-(IBAction)btnStar4Click:(id)sender;
-(IBAction)btnStar5Click:(id)sender;

@end
