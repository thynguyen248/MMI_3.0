//
//  StyledKeyValueTableViewCell.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 7/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "StyledKeyValueTableViewCell.h"

@implementation StyledKeyValueTableViewCell

@synthesize key;
@synthesize value;
@synthesize bgTouchCatcherControl;


- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1]];
    [self setSelectedBackgroundView:bgColorView];
}

- (void) validate:(bool)isRequired
{
    if(isRequired && (value.text == nil || [value.text length] == 0))
    {
        NSString* message = [NSString stringWithFormat:@"%@ is required", key.text];
        NSException* ex = [NSException exceptionWithName:message reason:message userInfo:nil];
        @throw ex;
    }
}

//Standard key/value
-(void) setupCellWithKey:(NSString*) keyString andValue:(NSString*)valueString andValuePlaceHolder: valuePlaceholder isEditable:(BOOL)isEditable{
       
    [key setText:keyString];
    [value setText:valueString];
    [value setPlaceholder:valuePlaceholder];
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
