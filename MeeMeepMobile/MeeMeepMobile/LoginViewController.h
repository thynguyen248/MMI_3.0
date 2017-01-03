//
//  LoginViewController.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 29/02/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
#import "EditableKeyValueTableViewCell.h"

#import "GUIViewInterface.h"
#import "MMAsyncActivityDelegate.h"
#import "MMAsyncActivityManagement.h"

#import "LoadingView.h"

#import "GUICommon.h"


@interface LoginViewController : UIViewController <GUIViewInterface, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, MMAsyncActivityDelegate>{
    id<GUIRestDeligate> restDeligate;
    id<MMAsyncActivityManagement> activityManagement;
    
    UITextField *activeTextField;
    BOOL viewShiftedForKeyboard;
    NSTimeInterval keyboardSlideDuration;
    CGFloat keyboardShiftAmount;
    NSInteger completionIndex;
    
    LoadingView* loadingDialog;
    
    UINavigationController* navCont;
    
    UIBarButtonItem* cancelButton;
    
    BOOL loginOnViewAppearing;
}

@property (strong, nonatomic) id<MMAsyncActivityManagement> activityManagement;


-(IBAction) btnForgotPasswordClick;

-(IBAction) btnRegisterClick;

-(IBAction) btnSignInClick;

-(IBAction) btnCancelClick;

-(IBAction) textFileReturn:(id)sender;

-(IBAction)backgroundTouched:(id)sender;

- (void) registerForKeyboardNotifications;
- (void) keyboardWasShown:(NSNotification *) notification;
- (void) keyboardWasHidden:(NSNotification *) notification;


@property (nonatomic,strong) IBOutlet UIView* logoView;

@property (nonatomic,strong) IBOutlet GradientButtonControl* btnSignIn;

@property (nonatomic,strong) IBOutlet GradientButtonControl* btnRegister;

@property (nonatomic,strong) IBOutlet UITableView* loginForm;


-(id) initWithTabIndex: (id <GUIRestDeligate>) commandObj tabIndex:(int) tabIndex;

-(void) populateLoginInfo:(NSString *) username password:(NSString *)password;
- (void) dismissMe;


@end
