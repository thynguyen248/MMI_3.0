//
//  TestTableViewCell1.m
//  Test41
//
//  Created by Aydan Bedingham on 8/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "LargeKeyValueTableViewCell.h"

@implementation LargeKeyValueTableViewCell

@synthesize key, value;


//Should really be in init
-(void) setUpCellUsingText: (NSString*) defaultText withPlaceHolder: (NSString*) placeholder andIsEditable: (BOOL) isEditable{
    //
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
