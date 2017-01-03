//
//  TableViewCell.m
//  MeeMeepMobile
//
//  Created by John Rowland on 29/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

@synthesize textLabel;


- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1]];
    [self setSelectedBackgroundView:bgColorView];
}

@end
