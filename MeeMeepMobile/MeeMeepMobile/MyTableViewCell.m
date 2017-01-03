//
//  MyTableViewCell.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 4/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [self setSelectionStyle:UITableViewCellSelectionStyleGray];
    /*
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1]];
    [self setSelectedBackgroundView:bgColorView];
     */
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.

    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
