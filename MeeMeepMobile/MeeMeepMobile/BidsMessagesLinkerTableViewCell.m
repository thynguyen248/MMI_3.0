//
//  BidsMessagesLinkerTableViewCell.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 15/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "BidsMessagesLinkerTableViewCell.h"

#import "GUICommon.h"

@implementation BidsMessagesLinkerTableViewCell

@synthesize bidsButtonTableView, messagesButtonTableView;



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void) setupCellWithBidsButtonAndMessageButton: (BOOL) showMessagesButton withDelegate: (id<BidsMessagesLinkerCellDelegate>) d{
    
    delegate = d;
    
    if (showMessagesButton==false){
        [messagesButtonTableView setHidden:YES];
        bidsButtonTableView.frame = CGRectMake(-10, -10, 320, bidsButtonTableView.frame.size.height);
    }
    
    //Make the cell transparent - gets rid of border caused by table seperator
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor clearColor];
    self.backgroundView = backView;
}





-(NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    UITableViewCell* cell = [GUICommon getMyTableViewCell:tableView];
    
    if (tableView==bidsButtonTableView) [cell.textLabel setText:@"Quotes"];
    else [cell.textLabel setText:@"Messages"];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //
    if (tableView==bidsButtonTableView) [delegate bidsMessagesLinkerCellDidTouchUpInsideBidsButton];
    else [delegate bidsMessagesLinkerCellDidTouchUpInsideMessagesButton];
}


@end
