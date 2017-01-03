//
//  CreateJobViewController.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 15/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "CreateJobViewController.h"


#import "MMAsyncActivityManagementImpl.h"
#import "MMCreateJobActivityResult.h"
#import "MMCreateJobAsyncActivity.h"
#import "MMJobItem.h"
#import "AusPostUtil.h"
#import "JobDateGenerator.h"
#import "JobCategoryListDelegate.h"
#import "AffiliateCategoryListDelegate.h"
#import "SpecialConditionsListDelegate.h"
#import "PickupDeliveryTimeRangeListDelegate.h"
#import "ListSelectorViewController.h"
#import "UrgentTransportView.h"
#import "FixedTransportViewContainer.h"
#import "LocationSearchViewController.h"
#import "JobLocationDelegate.h"
#import "MMPair.h"
#import "MMConfig.h"

NSInteger const DESCRIPTION_MAX_LENGTH = 255;
NSInteger const DIMENSION_MAX_LENGTH = 5;
NSInteger const WEIGHT_MAX_LENGTH = 6;

@interface CreateJobViewController (Privates)

-(void) handleAffiliateIDView;
-(CGFloat) removeAffiliateIDView;
-(CGFloat) removeExistingTransportView;
-(NSInteger) calculateYOffset:(UIView *)view;
-(NSInteger) getNavBarHeight;

@end

@implementation CreateJobViewController

@synthesize specialConditions;

@synthesize scrollView, viewToScroll;
@synthesize jobCategoryTableView;
@synthesize inptJobCategory, jobCategoryPicker;
@synthesize affiliateCategoryTableView;
@synthesize inptAffiliateCategory;
@synthesize affiliateCategoryPicker;
@synthesize inptAffiliateNumber;
@synthesize specialConditionsTableView;
@synthesize inptSpecialConditions;
@synthesize fromAddressTableView;
@synthesize destinationAddressTableView;
@synthesize weightUnitsPicker;

@synthesize dimensionsUnitsPicker;
@synthesize dimensionUnitsTableView;
@synthesize inptDimensionUnits;

@synthesize inptDescription;
@synthesize inptDimensionLength;
@synthesize inptDimensionWidth;
@synthesize inptDimensionHeight;

@synthesize keyboardToolbar;

@synthesize lblAffiliateCategoryNote, lblAffiliateNumberNote, lblJobCategoryNote,
            lblDestinationAddressNote, lblDescriptionNote, lblDimensionsNote, lblFromAddressNote,
            lblTimeFrameNote, lblWeightNote;

@synthesize btnDone;

@synthesize  inptFromAddress, inptDestinationAddress;

@synthesize activityManagement;

@synthesize inptWeightUnits;
@synthesize weightUnitsTableView;
@synthesize inptWeight;

@synthesize urgencyControl;

@synthesize urgentTransportView;
@synthesize fixedTransportView;
@synthesize belowTransportView;
@synthesize affiliateIDView;
@synthesize belowAffiliateIDView;

@synthesize pickupLocation;
@synthesize deliveryLocation;

-(IBAction)backgroundTouched:(id)sender
{
    [self.keyboardToolbar resignKeyboard:nil];
}

/**
*   Resets notification text back to an asterics
**/
-(void) clearFieldErrors{
    lblAffiliateCategoryNote.text = @"*";
    lblAffiliateNumberNote.text = @"*";
    lblJobCategoryNote.text = @"*";
    lblDescriptionNote.text = @"*";
    lblWeightNote.text = @"*";
    lblDimensionsNote.text = @"*";
    lblFromAddressNote.text = @"*";
    lblDestinationAddressNote.text = @"*";    
    lblTimeFrameNote.text = @"*";
    
    [fixedTransportView clearFieldErrors];
}

/**
*   Sets fields back to their default values
**/
-(void) resetInputFields{
    [self.affiliateCategoryPicker selectRow:0 inComponent:0 animated:FALSE];
    [jobCategoryPicker selectRow:0 inComponent:0 animated:FALSE];
    
    //Reset textfields
    inptJobCategory.text = @"";
    inptAffiliateCategory.text = @"";
    inptAffiliateNumber.text = @"";
    inptDescription.text = @"";
    inptWeight.text = @"";    
    inptDimensionLength.text = @"";
    inptDimensionWidth.text = @"";
    inptDimensionHeight.text = @"";
    
    pickupLocation = nil;
    deliveryLocation = nil;
    jobCategory = nil;
    
    [self pickerView:affiliateCategoryPicker didSelectRow:0 inComponent:0];
    specialConditions = nil;
    inptDimensionUnits.text = [[[restDeligate getConfig] getDimensionUnits] objectAtIndex:0];
    inptWeightUnits.text = [[[restDeligate getConfig] getWeightUnits] objectAtIndex:0];
    
    [fromAddressTableView reloadData];
    [destinationAddressTableView reloadData];
    [jobCategoryTableView reloadData];
    [affiliateCategoryTableView reloadData];
    [dimensionUnitsTableView reloadData];
    [weightUnitsTableView reloadData];
    [specialConditionsTableView reloadData];
    
    pickupLocation = nil;
    deliveryLocation = nil;
    
    [self handleAffiliateIDView];

    [self.urgentTransportView resetInputFields];
    [self.fixedTransportView resetInputFields];
    
    urgencyControl.selectedSegmentIndex = 0;
    [self urgencyChanged:urgencyControl];
    
    //Scroll to top
    [scrollView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:TRUE];
    
}

/**
*   Validates field data and displays notifications where applicable ie. Required field
**/
-(BOOL) checkForFieldErrors{
    
    //Resets display of field notifications
    [self clearFieldErrors];
    
    bool fieldError = false;
    
    //The input methods (keyboards, pickers .etc)ensure the data is of the correct format
    //therefore it is only necessary to check that a value has been entered
    if ([inptAffiliateCategory.text length] == 0) {
        lblAffiliateCategoryNote.text = @"* Required field";
        fieldError = true;
    }

    //Only check the affiliate number if the affiliate category is not sent to 'None'
    if (affiliateCategory != nil &&
        [[[restDeligate getConfig] getAffiliateCategories] indexOfObject:affiliateCategory] != 0 &&
        [inptAffiliateNumber.text length] == 0) {
        lblAffiliateNumberNote.text = @"* Required field";
        fieldError = true;
    }
    
    if ([inptJobCategory.text length] == 0) {
        lblJobCategoryNote.text = @"* Required field";
        fieldError = true;
    }
    
    if ([inptDescription.text isEqualToString:@""]) {
        lblDescriptionNote.text = @"* Required field";
        fieldError = true;
    }
    
    //Validate object weight
    if ([inptWeight.text isEqualToString:@""]){
        lblWeightNote.text = @"* Required field";
        fieldError = true;
    }
    
    //Validate dimensions
    if (
        ([inptDimensionWidth.text isEqualToString:@""])||
        ([inptDimensionHeight.text isEqualToString:@""])||
        ([inptDimensionLength.text isEqualToString:@""])
        )
    {
        lblDimensionsNote.text = @"* Required fields";
        fieldError = true;
    }
    
    if(pickupLocation == nil || [pickupLocation isEqualToString:@""]) {
        lblFromAddressNote.text = @"* Required field";
        fieldError = true;
    }
    
    if(deliveryLocation == nil || [deliveryLocation isEqualToString:@""]) {
        lblDestinationAddressNote.text = @"* Required field";
        fieldError = true;
    }
    
    if(urgencyControl.selectedSegmentIndex == 2 && [fixedTransportView validateRequiredFields]) {
        fieldError = true;
    }
        
    if (fieldError==true){
        //Display error message
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"One or more fields have not been entered correctly." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        return fieldError;
    }
    
    if(urgencyControl.selectedSegmentIndex == 2 && [fixedTransportView validateCrossReferences]) {
        fieldError = true;
    }
 
    return fieldError;
}



- (void) updateJobPost:(MMCreateJobActivityResult*) confirmationResultDetail {
    [loadingDialog removeView];
    postingJob = YES;
    
    [restDeligate setShouldUpdateRecentJobs:true];
    [restDeligate setShouldUpdateMyJobs:true];
    
    [self resetInputFields];
    
    if (confirmationResultDetail.jobCreatedStatus == MMAsyncCreateJobStatusSuccessNoCreditCard) {
        shouldExit = YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Done!" message:@"Your delivery was posted successfully.\nNote: to accept bids you must register a credit card at meemeep.com." delegate:self cancelButtonTitle:@"I understand" otherButtonTitles:nil];
        [alertView show];
    } else {
        [restDeligate showTabIndex:1 andPopViewToRoot:TRUE];
    }
}

#pragma mark - UIAlertViewDelegate methods

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (shouldExit) {
        [restDeligate showTabIndex:1 andPopViewToRoot:YES];
    }
}

#pragma mark - 

- (void) showAlertOnFailureToConnect: (NSString*) message{
    [loadingDialog removeView];
    
    postingJob = false;
    [restDeligate setShouldUpdateRecentJobs:true];
    [restDeligate setShouldUpdateMyJobs:true];
    shouldExit = NO;

    NSString* errorMessage = [NSString stringWithFormat:@"Could not create delivery. %@", message];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}



- (void) showAlertOnFailureToConfirm: (NSString*) message{
    [loadingDialog removeView];
    
    postingJob = false;
    [restDeligate setShouldUpdateRecentJobs:true];
    [restDeligate setShouldUpdateMyJobs:true];
    [self resetInputFields];  
    
    shouldExit = NO;

    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"We were unable to contact MeeMeep. Please check your connection settings, or try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
}

- (void) onAsyncActivityFailure:(NSError *)error {
    [self performSelectorOnMainThread:@selector(showAlertOnFailureToConnect:) withObject:[error localizedDescription] waitUntilDone:NO];
}

- (void) onAsyncActivityCompletion:(id<MMAsyncActivityResult>)result {    
    if (result != nil) {
        if ([result isKindOfClass:[MMCreateJobActivityResult class]]) {
            MMCreateJobActivityResult *postResult = (MMCreateJobActivityResult *) result;
            
            if (postResult.jobCreatedStatus == MMAsyncCreateJobStatusSuccess || postResult.jobCreatedStatus == MMAsyncCreateJobStatusSuccessNoCreditCard) {
                [self performSelectorOnMainThread:@selector(updateJobPost:) withObject:postResult waitUntilDone:NO];
            } else {
                [self performSelectorOnMainThread:@selector(showAlertOnFailureToConfirm:) withObject:postResult waitUntilDone:NO];
            }
        }
    }
}





/**
 *  Performs validation checks then calls create a job api's
 **/
-(IBAction) btnCreateJob{
    if ([self checkForFieldErrors] == false){//No Field errors found
        if(![restDeligate isLoggedIn]) {
            [restDeligate showLoginDialog:2];
            submitJobOnAppear = TRUE;
            return;
        }

        submitJobOnAppear = FALSE;
        postingJob = true;
        
        loadingDialog = [[LoadingView alloc] loadingViewInView:self.view];
        [loadingDialog.loadingLabel setText:@"Saving"];
        
        MMJobDetail* job = [[MMJobDetail alloc] init];
        
        job.fromSuburb = pickupLocation;
        job.toSuburb = deliveryLocation;
       /*
        [AusPostUtil getPostCodeFromLocation:pickupLocation];
        [AusPostUtil getPostCodeFromLocation:deliveryLocation];
        */
        job.affiliateID = [GUICommon formatForNumber:affiliateCategory.first];
        job.affiliateJobID = [GUICommon formatForNumber:inptAffiliateNumber.text];
                
        job.jobCategory = [NSNumber numberWithInteger:[jobCategory.first integerValue]];
        
        MMJobItem* jobItem = [[MMJobItem alloc] init];
        jobItem.height = [GUICommon formatForNumber:inptDimensionHeight.text];
        jobItem.width = [GUICommon formatForNumber:inptDimensionWidth.text];
        jobItem.length = [GUICommon formatForNumber:inptDimensionLength.text];
        jobItem.dimensionsUnit = inptDimensionUnits.text;
        
        jobItem.weight = [GUICommon formatForNumber:inptWeight.text];
        jobItem.description = inptDescription.text;
        jobItem.weightUnit = inptWeightUnits.text;
        
        [job addJobItem:jobItem];
        
        job.auctionWon = self.btnYetToWin.checked;
        
        NSMutableArray* specialConsiderationsArray = [[NSMutableArray alloc] initWithCapacity:[self.specialConditions count]];
        for(SpecialConditionListItem* consideration in self.specialConditions) {
            [specialConsiderationsArray addObject:consideration.description];
        }

        //Flexible
        
        NSInteger index = urgencyControl.selectedSegmentIndex;
        job.dateOptionSelect = [[[restDeligate getConfig] getFlexibilityTags] objectAtIndex:index];
        if(index == 1) {
            [urgentTransportView populateJob:job];
        //Fixed
        } else if(index == 2) {
            [fixedTransportView populateJob:job];
        }
        
        job.specialConsiderations = specialConsiderationsArray;
        
        //Start asynchronous activity
        MMCreateJobAsyncActivity* activity = [[MMCreateJobAsyncActivity alloc] initWithActivityDelegate:self restDelegate:restDeligate jobToCreate:job];
        [self.activityManagement dispatchMMAsyncActivity:activity];
    }

}
     



- (void) registerForKeyboardNotifications {

    DLog(@"Registering for keyboard notifications...");
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

    [notificationCenter addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) deRegisterKeyboardNotifications {
    
    DLog(@"deRegistering for keyboard notifications...");
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

    [notificationCenter removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [notificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void) keyboardWasShown:(NSNotification *) notification {
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0,
                                                  kbSize.height - [self getNavBarHeight],
                                                  0.0);
    
    CGRect visibleRect;
    visibleRect.origin = scrollView.contentOffset;
    visibleRect.size = scrollView.bounds.size;
    visibleRect.size.height -= contentInsets.bottom;
    
    CGRect activeRect = CGRectMake(0.0f, [self calculateYOffset:activeTextField],
                                   activeTextField.frame.size.width,
                                   activeTextField.frame.size.height);
    
    if(!CGRectContainsRect(visibleRect, activeRect)) {
        CGPoint scrollPoint = CGPointMake(0.0,
                                          activeRect.origin.y - (visibleRect.size.height / 2));
        [scrollView setContentOffset:scrollPoint animated:YES];
    }

    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void) keyboardWasHidden:(NSNotification *) notification {
    DLog(@"Keyboard was hidden!");
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

-(id) initWithCommandObject: (id <GUIRestDeligate>) commandObj {
    self = [super init];
    if (self) {
        restDeligate = commandObj;
        self->activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
        submitJobOnAppear = FALSE;

        return self;
    }
    return nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         submitJobOnAppear = FALSE;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}




#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [scrollView addSubview:viewToScroll];
    [scrollView setContentSize:viewToScroll.frame.size];
    
    //Style done button
    NSArray* normalColors = [GUICommon MeeMeepActionButtonGradient];
    NSArray* highlightedColors =  [GUICommon MeeMeepActionButtonGradientHighlighted];
    [btnDone setGradientColor:highlightedColors forState:UIControlStateHighlighted];
    [btnDone setGradientColor:normalColors forState:UIControlStateNormal]; 
    
    //Initialises keyboard toolbar (input accessory that provides Previous,Next,Done functionality)
    keyboardToolbar = [[KeyboardToolBar alloc] initWithInputFields:self.view inputs: [[NSArray alloc] initWithObjects:
                                                                               inptFromAddress,
                                                                               inptDestinationAddress,
                                                                               inptAffiliateCategory,
                                                                               inptAffiliateNumber,
                                                                               inptJobCategory,
                                                                               inptDescription,
                                                                               inptDimensionLength,
                                                                               inptDimensionWidth,
                                                                               inptDimensionHeight,
                                                                               inptDimensionUnits,
                                                                               inptWeight,
                                                                               inptWeightUnits,
                                                                               inptSpecialConditions,
                                                                               nil]];
    
    //Setup keyboard and input accessory (keyboardtoolbar) for various controls
    //
    inptAffiliateCategory.inputAccessoryView = keyboardToolbar;
    inptAffiliateCategory.inputView = self.affiliateCategoryPicker;
    
    inptJobCategory.inputAccessoryView = keyboardToolbar;
    inptJobCategory.inputView = self.jobCategoryPicker;
  
    
    inptSpecialConditions.inputAccessoryView = keyboardToolbar;
    
    inptAffiliateNumber.keyboardType = UIKeyboardTypeNumberPad;
    inptAffiliateNumber.inputAccessoryView = keyboardToolbar;
    
    inptDescription.keyboardType = UIKeyboardTypeDefault;
    inptDescription.inputAccessoryView = keyboardToolbar;
    
    inptWeight.keyboardType = UIKeyboardTypeNumberPad;
    inptWeight.inputAccessoryView = keyboardToolbar;
    
    inptWeightUnits.inputAccessoryView = keyboardToolbar;
    inptWeightUnits.inputView = self.weightUnitsPicker;
    
    inptDimensionLength.keyboardType = UIKeyboardTypeNumberPad;
    inptDimensionLength.inputAccessoryView = keyboardToolbar;
    
    inptDimensionWidth.keyboardType = UIKeyboardTypeNumberPad;
    inptDimensionWidth.inputAccessoryView = keyboardToolbar;
    
    inptDimensionHeight.keyboardType = UIKeyboardTypeNumberPad;
    inptDimensionHeight.inputAccessoryView = keyboardToolbar;
    
    inptDimensionUnits.inputAccessoryView = keyboardToolbar;
    inptDimensionUnits.inputView = self.dimensionsUnitsPicker;
    
    inptFromAddress.inputAccessoryView = keyboardToolbar;     
    inptDestinationAddress.inputAccessoryView = keyboardToolbar;

    [self.view addSubview:scrollView];  
    
    //Record original heights of views for resizing later (keyboard related)
    originalViewFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    originalScrollFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
     
    
    //Setup a border around the text view
    self.inptDescription.clipsToBounds = YES;
    self.inptDescription.layer.borderWidth = 1.0f;
    self.inptDescription.layer.cornerRadius = 5;
    [self.inptDescription.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    
    //Handle keyboard notifications
    //[self registerForKeyboardNotifications];
    
    //Set fields to default values
    [self resetInputFields];
    
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //If we're meant to be sumitting this means tha the use has just logged in
    if(submitJobOnAppear) {
        //Ensure that the login actually worked.
        if([restDeligate isLoggedIn]) {
            [self btnCreateJob];
        } else {
            submitJobOnAppear = FALSE;
        }
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self deRegisterKeyboardNotifications];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [jobCategoryTableView reloadData];
    [affiliateCategoryTableView reloadData];
    [fromAddressTableView reloadData];
    [destinationAddressTableView reloadData];
    [dimensionUnitsTableView reloadData];
    [weightUnitsTableView reloadData];
    [specialConditionsTableView reloadData];
    
    [self registerForKeyboardNotifications];
    
    shouldExit = NO;
}

/**
 * Handle the visibility of the Affiliate ID View based on the selection of an affiliate category
 */
-(void) handleAffiliateIDView {
    CGFloat changeContentHeightBy = 0.0f;
    if([affiliateCategory isEqual:[[[restDeligate getConfig] getAffiliateCategories] objectAtIndex:0]]) {
        changeContentHeightBy = [self removeAffiliateIDView];
        [keyboardToolbar removeInput:inptAffiliateNumber];
    } else {
        if(affiliateIDView.superview == nil) {
            [self.viewToScroll addSubview:affiliateIDView];
            changeContentHeightBy = affiliateIDView.frame.size.height;
            [keyboardToolbar insertInput:inptAffiliateNumber after:inptAffiliateCategory];
        }
    }
    
    CGRect frame = self.viewToScroll.frame;
    frame.size.height += changeContentHeightBy;
    self.viewToScroll.frame = frame;
    
    [self.scrollView setContentSize:self.viewToScroll.frame.size];
    
    CGRect bottomFrame = self.belowAffiliateIDView.frame;
    bottomFrame.origin.y += changeContentHeightBy;
    self.belowAffiliateIDView.frame = bottomFrame;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 31;     
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditableTableViewCell* myCell = [GUICommon getEditableTableViewCell:tableView];
    [myCell.textField setUserInteractionEnabled:false];
        
    //Sets disclosure icon to down arrow
    myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSString* text = nil;
    NSString* placeHolder = nil;
    if(tableView == jobCategoryTableView) {
        text = self.inptJobCategory.text;
        placeHolder = self.inptJobCategory.placeholder;
    } else if(tableView == affiliateCategoryTableView) {
        text = self.inptAffiliateCategory.text;
        placeHolder = self.inptAffiliateCategory.placeholder;
    } else if(tableView == dimensionUnitsTableView) {
        text = self.inptDimensionUnits.text;
    } else if(tableView == weightUnitsTableView) {
        text = self.inptWeightUnits.text;
    } else if(tableView == specialConditionsTableView) {
        if([specialConditions count] == 0) {
            text = @"None";
        } else {
            NSMutableString* conditions = [[NSMutableString alloc] init];
            int i = 0;
            for(ListSelectorItem* item in specialConditions) {
                ++i;
                [conditions appendString:item.description];
            
                if(i < [specialConditions count]) {
                    [conditions appendString:@","];
                }
            }
            
            text = conditions;
        }
    } else {
        if (tableView == fromAddressTableView) {
            text = pickupLocation;
            placeHolder = inptFromAddress.placeholder;
        } else if (tableView == destinationAddressTableView) {
            text = deliveryLocation;
            placeHolder = inptDestinationAddress.placeholder;
        }
    }

    myCell.textField.text = text;
    myCell.textField.placeholder = placeHolder;
    return myCell;
}

#pragma mark - Table view delegate


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [keyboardToolbar resignKeyboard:nil];
    
    //Forces dummy objects to become first responder (scrolls tables into view and allows keyboard input)
    if (tableView==jobCategoryTableView) {
        [self.inptJobCategory becomeFirstResponder];
        return;
    } else if (tableView==affiliateCategoryTableView) {
        [self.inptAffiliateCategory becomeFirstResponder];
        return;
    } else if (tableView==dimensionUnitsTableView) {
        [self.inptDimensionUnits becomeFirstResponder];
        return;
    } else if (tableView==weightUnitsTableView) {
        [self.inptWeightUnits becomeFirstResponder];
        return;
    } else if (tableView==specialConditionsTableView) {
        SpecialConditionsListDelegate* delegate = [[SpecialConditionsListDelegate alloc] initWithController:self data:[[restDeligate getConfig] getSpecialConditions]];
        ListSelectorViewController* controller = [[ListSelectorViewController alloc] initWithDelegate:delegate];
            if(self.specialConditions != nil) {
                [controller initialiseSelectedItems:self.specialConditions];
            }
            controller.modalTransitionStyle =  UIModalTransitionStyleFlipHorizontal;
            [self.navigationController presentModalViewController:controller animated:true];
            return;
        }
    
    LocationSearchViewController* newView;
    
    BOOL pickup;
    
    //Sends user to Address entry ViewController (modal) - also passes relevent object to be populated with data
    //
    if (tableView==fromAddressTableView){
        newView = [[LocationSearchViewController alloc] initWithSuburb:pickupLocation];
        pickup = TRUE;
    } else
    if (tableView==destinationAddressTableView){
        newView = [[LocationSearchViewController alloc] initWithSuburb:deliveryLocation];
        pickup = FALSE;
    }
    if (newView!=nil){
        newView.delegate = [[JobLocationDelegate alloc] initWithViewController:self pickup:pickup];
        newView.modalTransitionStyle =  UIModalTransitionStyleFlipHorizontal;
        [self.navigationController presentModalViewController:newView animated:true];
        //Update Address entry viewcontroller title to reflect callout (from/destination)
        //[newView.navTitleItem setTitle:caption];
    }
    
}

#pragma mark - Text field delegate


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {  
    
    //Imposes various constraints on textfields
    if ((textField==inptFromAddress)||
        (textField==inptDestinationAddress) ||
        (textField==inptSpecialConditions)) {
        return false;
    } else if(textField == inptDescription) {
        return !([textField.text length] >= DESCRIPTION_MAX_LENGTH && [string length] > range.length);
    } else if(textField == inptDimensionLength ||
              textField == inptDimensionWidth ||
              textField == inptDimensionHeight) {
        return !([textField.text length] >= DIMENSION_MAX_LENGTH && [string length] > range.length);
    } else if(textField == inptWeight) {
        return !([textField.text length] >= WEIGHT_MAX_LENGTH && [string length] > range.length);
    } else {
        return true;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == inptSpecialConditions ||
       textField == inptFromAddress ||
       textField == inptDestinationAddress) {
        CGRect areaToView = CGRectMake(
                                       textField.frame.origin.x,
                                       [self calculateYOffset:textField],                                    
                                       textField.frame.size.width,
                                       textField.frame.size.height + [self getNavBarHeight]);
        [scrollView scrollRectToVisible:areaToView animated:TRUE];
        return NO;
    } else if(textField == inptJobCategory && [inptJobCategory.text length] == 0) {
        [self pickerView:jobCategoryPicker didSelectRow:0 inComponent:0];
    }
    
    activeTextField = textField;
    return YES;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{return true;}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if(textField == activeTextField) {
        activeTextField = nil;
    }
    
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{return true;}
- (void)textFieldDidBeginEditing:(UITextField *)textField{}
- (void)textFieldDidEndEditing:(UITextField *)textField{}



#pragma mark - Pickers / Spinners


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
    numberOfRowsInComponent:(NSInteger)component {
    if(pickerView == self.weightUnitsPicker) {
        return [[[restDeligate getConfig] getWeightUnits] count];
    } else if(pickerView == self.dimensionsUnitsPicker) {
        return [[[restDeligate getConfig] getDimensionUnits] count];
    } else if(pickerView == self.affiliateCategoryPicker) {
        return [[[restDeligate getConfig] getAffiliateCategories] count];
    } else if(pickerView == self.jobCategoryPicker) {
        return [[[restDeligate getConfig] getJobCategories] count];
    } else {
        return 0;
    }
}


- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(thePickerView == self.weightUnitsPicker) {
        return [[[restDeligate getConfig] getWeightUnits] objectAtIndex:row];
    } else if(thePickerView == self.dimensionsUnitsPicker) {
        return [[[restDeligate getConfig] getDimensionUnits] objectAtIndex:row];
    } else if(thePickerView == self.affiliateCategoryPicker) {
        MMPair* pair = [[[restDeligate getConfig] getAffiliateCategories] objectAtIndex:row];
        return pair.second;
    } else if(thePickerView == self.jobCategoryPicker) {
        MMPair* pair = [[[restDeligate getConfig] getJobCategories] objectAtIndex:row];
        return pair.second;
    } else {
        return nil;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if(pickerView == self.weightUnitsPicker) {
        self.inptWeightUnits.text = [[[restDeligate getConfig] getWeightUnits] objectAtIndex:row];
        [self.weightUnitsTableView reloadData];
    } else if(pickerView == self.dimensionsUnitsPicker) {
        self.inptDimensionUnits.text = [[[restDeligate getConfig] getDimensionUnits] objectAtIndex:row];
        [self.dimensionUnitsTableView reloadData];
    } else if(pickerView == self.affiliateCategoryPicker) {
        affiliateCategory = [[[restDeligate getConfig] getAffiliateCategories] objectAtIndex:row];
        self.inptAffiliateCategory.text = affiliateCategory.second;
        [self.affiliateCategoryTableView reloadData];
        [self handleAffiliateIDView];
    } else if(pickerView == self.jobCategoryPicker) {
        jobCategory = [[[restDeligate getConfig] getJobCategories] objectAtIndex:row];
        self.inptJobCategory.text = jobCategory.second;
        [self.jobCategoryTableView reloadData];
    }
    
}

-(IBAction)urgencyChanged:(id)sender {
    if(sender == urgencyControl) {
        CGFloat changeContentHeightBy = 0.0f;
        if(urgencyControl.selectedSegmentIndex == 0) {
            changeContentHeightBy = [self removeExistingTransportView];
        } else if(urgencyControl.selectedSegmentIndex == 1) {
            changeContentHeightBy = [self removeExistingTransportView];
            
            CGRect frame = CGRectMake(0, 0,
                                       self.view.frame.size.width,
                                       130);
            if(self.urgentTransportView == nil) {
                self.urgentTransportView = [[UrgentTransportView alloc] initWithFrameAndContainer:frame
                                                                                   viewController:self
                                            restDelegate:restDeligate];
            }
        
            CGRect bottomFrame = self.belowTransportView.frame;
            self.urgentTransportView.frame = CGRectMake(bottomFrame.origin.x, bottomFrame.origin.y + changeContentHeightBy,
                                                        urgentTransportView.frame.size.width,
                                                        urgentTransportView.frame.size.height);
                
            [self.belowAffiliateIDView addSubview:urgentTransportView];
            changeContentHeightBy += self.urgentTransportView.frame.size.height;
        } else {
            changeContentHeightBy = [self removeExistingTransportView];
            
            CGRect frame = CGRectMake(0, 0,
                                      self.view.frame.size.width,
                                      130);
            if(self.fixedTransportView == nil) {
                self.fixedTransportView = [[FixedTransportViewContainer alloc] initWithFrameAndContainer:frame container:self restDelegate:restDeligate];
            }
            
            CGRect bottomFrame = self.belowTransportView.frame;
            self.fixedTransportView.frame = CGRectMake(fixedTransportView.frame.origin.x,
                                                       bottomFrame.origin.y + changeContentHeightBy,
                                                       fixedTransportView.frame.size.width,
                                                       fixedTransportView.frame.size.height);
            
            [self.belowAffiliateIDView addSubview:fixedTransportView];
            changeContentHeightBy += self.fixedTransportView.frame.size.height;
        }

        CGRect bottomFrame = self.belowTransportView.frame;
        self.belowTransportView.frame = CGRectMake(bottomFrame.origin.x,
                                                   bottomFrame.origin.y + changeContentHeightBy,
                                                   bottomFrame.size.width, bottomFrame.size.height);
        
        CGSize size = self.scrollView.contentSize;
        size.height += changeContentHeightBy;
        [self.scrollView setContentSize:size];

        CGRect frame = self.viewToScroll.frame;        
        frame.size.height += changeContentHeightBy;
        self.viewToScroll.frame = frame;
        
        frame = self.belowAffiliateIDView.frame;
        frame.size.height += changeContentHeightBy;
        self.belowAffiliateIDView.frame = frame;        
    }
}

-(CGFloat) removeExistingTransportView {
    UIView* currentView = nil;
    if(self.urgentTransportView.superview != nil) {
        currentView = self.urgentTransportView;
    } else if(self.fixedTransportView.superview != nil) {
        currentView = self.fixedTransportView;
    }
    
    if(currentView != nil) {
        [currentView removeFromSuperview];
        return -currentView.frame.size.height;
    }
    
    return 0.0f;
}

- (void) resizeBelowTransportView:(CGFloat) heightDiff {
    CGFloat changeContentHeightBy = heightDiff;
    CGSize size = self.scrollView.contentSize;
    size.height += changeContentHeightBy;
    [self.scrollView setContentSize:size];
        
    CGRect bottomFrame = self.belowTransportView.frame;
    bottomFrame.origin.y += changeContentHeightBy;
    self.belowTransportView.frame = bottomFrame;
    
    CGRect frame = self.viewToScroll.frame;
    frame.size.height += changeContentHeightBy;
    self.viewToScroll.frame = frame;
    
    frame = self.belowAffiliateIDView.frame;
    frame.size.height += changeContentHeightBy;
    self.belowAffiliateIDView.frame = frame;
}

-(CGFloat) removeAffiliateIDView {
    if(affiliateIDView.superview != nil) {
        [affiliateIDView removeFromSuperview];
        return -affiliateIDView.frame.size.height;
    }
    
    return 0.0f;
}

-(NSInteger) calculateYOffset:(UIView *)view {
    UIView* containerView = view;
    NSInteger yLocation = view.frame.origin.y;
    
    while (containerView!=self.viewToScroll){
        containerView = [containerView superview];
        if(containerView == nil) {
            break;
        }
        
        yLocation += containerView.frame.origin.y;
    }
    
    return yLocation;
}

-(NSInteger) getNavBarHeight {
    return self.navigationController.navigationBar.frame.size.height;
}

@end
