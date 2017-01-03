//
//  CreateBidßViewController.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 15/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "CreateBidViewController.h"


#import "MMAsyncActivityManagementImpl.h"
#import "MMCreateBidActivityResult.h"
#import "MMCreateBidAsyncActivity.h"
#import "MMPair.h"
#import "MeeMeepCheckbox.h"
#import "MMConfig.h"

#import "JobDateGenerator.h"

// private methods
@interface CreateBidViewController (hidden)
-(NSDate*) stripTimeFromDate:(NSDate*)date;
-(UIButton*) getDownArrowButton;
-(NSInteger) calculateYOffset:(UIView *)view;
-(void) showAlertOnFailure:(NSString*)message;
-(void) determineDateTimeText:(BOOL) pickup;
-(NSString *) formatDate:(NSDate*) date;
@end

@implementation CreateBidViewController

@synthesize lblPayAmountNote;

@synthesize scrollView, viewToScroll;

@synthesize tableViewDDVehicle;

@synthesize pickupDateTableView, pickupJobDatePicker, pickupJobTimePicker, inptPickupJobDate,
            pickupTimeTableView, inptPickupJobTime, lblPickupDateRange,
            lblPickupTimeFrameNote;
@synthesize deliveryDateTableView, deliveryJobDatePicker, deliveryJobTimePicker,
            inptDeliveryJobDate, deliveryTimeTableView, inptDeliveryJobTime,
            lblDeliveryDateRange, lblDeliveryTimeFrameNote;
@synthesize vehiclePicker;
@synthesize lblPayAmount;
@synthesize inptPayAmount;

@synthesize inptExpiryDate;
@synthesize expiryDateTableView;
@synthesize expiryDatePicker;
@synthesize lblExpiryNote;

@synthesize keyboardToolbar;

@synthesize inptVehicle;
@synthesize lblVehicle;
@synthesize lblVehicleNote;

@synthesize btnDone;

@synthesize moreOptions;

@synthesize activityManagement;

NSTimeInterval secondsPerDay = 24 * 60 * 60;


-(IBAction)backgroundTouched:(id)sender
{
    [self.keyboardToolbar resignKeyboard:nil];
}


/**
*   Resets notification text back to an asterics
**/
-(void) clearFieldErrors{
    lblVehicleNote.text = @"*";   
    lblPickupTimeFrameNote.text = @"*";
    lblDeliveryTimeFrameNote.text = @"*";    
    lblPayAmountNote.text = @"*";
    lblExpiryNote.text = @"*";
}


/**
*   Sets fields back to their default values
**/
-(void) resetInputFields{
    //Reset textfields
    inptVehicle.text = @"";
    // date range set from job
    inptPickupJobDate.text = @"";
    inptPickupJobTime.text = @"";
    inptDeliveryJobDate.text = @"";
    inptPayAmount.text = @"";
    inptExpiryDate.text=@"";
        
    //Refresh tables to reflect changes
    [pickupDateTableView reloadData];
    [deliveryDateTableView reloadData];
    [tableViewDDVehicle reloadData];
    [expiryDateTableView reloadData];
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
    
    //Validate Vehicle
    if ([inptVehicle.text isEqualToString:@""] || inptVehicle.text == nil){
        lblVehicleNote.text = @"* Required field";
        fieldError = true;
    }   
    
    //Validate job pickup / delivery time frame

    if ([inptPickupJobDate.text length] == 0) {
        lblPickupTimeFrameNote.text = @"* Required field";
        fieldError = true;
    }
    
    if([inptPickupJobTime.text length] == 0) {
        lblPickupTimeFrameNote.text = @"* Required field";
        fieldError = true;
    }
    
    if ([inptDeliveryJobDate.text length] == 0) {
        lblDeliveryTimeFrameNote.text = @"* Required field";
        fieldError = true;
    }
    
    if([inptDeliveryJobTime.text length] == 0) {
        lblDeliveryTimeFrameNote.text = @"* Required field";
        fieldError = true;
    }
    
    if ([inptExpiryDate.text length] == 0) {
        lblExpiryNote.text = @"* Required field";
        fieldError = true;
    }
    
    //Validate payment amount
    if ([inptPayAmount.text length] == 0){
        lblPayAmountNote.text = @"* Required field";
        fieldError = true;
    } else {
        NSNumber* paymentAmount = [[NSNumber alloc] init];
        paymentAmount = [GUICommon formatForNumber:inptPayAmount.text];    
        if ([paymentAmount doubleValue]<1){
            lblPayAmountNote.text = @"* Value too low";
            fieldError = true;
        } else lblPayAmountNote.text = @"*";
    }    
    
    if (fieldError==true){
        //Display error message
        [self showAlertOnFailure:@"One or more fields have not been entered correctly."];
        return TRUE;
    }
    
    NSComparisonResult dateComparison = [pickupJobDatePicker.date compare:deliveryJobDatePicker.date];
    if(dateComparison == NSOrderedSame) {
        //If the pickup and delivery date are the same, make sure that the delivery time is >= the pickup time
        NSInteger pickupTimeIndex = [pickupJobTimePicker selectedRowInComponent:0];
        NSInteger deliveryTimeIndex = [deliveryJobTimePicker selectedRowInComponent:0];

        //Don't compare if either of the indexes are '0' because this indicates 'Anytime'
        if(pickupTimeIndex != 0 && deliveryTimeIndex != 0 && deliveryTimeIndex < pickupTimeIndex) {
            [self showAlertOnFailure:@"Delivery time must be after the pickup time if pickup and delivery are on the same date"];
            return TRUE;
        }
    }
    
    if(dateComparison == NSOrderedDescending) {
        [self showAlertOnFailure:@"Delivery date must be after the pickup date"];
        return TRUE;
    }
    
    return FALSE;
}

#pragma mark - Async message response handling

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    DLog(@"Did acknowledge bid creation result...");
    
    [restDeligate setShouldUpdateJobDetail:TRUE];
    [restDeligate setShouldUpdateRecentJobs:true];
    [restDeligate setShouldUpdateMyJobs:true];
    
    if ([alertView.title isEqualToString:@"Done!"]) {
        [self resetInputFields];
        
        // only pop the view if we succeeded
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        DLog(@"This was an error, doing nothing!");
    }
}

- (void) updateBidPost:(MMCreateBidActivityResult*) confirmationResultDetail {
    [loadingDialog removeView];
    postingBid = false;    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Done!" message:@"Bid submitted!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

- (void) showAlertOnFailureToConnect: (NSString*) message{
    [loadingDialog removeView];

    NSString* errorMessage = [NSString stringWithFormat:@"Could not create bid. %@", message];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
    postingBid = false;
    [restDeligate setShouldUpdateJobDetail:TRUE];
    [restDeligate setShouldUpdateRecentJobs:true];
    [restDeligate setShouldUpdateMyJobs:true];
}



- (void) showAlertOnFailureToConfirm: (NSString*) message{
    [loadingDialog removeView];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"We were unable to contact MeeMeep. Please check your connection settings, or try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
    postingBid = false;
    [restDeligate setShouldUpdateJobDetail:TRUE];
    [restDeligate setShouldUpdateRecentJobs:true];
    [restDeligate setShouldUpdateMyJobs:true];
    [self resetInputFields];  
}

- (void) onAsyncActivityFailure:(NSError *)error {
    [self performSelectorOnMainThread:@selector(showAlertOnFailureToConnect:) withObject:[error localizedDescription] waitUntilDone:NO];
}

- (void) onAsyncActivityCompletion:(id<MMAsyncActivityResult>)result { 
    if (result != nil) {
        if ([result isKindOfClass:[MMCreateBidActivityResult class]]) {
            MMCreateBidActivityResult *postResult = (MMCreateBidActivityResult *) result;
            
            if (postResult.bidCreateStatus == MMAsyncBidCreateResultSuccess) {
                [self performSelectorOnMainThread:@selector(updateBidPost:) withObject:postResult waitUntilDone:YES];
            } else {
                [self performSelectorOnMainThread:@selector(showAlertOnFailureToConfirm:) withObject:postResult waitUntilDone:YES];
            }
        }
    }
}

/**
 *  Performs validation checks then calls create a job api's
 **/
-(IBAction) btnCreateBid {

    if ([self checkForFieldErrors] == false){//No Field errors found
        
        postingBid = true;
        
        loadingDialog = [[LoadingView alloc] loadingViewInView:self.view];
        [loadingDialog.loadingLabel setText:@"Saving"];
        
        MMBidDetail* bid = [[MMBidDetail alloc] init];
        
        bid.jobId = thisJob.jobId;
    
        bid.price = [GUICommon formatForNumber:inptPayAmount.text];
        
        bid.pickupDate = pickupJobDatePicker.date;
        bid.pickupTime = inptPickupJobTime.text;
        bid.deliveryDate = deliveryJobDatePicker.date;
        bid.deliveryTime = inptDeliveryJobTime.text;
        bid.expiryDate = expiryDatePicker.date;
        
        DLog(@"%@",inptVehicle.text);
        bid.deliveryTypeID = selectedTransportType.first;

        bid.userId = [restDeligate getAccessToken].userId;
    
        //Start asynchronous activity
        MMCreateBidAsyncActivity* activity = [[MMCreateBidAsyncActivity alloc] initWithActivityDelegate:self
                                                        restDelegate:restDeligate bidToCreate:bid forJobId:thisJob.jobId.integerValue];
        [self.activityManagement dispatchMMAsyncActivity:activity];
    }
}

-(id) initWithCommandObject:(id <GUIRestDeligate>)commandObj job:(MMJobDetail*)job {
    if (self = [super init]) {
        restDeligate = commandObj;
        self->activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
        thisJob = job;
    }
    
    return self;
}

-(id) initWithCommandObject: (id <GUIRestDeligate>) commandObj {
    return [self initWithCommandObject:commandObj job :nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    self.title=@"Create quote";
    
    [scrollView addSubview:viewToScroll];
    [scrollView setContentSize:viewToScroll.frame.size];
    
    //Style done button
    NSArray* normalColors = [GUICommon MeeMeepActionButtonGradient];
    NSArray* highlightedColors =  [GUICommon MeeMeepActionButtonGradientHighlighted];
    [btnDone setGradientColor:highlightedColors forState:UIControlStateHighlighted];
    [btnDone setGradientColor:normalColors forState:UIControlStateNormal]; 
    
    //Initialises keyboard toolbar (input accessory that provides Previous,Next,Done functionality)
    keyboardToolbar = [[KeyboardToolBar alloc] 
                       initWithInputFields:self.view inputs: [[NSArray alloc] initWithObjects:
                                                       inptPayAmount,
                                                       inptPickupJobDate,
                                                       inptPickupJobTime,
                                                       inptDeliveryJobDate,
                                                       inptDeliveryJobTime,
                                                       inptExpiryDate,
                                                       inptVehicle,
                                                       nil]];
    
    
    //Setup keyboard and input accessory (keyboardtoolbar) for various controls
    //
    inptVehicle.inputView = vehiclePicker;
    inptVehicle.inputAccessoryView = keyboardToolbar;
    
    inptPickupJobDate.inputView = pickupJobDatePicker;
    inptPickupJobDate.inputAccessoryView = keyboardToolbar;
    
    pickupJobDatePicker.datePickerMode = UIDatePickerModeDate;
    [pickupJobDatePicker addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
    
    inptPickupJobTime.inputView = pickupJobTimePicker;
    inptPickupJobTime.inputAccessoryView = keyboardToolbar;
    
    inptDeliveryJobDate.inputView = deliveryJobDatePicker;
    inptDeliveryJobDate.inputAccessoryView = keyboardToolbar;
    
    deliveryJobDatePicker.datePickerMode = UIDatePickerModeDate;
    [deliveryJobDatePicker addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
    
    inptDeliveryJobTime.inputView = deliveryJobTimePicker;
    inptDeliveryJobTime.inputAccessoryView = keyboardToolbar;
    
    inptExpiryDate.inputView = expiryDatePicker;
    inptExpiryDate.inputAccessoryView = keyboardToolbar;
    
    expiryDatePicker.datePickerMode = UIDatePickerModeDate;
    [expiryDatePicker addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
    
    inptPayAmount.keyboardType = UIKeyboardTypeDecimalPad;
    inptPayAmount.inputAccessoryView = keyboardToolbar;    
    
    //Style segmented controls (Options)
    UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
    [UISegmentedControl.appearance setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [self.view addSubview:scrollView];
    
    [self determineDateTimeText:TRUE];
    [self determineDateTimeText:FALSE];
    expiryDatePicker.minimumDate = [NSDate date];    

    //Set fields to default values
    [self resetInputFields];
}


- (void)viewDidUnload {
    [self setLblPayAmountNote:nil];
    [self setLblPayAmount:nil];
    [self setLblVehicle:nil];
    [self setLblVehicleNote:nil];
    [self setTableViewDDVehicle:nil];
    [self setTableViewDDVehicle:nil];
    [self setInptVehicle:nil];
    [self setVehiclePicker:nil];
    [self setLblPickupDateRange:nil];
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
    
    [self registerForKeyboardNotifications];
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
    UITableViewCell* cell;
    
    EditableTableViewCell* myCell = [GUICommon getEditableTableViewCell:tableView];
    [myCell.textField setUserInteractionEnabled:false];
    
    if ((tableView==tableViewDDVehicle)||(tableView==pickupDateTableView)||
        (tableView==pickupTimeTableView) ||(tableView == deliveryDateTableView) ||
        tableView == deliveryTimeTableView || tableView == expiryDateTableView){
        //Code for dropdown boxes

        if((tableView == pickupDateTableView && inptPickupJobDate.enabled) ||
            (tableView == pickupTimeTableView && inptPickupJobTime.enabled) ||
            (tableView == deliveryDateTableView && inptDeliveryJobDate.enabled) ||
            (tableView == deliveryTimeTableView && inptDeliveryJobTime.enabled) ||
            (tableView == expiryDateTableView && inptExpiryDate.enabled)) {
            // don't show the down arrow if the date is set to onThisDay
            myCell.accessoryView = [self getDownArrowButton];
        }
        
        //Sets relevant text data
        if (tableView==tableViewDDVehicle){
            myCell.textField.placeholder = inptVehicle.placeholder;
            myCell.textField.text = inptVehicle.text;
        } else if (tableView==pickupDateTableView){            
            myCell.textField.placeholder = inptPickupJobDate.placeholder;
            myCell.textField.text = inptPickupJobDate.text;
        } else if (tableView==pickupTimeTableView){
            myCell.textField.placeholder = inptPickupJobTime.placeholder;
            myCell.textField.text = inptPickupJobTime.text;
        } else if (tableView==deliveryDateTableView){
            myCell.textField.placeholder = inptDeliveryJobDate.placeholder;
            myCell.textField.text = inptDeliveryJobDate.text;
        } else if (tableView==deliveryTimeTableView){
            myCell.textField.placeholder = inptDeliveryJobTime.placeholder;
            myCell.textField.text = inptDeliveryJobTime.text;
        } else if (tableView==expiryDateTableView){
            myCell.textField.placeholder = inptExpiryDate.placeholder;
            myCell.textField.text = inptExpiryDate.text;
        }
            
        cell = myCell;
    }
    return cell;
}

-(UIButton*) getDownArrowButton {
    //Sets disclosure icon to down arrow
    UIButton* accessory = [UIButton buttonWithType:UIButtonTypeCustom];
    [accessory setImage:[UIImage imageNamed:@"DownArrow.png"] forState:UIControlStateNormal];
    accessory.frame = CGRectMake(0, 0, 26, 26);
    accessory.userInteractionEnabled = YES;
    [accessory setEnabled:false];
    return accessory;
}


#pragma mark - Table view delegate


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [keyboardToolbar resignKeyboard:nil];
    
    //Forces dummy objects to become first responder (scrolls tables into view and allows keyboard input)
    if (tableView==tableViewDDVehicle) {
        [inptVehicle becomeFirstResponder];
    } else if (tableView==pickupDateTableView) {
        [inptPickupJobDate becomeFirstResponder];
    } else if (tableView==pickupTimeTableView) {
        [inptPickupJobTime becomeFirstResponder];
    } else if (tableView==deliveryDateTableView) {
        [inptDeliveryJobDate becomeFirstResponder];
    } else if (tableView==deliveryTimeTableView) {
        [inptDeliveryJobTime becomeFirstResponder];
    } else if (tableView==expiryDateTableView) {
        [inptExpiryDate becomeFirstResponder];
    }
}

#pragma mark - Text field delegate

- (void) registerForKeyboardNotifications {
    
    DLog(@"Registering for keyboard notifications...");
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [notificationCenter addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
}

- (void) deRegisterKeyboardNotifications {
    
    DLog(@"deRegistering for keyboard notifications...");
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [notificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];    
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGFloat navbarHeight = self.navigationController.navigationBar.frame.size.height;    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0,
                                                  kbSize.height - navbarHeight,
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
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {  
    if (textField==inptPayAmount){        
        //Format pay amount field into money
        static NSString *numbers = @"0123456789";
        static NSString *numbersPeriod = @"01234567890.";
        static NSString *numbersComma = @"0123456789,";
        if (range.length > 0 && [string length] == 0) {
            return YES;
        }
        NSString *symbol = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
        if (range.location == 0 && [string isEqualToString:symbol]) {
            return NO;
        }
        NSCharacterSet *characterSet;
        NSRange separatorRange = [textField.text rangeOfString:symbol];
        if (separatorRange.location == NSNotFound) {
            if ([symbol isEqualToString:@"."]) {
                characterSet = [[NSCharacterSet characterSetWithCharactersInString:numbersPeriod] invertedSet];
            }
            else {
                characterSet = [[NSCharacterSet characterSetWithCharactersInString:numbersComma] invertedSet];              
            }
        }
        else {
            if (range.location > (separatorRange.location + 2)) {
                return NO;
            }
            characterSet = [[NSCharacterSet characterSetWithCharactersInString:numbers] invertedSet];               
        }
        return ([[string stringByTrimmingCharactersInSet:characterSet] length] > 0);
    } else
        return true;
}

-(BOOL) textViewShouldBeginEditing:(UITextView *)textView {
    UIView* containerView = textView;
    NSInteger yLocation = textView.frame.origin.y;
    
    while (containerView!=self.viewToScroll){
        containerView = [containerView superview];
        yLocation += containerView.frame.origin.y;
    }
 
    
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{      
    
    if ((textField==inptVehicle) & ([inptVehicle.text isEqualToString:@""])) {
        [self pickerView:vehiclePicker didSelectRow:0 inComponent:0];
    } else if ((textField==inptPickupJobDate) & ([inptPickupJobDate.text isEqualToString:@""])) {
        [self dateChange:pickupJobDatePicker];
    } else if ((textField==inptDeliveryJobDate) & ([inptDeliveryJobDate.text isEqualToString:@""])) {
        [self dateChange:deliveryJobDatePicker];
    } else if ((textField==inptPickupJobTime) & ([inptPickupJobTime.text isEqualToString:@""])) {
        [self pickerView:pickupJobTimePicker didSelectRow:0 inComponent:0];
    } else if ((textField==inptDeliveryJobTime) & ([inptDeliveryJobTime.text isEqualToString:@""])) {
        [self pickerView:deliveryJobTimePicker didSelectRow:0 inComponent:0];
    } else if ((textField==inptExpiryDate) & ([inptExpiryDate.text isEqualToString:@""])) {
        [self dateChange:expiryDatePicker];
    }
    
    activeTextField = textField;
    return YES;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    activeTextField = nil;
    
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return true;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
}


#pragma mark - Pickers / Spinners


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView==vehiclePicker) {
        return [[[restDeligate getConfig] getTransportTypes] count];
    } else if (pickerView==pickupJobTimePicker || pickerView==deliveryJobTimePicker) {
        return [[[restDeligate getConfig] getTimePeriods] count];
    } else {
        return 0;
    }
}


- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (thePickerView==vehiclePicker) {
        MMPair* pair = [[[restDeligate getConfig] getTransportTypes] objectAtIndex:row];
        return pair.second;
    } else if(thePickerView == pickupJobTimePicker || thePickerView == deliveryJobTimePicker) {
        return [[[restDeligate getConfig] getTimePeriods] objectAtIndex:row];
    } else {
        return nil;
    }
    
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (thePickerView==vehiclePicker) {
        MMPair* pair = [[[restDeligate getConfig] getTransportTypes] objectAtIndex:row];
        inptVehicle.text = pair.second;
        selectedTransportType = pair;
        
        [tableViewDDVehicle reloadData];
    } else if(thePickerView == pickupJobTimePicker || thePickerView == deliveryJobTimePicker) {
        NSString* period = [[[restDeligate getConfig] getTimePeriods] objectAtIndex:row];
        UITextField* textField = nil;
        UITableView* tableView = nil;
        
        if(thePickerView == pickupJobTimePicker) {
            tableView = pickupTimeTableView;
            textField = inptPickupJobTime;
        } else {
            tableView = deliveryTimeTableView;
            textField = inptDeliveryJobTime;
        }
        
        textField.text = period;        
        [tableView reloadData];
    }
}

- (void)dateChange:(id)sender{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	df.dateStyle = NSDateFormatterMediumStyle;

    
    UITextField* textField = nil;
    UITableView* tableView = nil;
    UIDatePicker* datePicker = nil;
    if(sender == pickupJobDatePicker) {
        textField = inptPickupJobDate;
        tableView = pickupDateTableView;
        datePicker = pickupJobDatePicker;
    } else if(sender == deliveryJobDatePicker) {
        textField = inptDeliveryJobDate;
        tableView = deliveryDateTableView;
        datePicker = deliveryJobDatePicker;        
    } else if(sender == expiryDatePicker) {
        textField = inptExpiryDate;
        tableView = expiryDateTableView;
        datePicker = expiryDatePicker;
    }
    
    NSString* text = [NSString stringWithFormat:@"%@",
                      [df stringFromDate:datePicker.date]];
    
    textField.text = text;
    [tableView reloadData];
}

-(IBAction) btnTCNoteClicked:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://meemeep.com/Account/Policy.aspx"]];
}

-(NSInteger) calculateYOffset:(UIView *)view {
    UIView* containerView = view;
    NSInteger yLocation = view.frame.origin.y;
    
    while (containerView!=self.viewToScroll){
        containerView = [containerView superview];
        yLocation += containerView.frame.origin.y;
    }
    
    return yLocation;
}

-(void) showAlertOnFailure:(NSString*)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

-(void) determineDateTimeText:(BOOL) pickup {
    NSString* labelText;
    UIDatePicker* datePicker;
    UILabel* label;
    
    if(pickup) {
        datePicker = pickupJobDatePicker;
        label = lblPickupDateRange;
    } else {
        datePicker = deliveryJobDatePicker;
        label = lblDeliveryDateRange;
    }

    NSDate* date;
    NSString* time;
    
    if(pickup) {
        date = thisJob.pickupDate;
        time = thisJob.pickupTime;
    } else {
        date = thisJob.deliveryDate;
        time = thisJob.deliveryTime;
    }
        
    NSArray* timePeriods = [[restDeligate getConfig] getTimePeriods];

    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;

    if(time == nil) {
        time = [timePeriods objectAtIndex:0];
    }
    
    datePicker.minimumDate = [NSDate date];
    
    NSString* dateText;
    if(date == nil) {
        dateText = @"Any day";
    } else {
        dateText = [self formatDate:date];
    }
            
    labelText = [NSString stringWithFormat:@"%@ on %@", time, dateText];
    
    label.text = labelText;
}

-(NSString *) formatDate:(NSDate*) date {
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    
    return [df stringFromDate:date];
}

@end
