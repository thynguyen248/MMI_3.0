//
//  WithdrawBidViewController.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 9/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GUIViewInterface.h"

#import "GUICommon.h"

#import "MMAsyncActivityDelegate.h"
#import "MMAsyncActivityManagement.h"
#import "LoadingView.h"

#import <QuartzCore/QuartzCore.h>

#import "GradientButtonControl.h"

// TODO refactor this with AcceptBidViewController (this is a copy but with Withdraw)
@interface WithdrawBidViewController : UIViewController<GUIViewInterface, UIAlertViewDelegate, MMAsyncActivityDelegate>{
    
    BOOL WithdrawingBid;
    LoadingView* loadingDialog;    
    id<MMAsyncActivityManagement> activityManagement;
    
    id<GUIRestDeligate> restDeligate;
    UINavigationController *navController;
    MMBidDetail* bid;
    
    UITextField* dummyTextField;
}

@property (nonatomic, strong) id<MMAsyncActivityManagement> activityManagement;

@property (nonatomic,strong) UITextField* dummyTextField;

@property (nonatomic,strong) IBOutlet GradientButtonControl* btnWithdraw;

@property (nonatomic,strong) IBOutlet UILabel* labelConfirmTitle;
@property (nonatomic, strong) UINavigationController *navController;

-(id) initWithBidDetail: (id<GUIRestDeligate>) commandObj bidDetail:(MMBidDetail*) bidDetail andNavigationController:(UINavigationController *) nc;

-(IBAction) btnWithdrawClick;
-(IBAction) btnCancelClick;

@end
