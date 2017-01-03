//
//  CreateJobViewController.h
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
#import "MeeMeepCheckbox.h"

#import "GradientButtonControl.h"

@class ListSelectorItem;
@class JobCategoryListItem;
@class UrgentTransportView;
@class FixedTransportViewContainer;
@class MMPair;

@interface CreateJobViewController : UIViewController <GUIViewInterface ,UITableViewDataSource, UITableViewDelegate,  UIAlertViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIAlertViewDelegate, MMAsyncActivityDelegate, UIScrollViewDelegate>{    
    
    id<GUIRestDeligate> restDeligate;
    
    KeyboardToolBar* keyboardToolbar;
    
    UIView *activeTextField;
    BOOL viewShiftedForKeyboard;
    NSTimeInterval keyboardSlideDuration;
    CGFloat keyboardShiftAmount;
    NSInteger completionIndex;
    
    CGRect originalViewFrame;
    CGRect originalScrollFrame;
    
    BOOL postingJob;
    BOOL shouldExit;
    BOOL submitJobOnAppear;
    LoadingView* loadingDialog;    
    id<MMAsyncActivityManagement> activityManagement;
    
    UrgentTransportView* urgentTransportView;
    
    MMPair* jobCategory;
    MMPair* affiliateCategory;
}

@property (nonatomic, strong) NSSet* specialConditions;

@property (nonatomic,strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic,strong) IBOutlet UIView* viewToScroll;

@property (nonatomic,strong) IBOutlet UITableView* jobCategoryTableView;
@property (nonatomic,strong) IBOutlet UITableView* affiliateCategoryTableView;
@property (nonatomic,strong) IBOutlet UITableView* specialConditionsTableView;

@property (nonatomic,strong) IBOutlet UITableView* fromAddressTableView;
@property (nonatomic,strong) IBOutlet UITableView* destinationAddressTableView;

@property (nonatomic,strong) IBOutlet UITableView* dimensionUnitsTableView;
@property (nonatomic,strong) IBOutlet UITableView* weightUnitsTableView;

@property (nonatomic,strong) IBOutlet UITextField* inptDescription;

@property (nonatomic,strong) IBOutlet UITextField* inptDimensionLength;
@property (nonatomic,strong) IBOutlet UITextField* inptDimensionWidth;
@property (nonatomic,strong) IBOutlet UITextField* inptDimensionHeight;

@property (nonatomic,strong) KeyboardToolBar* keyboardToolbar;

@property (nonatomic,strong) IBOutlet UITextField* inptJobCategory;
@property (nonatomic,strong) IBOutlet UIPickerView* jobCategoryPicker;
@property (nonatomic,strong) IBOutlet UITextField* inptAffiliateCategory;
@property (nonatomic,strong) IBOutlet UIPickerView* affiliateCategoryPicker;
@property (nonatomic,strong) IBOutlet UITextField* inptAffiliateNumber;
@property (nonatomic,strong) IBOutlet UITextField* inptSpecialConditions;

@property (nonatomic,strong) IBOutlet UITextField* inptFromAddress;
@property (nonatomic,strong) IBOutlet UITextField* inptDestinationAddress;

@property (nonatomic,strong) IBOutlet UITextField* inptDimensionUnits;
@property (nonatomic,strong) IBOutlet UIPickerView* dimensionsUnitsPicker;

@property (nonatomic,strong) IBOutlet UITextField* inptWeightUnits;
@property (nonatomic,strong) IBOutlet UITextField* inptWeight;
@property (nonatomic,strong) IBOutlet UIPickerView* weightUnitsPicker;

@property (strong, nonatomic) IBOutlet MeeMeepCheckbox* btnYetToWin;

@property (nonatomic,strong) IBOutlet UILabel* lblAffiliateCategoryNote;
@property (nonatomic,strong) IBOutlet UILabel* lblAffiliateNumberNote;
@property (nonatomic,strong) IBOutlet UILabel* lblJobCategoryNote;
@property (nonatomic,strong) IBOutlet UILabel* lblDescriptionNote;
@property (nonatomic,strong) IBOutlet UILabel* lblWeightNote;
@property (nonatomic,strong) IBOutlet UILabel* lblDimensionsNote;
@property (nonatomic,strong) IBOutlet UILabel* lblFromAddressNote;
@property (nonatomic,strong) IBOutlet UILabel* lblDestinationAddressNote;
@property (nonatomic,strong) IBOutlet UILabel* lblTimeFrameNote;

@property (nonatomic,strong) IBOutlet UISegmentedControl* urgencyControl;

@property (nonatomic,strong) IBOutlet UIView* affiliateIDView;
@property (nonatomic,strong) IBOutlet UIView* belowAffiliateIDView;
@property (nonatomic,strong) IBOutlet UIView* belowTransportView;
@property (nonatomic,strong) IBOutlet UrgentTransportView* urgentTransportView;
@property (nonatomic,strong) IBOutlet FixedTransportViewContainer* fixedTransportView;

@property (nonatomic,strong) NSString* pickupLocation;
@property (nonatomic,strong) NSString* deliveryLocation;

@property (nonatomic, strong) IBOutlet GradientButtonControl* btnDone;
@property (nonatomic,strong) id<MMAsyncActivityManagement> activityManagement;
@property (nonatomic,strong) MMJobAddress* fromAddress;

-(IBAction) btnCreateJob;
-(void) deRegisterKeyboardNotifications;
-(void) registerForKeyboardNotifications;
-(void) keyboardWasHidden:(NSNotification *) notification;
-(void) resizeBelowTransportView:(CGFloat) heightDiff;
-(BOOL) checkForFieldErrors;

-(void) resetInputFields;

-(IBAction)backgroundTouched:(id)sender;
-(IBAction)urgencyChanged:(id)sender;

@end
