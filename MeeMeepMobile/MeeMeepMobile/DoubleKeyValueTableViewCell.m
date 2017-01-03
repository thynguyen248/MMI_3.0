//
//  DoubleKeyValueTableViewCell.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 8/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "DoubleKeyValueTableViewCell.h"

@implementation DoubleKeyValueTableViewCell

@synthesize key,value,value2;


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
