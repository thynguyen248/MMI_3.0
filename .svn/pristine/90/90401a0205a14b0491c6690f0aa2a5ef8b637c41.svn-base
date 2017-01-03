//
//  FromAddressViewController.h
//  MeeMeepMobile
//
//  Created by John Rowland on 15/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "MMJobAddress.h"
#import "GUICommon.h"

#import "KeyboardToolBar.h"


#import "GMMapAnnotationsClientImpl.h"

@interface FromAddressViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource ,UITextFieldDelegate, UITableViewDelegate>{
    
    MMJobAddress* addressObject;
    UIPickerView* statePicker;
    NSMutableArray* statesArray;
    
    NSDate* jobDate;
    
    NSMutableArray* dateRange;
    
    NSDate* jobTime;
    
    KeyboardToolBar* keyboardToolbar;
    
    CGRect originalViewFrame;
    
    UIScrollView* scroller;
    
    UIView* viewToScroll;
    
    UITableView* tableViewDDState;
    
    
    /////
    /////
    /////
    
    id<GMMapAnnotationsClient> annotationsClient;
    
    NSArray* mapAnnotations;
}

@property (nonatomic,strong) KeyboardToolBar* keyboardToolbar;

@property (nonatomic,strong) IBOutlet UITextField* inptStreetNumber;
@property (nonatomic,strong) IBOutlet UITextField* inptStreetName;
@property (nonatomic,strong) IBOutlet UITextField* inptSuburb;
@property (nonatomic,strong) IBOutlet UITextField* inptState;
@property (nonatomic,strong) IBOutlet UITextField* inptPostCode;

@property (nonatomic,strong) IBOutlet UILabel* lblStreetNumberNote;
@property (nonatomic,strong) IBOutlet UILabel* lblStreetNameNote;
@property (nonatomic,strong) IBOutlet UILabel* lblSuburbNote;
@property (nonatomic,strong) IBOutlet UILabel* lblStateNote;
@property (nonatomic,strong) IBOutlet UILabel* lblPostCodeNote;

@property (nonatomic,strong) IBOutlet UITableView* tableViewDDState;

@property (nonatomic,strong) IBOutlet UIPickerView* statePicker;

@property (nonatomic, strong) IBOutlet UIButton* btnDone;



-(id) initWithAddress: (MMJobAddress*) address;
-(IBAction) btnDoneClicked;


- (void) registerForKeyboardNotifications;
- (void) keyboardWasHidden:(NSNotification *) notification;

@property (nonatomic,strong) IBOutlet UIView* viewToScroll;


-(BOOL) checkForFieldErrors;


@property (nonatomic,strong) IBOutlet UINavigationBar* navBar;

@property (nonatomic,strong) IBOutlet UINavigationItem * navBarTitleItem;


-(IBAction) btnBackClicked;






////
////
////

@property (nonatomic,strong) IBOutlet UISearchBar* searchBar;
@property (nonatomic,strong) IBOutlet UITableView* searchResultsTable;

-(IBAction) btnSearchClick:(id)sender;






@end
