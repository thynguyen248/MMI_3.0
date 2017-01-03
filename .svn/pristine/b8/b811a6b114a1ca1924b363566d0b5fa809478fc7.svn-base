//
//  StyleKeyValueMultilineTableViewCell.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 23/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "StyledKeyValueMultilineTableViewCell.h"

@implementation StyledKeyValueMultilineTableViewCell

@synthesize key;
@synthesize value;
@synthesize bgTouchCatcherControl;


- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1]];
    [self setSelectedBackgroundView:bgColorView];
}



//Standard key/value
-(void) setupCellWithKey:(NSString*) keyString andValue:(NSString*)valueString isEditable:(BOOL)isEditable{
    
    [key setText:keyString];
    [value setText:valueString];
    [value setEditable:false];
    [value setUserInteractionEnabled:isEditable];
    [bgTouchCatcherControl setUserInteractionEnabled:isEditable];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



-(IBAction)backgroundTouch:(id)sender{
    //
    [value becomeFirstResponder];
}




@end
