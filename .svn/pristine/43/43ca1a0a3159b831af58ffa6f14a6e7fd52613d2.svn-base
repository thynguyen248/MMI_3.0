//
//  BidsViewController.h
//  MeeMeepMobile
//
//  Displays active bids (Current bid) of members who have bid on a job
//  This view controller is part of the non-shaker user workflow
//
//  - Uses async operation to get active bids
//  - Displays bids in table
//
//  Created by Aydan Bedingham on 1/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GUIViewInterface.h"
#import "BidSummaryTableViewCell.h"
#import "MMBidSummary.h"
#import "BidDetailViewController.h"

#import "MMAsyncActivityDelegate.h"
#import "MMAsyncActivityManagement.h"
#import "LoadingView.h"

#import "GUICommon.h"



@interface BidsViewController : UIViewController <GUIViewInterface, UITableViewDelegate, UITableViewDataSource, MMAsyncActivityDelegate>{
    
    BOOL loadingBids;
    LoadingView* loadingDialog;
    
    id<MMAsyncActivityManagement> activityManagement;
    
    UITableView* bidTableView;
    
    id<GUIRestDeligate> restDeligate;
    
    MMJobDetail* thisJob;
    
    NSArray* bids;
    
    
}

@property (nonatomic,strong) IBOutlet UITableView* bidTableView;
    

@property (nonatomic, strong) id<MMAsyncActivityManagement> activityManagement;
-(id) initWithJob:(id<GUIRestDeligate>)commandObj job:(MMJobDetail*)jobDetail;
-(void)refreshData;

@end
