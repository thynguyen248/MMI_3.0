//
//  TestTableViewCell1.m
//  Test41
//
//  Created by Aydan Bedingham on 8/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "KeyValueTableViewCell.h"

@implementation KeyValueTableViewCell

@synthesize key,value;


- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1]];
    [self setSelectedBackgroundView:bgColorView];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
