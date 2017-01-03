//
//  CreateBidViewController.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 15/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "GUIViewInterface.h"
#import "BidsButtonTableViewCell.h"
#import "GUICommon.h"
#import "GUICommon.h"
#import "KeyboardToolBar.h"
#import "EditableTableViewCell.h"


#import "MMAsyncActivityDelegate.h"
#import "MMAsyncActivityManagement.h"
#import "LoadingView.h"
#import "MMJobDetail.h"

#import "GradientButtonControl.h"

@class MMPair;
@class MeeMeepCheckbox;

@interface CreateBidViewController : UIViewController <GUIViewInterface ,UITableViewDataSource, UITableViewDelegate,  UIAlertViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIAlertViewDelegate, MMAsyncActivityDelegate, UIScrollViewDelegate>{    
    
    id<GUIRestDeligate> restDeligate;
    
    UIScrollView* scrollView;
        
    KeyboardToolBar* keyboardToolbar;
    
    UITextField *activeTextField;
    NSInteger completionIndex;
    
    UITableView* pickupDateTableView;
    UITableView* deliveryDateTableView;    
    
    BOOL postingBid;
    LoadingView* loadingDialog;    
    id<MMAsyncActivityManagement> activityManagement;
    MMJobDetail* thisJob;
    
    MMPair* selectedTransportType;
}

-(id) initWithCommandObject:(id <GUIRestDeligate>)commandObj job:(MMJobDetail*)job;

@property (nonatomic,strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic,strong) IBOutlet UIView* viewToScroll;

@property (nonatomic,strong) KeyboardToolBar* keyboardToolbar;

@property (nonatomic,strong) IBOutlet UITableView* pickupDateTableView;
@property (nonatomic,strong) IBOutlet UITextField* inptPickupJobDate;
@property (nonatomic,strong) IBOutlet UITableView* pickupTimeTableView;
@property (nonatomic,strong) IBOutlet UITextField* inptPickupJobTime;
@property (nonatomic,strong) IBOutlet UIDatePicker* pickupJobDatePicker;
@property (nonatomic,strong) IBOutlet UIPickerView* pickupJobTimePicker;
@property (nonatomic,strong) IBOutlet UILabel* lblPickupTimeFrameNote;
@property (strong, nonatomic) IBOutlet UILabel *lblPickupDateRange;

@property (nonatomic,strong) IBOutlet UITableView* deliveryDateTableView;
@property (nonatomic,strong) IBOutlet UITextField* inptDeliveryJobDate;
@property (nonatomic,strong) IBOutlet UITableView* deliveryTimeTableView;
@property (nonatomic,strong) IBOutlet UITextField* inptDeliveryJobTime;
@property (nonatomic,strong) IBOutlet UIDatePicker* deliveryJobDatePicker;
@property (nonatomic,strong) IBOutlet UIPickerView* deliveryJobTimePicker;
@property (nonatomic,strong) IBOutlet UILabel* lblDeliveryTimeFrameNote;
@property (strong, nonatomic) IBOutlet UILabel *lblDeliveryDateRange;

@property (strong, nonatomic) IBOutlet UITextField *inptVehicle;
@property (strong, nonatomic) IBOutlet UILabel *lblVehicle;
@property (strong, nonatomic) IBOutlet UILabel *lblVehicleNote;
@property (strong, nonatomic) IBOutlet UITableView *tableViewDDVehicle;
@property (strong, nonatomic) IBOutlet UIPickerView *vehiclePicker;

@property (nonatomic,strong) IBOutlet UITableView* expiryDateTableView;
@property (nonatomic,strong) IBOutlet UITextField* inptExpiryDate;
@property (nonatomic,strong) IBOutlet UIDatePicker* expiryDatePicker;
@property (nonatomic,strong) IBOutlet UILabel* lblExpiryNote;

@property (strong, nonatomic) IBOutlet UILabel *lblPayAmount;
@property (nonatomic,strong) IBOutlet UITextField* inptPayAmount;
@property (strong,nonatomic) IBOutlet UILabel *lblPayAmountNote;

-(IBAction) btnCreateBid;

- (void) deRegisterKeyboardNotifications;
- (void) registerForKeyboardNotifications;
- (void) keyboardWasHidden:(NSNotification *) notification;


-(BOOL) checkForFieldErrors;

@property (nonatomic, strong) IBOutlet GradientButtonControl* btnDone;

-(void) resetInputFields;

@property (nonatomic,strong) IBOutlet UIView* moreOptions;


-(void)dateChange:(id)sender;

-(IBAction)backgroundTouched:(id)sender;
-(IBAction) btnTCNoteClicked:(id)sender;

@property (nonatomic,strong) id<MMAsyncActivityManagement> activityManagement;

@end
