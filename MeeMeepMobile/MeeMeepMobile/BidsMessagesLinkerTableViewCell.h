//
//  BidsMessagesLinkerTableViewCell.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 15/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BidsMessagesLinkerCellDelegate.h"

@interface BidsMessagesLinkerTableViewCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource>{
    id<BidsMessagesLinkerCellDelegate> delegate;
}


-(void) setupCellWithBidsButtonAndMessageButton: (BOOL)showMessagesButton withDelegate: (id<BidsMessagesLinkerCellDelegate>) d;

@property(nonatomic,strong) IBOutlet UITableView* bidsButtonTableView;

@property(nonatomic,strong) IBOutlet UITableView* messagesButtonTableView;

@end
