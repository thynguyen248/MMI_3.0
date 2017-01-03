//
//  BidDetailViewController.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 5/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GUIViewInterface.h"

#import "MMBidDetail.h"

#import "KeyValueTableViewCell.h"


#import "LargeKeyValueTableViewCell.h"

#import "BidsButtonTableViewCell.h"

#import "ConfirmBidViewController.h"
#import "WithdrawBidViewController.h"

#import "RatingTableViewCell.h"

#import "GUICommon.h"


#import "MMAsyncActivityDelegate.h"
#import "MMAsyncActivityManagement.h"
#import "LoadingView.h"

#import "RatingTableViewCell.h"
#import "RatingTableViewCellDelegate.h"


@interface BidDetailViewController : UIViewController <GUIViewInterface, UITableViewDelegate, UITableViewDataSource, MMAsyncActivityDelegate, UIAlertViewDelegate, RatingTableViewCellDelegate>{
    
    BOOL loadingBidDetails;
    BOOL loadingUserDetails;
    LoadingView* loadingDialog;    
    id<MMAsyncActivityManagement> activityManagement;
    
    id<GUIRestDeligate> restDeligate;
    
    MMBidDetail* bid;
    
    NSNumber* myBidId;
    
    MMJobDetail* thisJob;
        
    UIBarButtonItem* btnActions; //Bar button that calls showActions
    UIActionSheet* myActionSheet; //Defines buttons for actions - initialized in updateBidDetails (occurs after async returns)
        
}


@property (nonatomic, strong) id<MMAsyncActivityManagement> activityManagement;
@property (nonatomic,strong) IBOutlet UITableView* detailTableView;
@property (nonatomic,strong) IBOutlet UINavigationBar* navBar;
-(id) initWithBidId:(id<GUIRestDeligate>)commandObj bidId:(NSNumber*)bidId job:(MMJobDetail*)jobDetail;

@end
