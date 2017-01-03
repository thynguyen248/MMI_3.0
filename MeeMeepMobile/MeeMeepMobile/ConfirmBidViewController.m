//
//  ConfirmBidViewController.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 9/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "ConfirmBidViewController.h"

#import "MMAsyncActivityManagementImpl.h"
#import "MMAcceptBidAsyncActivityResult.h"
#import "MMAcceptBidAsyncActivity.h"
#import "MMCanOfferIndemnityAsynchActivity.h"
#import "MMCanOfferIndemnityAsynchActivityResult.h"
#import "MMPair.h"
#import "MMJobIndemnity.h"
#import "MMConfig.h"


@implementation ConfirmBidViewController

@synthesize labelConfirmTitle;
@synthesize labelTotalCharge;

@synthesize activityManagement;

@synthesize btnIAgree;

@synthesize fromAddressTextField;
@synthesize toAddressTextField;

@synthesize fromSuburbLabel;
@synthesize toSuburbLabel;

@synthesize mobileNumberTextField;

@synthesize indemnityTableView;
@synthesize indemnityPicker;
@synthesize indemnityTextField;

@synthesize scrollView;

@synthesize viewToScroll;


NSInteger const MAX_MOBILE_NUMBER_LENGTH = 12;

-(IBAction)btnIAgreeClick{
    DLog(@"User requested accept quote %@", bid.bidId);
    
    // Create request object and send
    MMBidAcceptRequest* request = [[MMBidAcceptRequest alloc] init];
    @try {
        request.bidId = bid.bidId;
        
        if(fromAddressTextField == nil || [fromAddressTextField.text length] == 0) {
            @throw [NSException exceptionWithName:NSGenericException reason:@"From Address is required" userInfo:nil];
        }
        request.fromAddress = fromAddressTextField.text;
        
        if(toAddressTextField == nil || [toAddressTextField.text length] == 0) {
            @throw [NSException exceptionWithName:NSGenericException reason:@"To Address is required" userInfo:nil];
        }
        request.toAddress = toAddressTextField.text;
        
        if([mobileNumberTextField.text length] == 0) {
            @throw [NSException exceptionWithName:NSGenericException reason:@"Mobile Number is required" userInfo:nil];
        }
        request.mobileNumber = mobileNumberTextField.text;
        
        request.indemnity = jobIndemnity;
    }
    @catch (NSException *exception) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:exception.reason delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        return;
    }

    
    //Start asynchronis activity
    MMAcceptBidAsyncActivity* activity = [[MMAcceptBidAsyncActivity alloc] initWithActivityDelegate:self restDelegate:restDeligate andBidAccept:request];
    
    acceptingBid = true;
    loadingDialog = [[LoadingView alloc] loadingViewInView:self.view];
    
    [self.activityManagement dispatchMMAsyncActivity:activity];
}

-(IBAction)btnCancelClick{    
    [self dismissModalViewControllerAnimated:TRUE];
}




-(id) initWithCommandObject: (id <GUIRestDeligate>) commandObj {
    self = [super init];
    restDeligate = commandObj;
    self.activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
    [GUICommon setBackButton:self.navigationItem];
    return self;
}



-(id) initWithRestDeligate: (id<GUIRestDeligate>) commandObj andBidDetail:(MMBidDetail*) bidDetail andJobDetail:(MMJobDetail*) jobDetail {
    self = [self initWithCommandObject:commandObj];
    if (self) {
        bid = bidDetail;
        job = jobDetail;
        return self;
    } else return nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void) updateBidConfirmed:(MMBidDetail*) confirmationObject {

    [loadingDialog removeView];
    acceptingBid = false;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Done!"
                                                        message:[NSString stringWithFormat:@"You have successfully accepted %@'s quote.",bid.userName]
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil
                              ];
    
    [alertView show];
    
    [restDeligate setShouldUpdateJobDetail:TRUE];
    [restDeligate setShouldUpdateMyJobs:TRUE];
    [restDeligate setShouldUpdateMatchingJobs:TRUE];
    [restDeligate setShouldUpdateRecentJobs:TRUE];
    [restDeligate setShouldUpdateBids:TRUE];
}

-(void) jobIndemnityRetrieved {
    [loadingDialog removeView];
    [indemnityTableView reloadData];
}

- (void) alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if([alertView.title isEqualToString:@"Done!"])
    {
        // If everything went well, then close the screen
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (void) showAlertOnFailureToConnect: (NSString*) message{
    [loadingDialog removeView];
    
    NSString *alertMessage = @"We were unable to contact MeeMeep. ";
    alertMessage = [alertMessage stringByAppendingString:((message) ? message : @"Please check your connection settings, or try again.")];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:alertMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
    acceptingBid = false;
}


- (void) showAlertOnFailureToConfirm: (NSString*) message{
    [loadingDialog removeView];
    
    NSString *alertMessage = @"Unable to accept quote. ";
    alertMessage = [alertMessage stringByAppendingString:((message) ? message : @"Please check your connection settings, or try again.")];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:alertMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
    acceptingBid = false;
}

- (void) onAsyncActivityFailure:(NSError *)error {
    [self performSelectorOnMainThread:@selector(showAlertOnFailureToConnect:) withObject:[error localizedDescription] waitUntilDone:NO];
}


- (void) onAsyncActivityCompletion:(id<MMAsyncActivityResult>)result {    
    if (result != nil) {
        if ([result isKindOfClass:[MMAcceptBidAsyncActivityResult class]]) {
            
            MMAcceptBidAsyncActivityResult* confirmationResult = (MMAcceptBidAsyncActivityResult *) result;
            
            if (confirmationResult.bidAcceptStatus == MMAsyncBidAcceptResultSuccess){
                [self performSelectorOnMainThread:@selector(updateBidConfirmed:) withObject:confirmationResult waitUntilDone:YES];
            } else {
                NSString *errorMessage = @"Unexpected Error - quote acceptance failed.";
                
                if (confirmationResult.bidAcceptStatus == MMAsyncBidAcceptResultCreditCardNotRegistered) {
                    errorMessage = @"You haven't registered a credit card - could not accept quote.";
                }
                
                [self performSelectorOnMainThread:@selector(showAlertOnFailureToConfirm:) withObject:errorMessage waitUntilDone:YES];
            }
        } else if([result isKindOfClass:[MMCanOfferIndemnityAsynchActivityResult class]]) {
            MMCanOfferIndemnityAsynchActivityResult* canOfferResult = (MMCanOfferIndemnityAsynchActivityResult*)result;

            jobIndemnities = [[NSMutableArray alloc] init];            
            //Add other options to spinner
            if(canOfferResult.canOffer) {
                NSArray* configuredIndemnities = [[restDeligate getConfig] getJobIndemnities];
                [jobIndemnities addObject:[MMJobIndemnity getNoneObject]];
                [jobIndemnities addObjectsFromArray:configuredIndemnities];
                jobIndemnity = [jobIndemnities objectAtIndex:0];
                [indemnityTextField setEnabled:TRUE];
            } else {
                [jobIndemnities addObject:[MMJobIndemnity getNotOfferedObject]];
                [indemnityTextField setEnabled:FALSE];
            }
            
            jobIndemnity = [jobIndemnities objectAtIndex:0];
                        
            [self performSelectorOnMainThread:@selector(jobIndemnityRetrieved) withObject:nil waitUntilDone:YES];
        }
    }
}

- (void) updateTotalCharge
{
    float totalCharge = [jobIndemnity.price floatValue] + [bid.price floatValue];
    
    labelTotalCharge.text = [NSString stringWithFormat:@"TOTAL CHARGE: %@",
                             [GUICommon formatCurrency:[NSNumber numberWithFloat:totalCharge]]
                             ];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Quote Confirmation";
    
    labelConfirmTitle.text = [NSString stringWithFormat:@"Confirm %@'s quote (%@)",
                              [GUICommon formatForString:bid.userName],
                              [GUICommon formatCurrency:bid.price]
                              ];
    
    [self updateTotalCharge];
    
    //Style 'i agree' button
    NSArray* normalColors = [GUICommon MeeMeepActionButtonGradient];
    NSArray* highlightedColors =  [GUICommon MeeMeepActionButtonGradientHighlighted];
    [btnIAgree setGradientColor:highlightedColors forState:UIControlStateHighlighted];
    [btnIAgree setGradientColor:normalColors forState:UIControlStateNormal];

    [scrollView addSubview:viewToScroll];
    scrollView.contentSize = CGSizeMake(viewToScroll.frame.size.width, viewToScroll.frame.size.height);
    
    keyboardToolbar = [[KeyboardToolBar alloc] initWithInputFields:self.view inputs: [[NSArray alloc] initWithObjects:
                                                                                      fromAddressTextField,
                                                                                      toAddressTextField,
                                                                                      mobileNumberTextField,
                                                                                      indemnityTextField,
                                                                                      nil]];
    
    fromAddressTextField.inputAccessoryView = keyboardToolbar;
    toAddressTextField.inputAccessoryView = keyboardToolbar;
    mobileNumberTextField.inputAccessoryView = keyboardToolbar;
    
    indemnityTextField.inputAccessoryView = keyboardToolbar;
    indemnityTextField.inputView = self.indemnityPicker;
    
    if(job.fromLocation) {
        fromSuburbLabel.text = job.fromLocation.address;
    }
    if(job.toLocation) {
        toSuburbLabel.text = job.toLocation.address;
    }
}

- (void) viewWillAppear:(BOOL)animated {
    if(jobIndemnities == nil) {
        loadingDialog = [[LoadingView alloc] loadingViewInView:self.view];
        MMCanOfferIndemnityAsynchActivity* activity = [[MMCanOfferIndemnityAsynchActivity alloc] initWithActivityDelegate:self restDelegate:restDeligate userID:bid.userId];
            
        [self.activityManagement dispatchMMAsyncActivity:activity];
    }
    
    [self registerForKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self deRegisterKeyboardNotifications];
}

- (void)viewDidUnload
{
    [self setMobileNumberTextField:nil];
    [self setViewToScroll:nil];
    [self setScrollView:nil];
    [self setIndemnityTableView:nil];
    [self setIndemnityPicker:nil];
    [self setIndemnityTextField:nil];
    [self setLabelTotalCharge:nil];
    [self setFromAddressTextField:nil];
    [self setToAddressTextField:nil];
    [self setFromSuburbLabel:nil];
    [self setToSuburbLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditableTableViewCell* myCell;
    UITableViewCellAccessoryType accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (tableView == indemnityTableView)
    {
        myCell = [GUICommon getEditableTableViewCell:tableView];
        myCell.textField.text = jobIndemnity.description;
        
        if([jobIndemnities count] == 1) {
            accessoryType = UITableViewCellAccessoryNone;
            myCell.userInteractionEnabled = FALSE;
            myCell.textField.enabled = FALSE;
        } else {
            myCell.userInteractionEnabled = TRUE;
            myCell.textField.enabled = TRUE;
        }
        [myCell.textField setUserInteractionEnabled:false];
    }
    
    //Sets disclosure icon to down arrow
    myCell.accessoryType = accessoryType;
    
    return myCell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == indemnityTableView) {
        [indemnityTextField becomeFirstResponder];
    }
}

#pragma mark - Picker View

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [jobIndemnities count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    MMJobIndemnity* indemnity = [jobIndemnities objectAtIndex:row];
    return indemnity.description;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // save value selected
    jobIndemnity = [jobIndemnities objectAtIndex:row];
    [indemnityTableView reloadData];
    [self updateTotalCharge];
}

#pragma mark - Keyboard hacks

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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    activeTextField = textField;
    return YES;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if(textField == activeTextField) {
        activeTextField = nil;
    }
    
    return true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    if(textField == mobileNumberTextField) {
        return !([textField.text length] >= MAX_MOBILE_NUMBER_LENGTH && [string length] > range.length);
    } else {
        return TRUE;
    }
}

@end
