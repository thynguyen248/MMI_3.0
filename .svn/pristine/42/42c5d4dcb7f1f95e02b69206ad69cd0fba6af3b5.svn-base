//
//  CreateJobAltViewController.h
//  MeeMeepMobile
//
//  Created by John Rowland on 27/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIKeyboardToolbar.h"
#import "GUICommon.h"
#import "MMAsyncActivityManagementImpl.h"
#import "GUIViewInterface.h"
#import "LoadingView.h"
#import "MMCreateJobAsyncActivity.h"
#import "MMCreateJobActivityResult.h"
#import "MMJobDetail.h"
#import "JobDateGenerator.h"
#import "FromAddressAltViewController.h"


#import "KeyboardToolBar.h"

@interface CreateJobAltViewController : UIViewController <GUIViewInterface ,UITableViewDataSource, UITableViewDelegate,  UIAlertViewDelegate, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIAlertViewDelegate, MMAsyncActivityDelegate, UIScrollViewDelegate>{   
    
    id<GUIRestDeligate> restDeligate;
    
    UIScrollView* scrollView;
    
    MMJobAddress* fromAddress;
    MMJobAddress* destinationAddress;
    
    UITextField *activeTextField;
    BOOL viewShiftedForKeyboard;
    NSTimeInterval keyboardSlideDuration;
    CGFloat keyboardShiftAmount;
    NSInteger completionIndex;
    
    NSMutableArray* weightsArray;
    
    NSMutableArray* dateRangesArray;  
    NSInteger jobDateRangeIndex;
    
    UITableView* tableViewDDDate;
    
    CGRect originalViewFrame;
    CGRect originalScrollFrame;
    
    BOOL postingJob;
    LoadingView* loadingDialog;    
    id<MMAsyncActivityManagement> activityManagement;
    

}


@property (nonatomic,strong) IBOutlet UIScrollView* scroller;
@property (nonatomic,strong) IBOutlet UIView* contentView;

@property (nonatomic,strong) KeyboardToolBar* keyboardToolbar;

@property (nonatomic,strong) id<MMAsyncActivityManagement> activityManagement;


@property (nonatomic,strong) IBOutlet UITextField* inptObject;

@property (nonatomic,strong) IBOutlet UITableView* tableViewDDWeight;
@property (nonatomic,strong) IBOutlet UITextField* inptWeight;
@property (nonatomic,strong) IBOutlet UIPickerView* weightPicker;

@property (nonatomic,strong) IBOutlet UITextField* inptDimensionLength;
@property (nonatomic,strong) IBOutlet UITextField* inptDimensionWidth;
@property (nonatomic,strong) IBOutlet UITextField* inptDimensionHeight;

@property (nonatomic,strong) IBOutlet UITableView* fromAddressTableView;
@property (nonatomic,strong) IBOutlet UITableView* destinationAddressTableView;

@property (nonatomic,strong) IBOutlet UITextField* inptFromAddress;
@property (nonatomic,strong) IBOutlet UITextField* inptDestinationAddress;

@property (nonatomic,strong) IBOutlet UITextField* inptJobDate;
@property (nonatomic,strong) IBOutlet UIDatePicker* jobDatePicker;

@property (nonatomic,strong) IBOutlet UITextField* inptJobDateRange;
@property (nonatomic,strong) IBOutlet UIPickerView* jobDateRangePicker;

@property (nonatomic,strong) IBOutlet UITextField* inptJobTime;
@property (nonatomic,strong) IBOutlet UIDatePicker* jobTimePicker;

@property (nonatomic,strong) IBOutlet UITableView* tableViewDDDate;
@property (nonatomic,strong) IBOutlet UITableView* tableViewDDDateRange;
@property (nonatomic,strong) IBOutlet UITableView* tableViewDDTime;

@property (nonatomic,strong) IBOutlet UITextField* inptOptions;//Hidden field used for navigation only
@property (nonatomic,strong) IBOutlet UISegmentedControl* segUrgent;
@property (nonatomic,strong) IBOutlet UISegmentedControl* segFragile;
@property (nonatomic,strong) IBOutlet UISegmentedControl* segTimeSensitive;
@property (nonatomic,strong) IBOutlet UISegmentedControl* segPerishable;
@property (nonatomic,strong) IBOutlet UISegmentedControl* segWaterSensitive;
@property (nonatomic,strong) IBOutlet UISegmentedControl* segSecuritySensitive;

@property (nonatomic,strong) IBOutlet UIView* inptAdditionalInfo_Container;
@property (nonatomic,strong) IBOutlet UITextView* inptAdditionalInfo;

@property (nonatomic,strong) IBOutlet UITextField* inptPayAmount;

@property (nonatomic, strong) IBOutlet UIButton* btnDone;


@property (nonatomic,strong) IBOutlet UILabel* lblObjectNote;
@property (nonatomic,strong) IBOutlet UILabel* lblWeightNote;
@property (nonatomic,strong) IBOutlet UILabel* lblDimensionsNote;
@property (nonatomic,strong) IBOutlet UILabel* lblFromAddressNote;
@property (nonatomic,strong) IBOutlet UILabel* lblDestinationAddressNote;
@property (nonatomic,strong) IBOutlet UILabel* lblTimeFrameNote;
@property (nonatomic,strong) IBOutlet UILabel* lblPayAmountNote;


@property (nonatomic,strong) IBOutlet UIView* moreOptions; //View that slides up to hide job time


@property (nonatomic,strong) IBOutlet UITableView* tableContentContainer;

-(void)jobDateChange:(id)sender;
-(void)jobTimeChange:(id)sender;
-(void)resetInputFields;
-(BOOL)checkForFieldErrors;
-(IBAction) btnCreateJob;
-(void)showFirstResponder:(NSNotification*)aNotification;
-(void)keyboardWasShown:(NSNotification*)aNotification;
-(void) keyboardWasHidden:(NSNotification *) notification;

@end
