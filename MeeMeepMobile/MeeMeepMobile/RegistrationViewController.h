//
//  RegistrationViewController.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 7/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "GUICommon.h"
#import "StyledKeyValueTableViewCell.h"
#import "LoadingView.h"
#import "KeyboardToolBar.h"
#import "GUIRestDeligate.h"
#import "LoginViewController.h"

typedef enum
{
    SectionState_Default = 0,
    SectionState_Mover = 1,
    SectionState_ProMover = 2
} SectionState;

@interface RegistrationViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, MMAsyncActivityDelegate, UIAlertViewDelegate, UITextFieldDelegate, SegmentedTableHeaderDelegate>{
    
    NSMutableDictionary* footerCache;
    NSMutableDictionary* inputCells;    
    
    GradientButtonControl *validateButton;
    BOOL validateClicked;

    CGRect originalScrollFrame;
    
    KeyboardToolBar* keyboardToolbar;
    
    LoadingView* loadingDialog;
    id<MMAsyncActivityManagement> activityManagement;
    id<GUIRestDeligate> restDeligate;
        
    BOOL shouldPopOnCompletion;
    
    SectionState sectionState;
    UIView* activeTextField;
    
    LoginViewController* loginController;
    
    UITextField* msisdnTextField;
    
    NSMutableDictionary* inputMappings;
}

@property (nonatomic,strong) KeyboardToolBar* keyboardToolbar;

@property (nonatomic,strong) IBOutlet UITableView* regTableView;

@property (nonatomic,strong) IBOutlet GradientButtonControl* btnSubmit;

-(IBAction) btnSubmitClicked;
-(IBAction) btnTCNoteClicked:(id)sender;

-(id) initWithCommandObject:(id<GUIRestDeligate>)commandObj
            loginController:(LoginViewController *) loginController;

-(NSString*) getCellValueAtIndex:(NSInteger)index andSection:(NSInteger)section;

@end
