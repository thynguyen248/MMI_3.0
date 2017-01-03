//
//  CompleteJobViewController.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 3/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GUICommon.h"
#import "GUIRestDeligate.h"

#import "RatingTableViewCell.h"
#import "LargeEditableKeyValueTableViewCell.h"

#import <QuartzCore/QuartzCore.h>
#import "LoadingView.h"
#import "KeyboardToolBar.h"

#import "GradientButtonControl.h"

#import "RatingTableViewCellDelegate.h"
#import "ListSelectorViewController.h"

typedef enum {
    SectionRating,
    SectionReason,
    SectionComments
} CompleteJobSection;

@class ListSelectorItem;
@class RatingReasonListItem;

@interface CompleteJobViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MMAsyncActivityDelegate, RatingTableViewCellDelegate>{
    id<GUIRestDeligate> restDeligate;
    MMJobDetail* thisJob;
    
    //Keyboard
    UITextField *activeTextField;
    BOOL viewShiftedForKeyboard;
    NSTimeInterval keyboardSlideDuration;
    CGFloat keyboardShiftAmount;
    NSInteger completionIndex;
    
    LoadingView* loadingDialog;
    id<MMAsyncActivityManagement> activityManagement;
    
    RatingTableViewCell* ratingCell;
    LargeEditableKeyValueTableViewCell* commentsCell;
    
    BOOL showReasons;
}

@property (nonatomic,strong) IBOutlet UITableView* reviewTableView;
@property (nonatomic,strong) IBOutlet GradientButtonControl* btnSubmit;
@property (nonatomic,strong) IBOutlet UILabel* lblRateUser;

@property (nonatomic,strong) NSSet* reasonsSet;

@property (nonatomic,strong) KeyboardToolBar* keyboardToolbar;

-(id) initWithJob:(id<GUIRestDeligate>)commandObj job:(MMJobDetail*)jobDetail;

-(IBAction)btnSubmitClick:(id)sender;
-(IBAction)btnCancelClick:(id)sender;


- (void) registerForKeyboardNotifications;

-(void) finishLoading:(id)ignore;

-(void) showAlertOnFailure:(NSString*)message;

-(IBAction)backgroundTouched:(id)sender;

@end
