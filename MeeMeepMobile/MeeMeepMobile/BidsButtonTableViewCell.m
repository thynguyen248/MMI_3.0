//
//  BidsButtonTableViewCell.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 9/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "BidsButtonTableViewCell.h"

@implementation BidsButtonTableViewCell

@synthesize btnCounter,textLabel;



- (void)setSelected:(BOOL)selected animated:(BOOL)animated{    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1]];
    [self setSelectedBackgroundView:bgColorView];
}




-(void) setCounterTo:(NSNumber*) count{
    [btnCounter setTitle:[count stringValue] forState:UIControlStateNormal];
    [btnCounter sizeToFit];
    
    btnCounter.frame = CGRectMake(self.frame.size.width-btnCounter.frame.size.width-50, btnCounter.frame.origin.y, btnCounter.frame.size.width, btnCounter.frame.size.height);
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
     // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
