//
//  ConfirmBidViewController.h
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

#import "MMJobIndemnity.h"
#import "KeyboardToolBar.h"

@interface ConfirmBidViewController : UIViewController<GUIViewInterface, UIAlertViewDelegate, MMAsyncActivityDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>{
    
    BOOL acceptingBid;
    LoadingView* loadingDialog;    
    id<MMAsyncActivityManagement> activityManagement;
    
    id<GUIRestDeligate> restDeligate;
    UINavigationController *navController;
    MMBidDetail* bid;
    MMJobDetail* job;
    
    MMJobIndemnity* jobIndemnity;
    
    KeyboardToolBar* keyboardToolbar;
    
    NSMutableArray* jobIndemnities;
    
    UIView* activeTextField;
}

@property (nonatomic, strong) id<MMAsyncActivityManagement> activityManagement;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *viewToScroll;

@property (strong, nonatomic) IBOutlet UITextField *fromAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *toAddressTextField;
@property (strong, nonatomic) IBOutlet UILabel *fromSuburbLabel;
@property (strong, nonatomic) IBOutlet UILabel *toSuburbLabel;

@property (strong, nonatomic) IBOutlet UITextField *mobileNumberTextField;

@property (strong, nonatomic) IBOutlet UITableView *indemnityTableView;
@property (strong, nonatomic) IBOutlet UIPickerView *indemnityPicker;
@property (strong, nonatomic) IBOutlet UITextField *indemnityTextField;

@property (nonatomic,strong) IBOutlet GradientButtonControl* btnIAgree;

@property (nonatomic,strong) IBOutlet UILabel* labelConfirmTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelTotalCharge;

-(id) initWithRestDeligate: (id<GUIRestDeligate>) commandObj andBidDetail:(MMBidDetail*) bidDetail andJobDetail:(MMJobDetail*) jobDetail;
-(IBAction) btnIAgreeClick;
-(IBAction) btnCancelClick;

@end
