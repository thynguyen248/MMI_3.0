//
//  CreateJobAltViewController.m
//  MeeMeepMobile
//
//  Created by John Rowland on 27/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "CreateJobAltViewController.h"

@implementation CreateJobAltViewController


@synthesize scroller, contentView;
@synthesize keyboardToolbar;
@synthesize activityManagement;
@synthesize inptObject;
@synthesize tableViewDDWeight, inptWeight, weightPicker;
@synthesize inptDimensionLength, inptDimensionWidth, inptDimensionHeight;
@synthesize fromAddressTableView, destinationAddressTableView, inptFromAddress, inptDestinationAddress;
@synthesize inptJobDate, jobDatePicker, tableViewDDDate;
@synthesize inptJobDateRange, tableViewDDDateRange, jobDateRangePicker;
@synthesize inptJobTime, tableViewDDTime, jobTimePicker;
@synthesize inptOptions, segFragile, segPerishable, segSecuritySensitive, segTimeSensitive,segUrgent,segWaterSensitive;
@synthesize inptAdditionalInfo_Container, inptAdditionalInfo;
@synthesize inptPayAmount;
@synthesize btnDone;
@synthesize lblDestinationAddressNote, lblDimensionsNote, lblObjectNote, lblPayAmountNote, lblFromAddressNote, lblTimeFrameNote, lblWeightNote;
@synthesize moreOptions;


@synthesize tableContentContainer;

-(id) initWithCommandObject: (id <GUIRestDeligate>) commandObj{
    self = [super init];
    if (self){
        restDeligate = commandObj;
        self->activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
        return self;
    } else return nil;
}


/**
 *   Resets notification text back to an asterics
 **/
-(void) clearFieldErrors{
    lblObjectNote.text = @"*";
    lblWeightNote.text = @"*";
    lblDimensionsNote.text = @"*";
    lblFromAddressNote.text = @"*";
    lblDestinationAddressNote.text = @"*";    
    lblTimeFrameNote.text = @"*";
    lblPayAmountNote.text = @"*";
}




/**
 *   Sets fields back to their default values
 **/
-(void) resetInputFields{
    
    //Reset textfields
    inptObject.text = @"";
    inptWeight.text = @"";
    inptDimensionLength.text = @"";
    inptDimensionWidth.text = @"";
    inptDimensionHeight.text = @"";
    inptJobDate.text = @"";
    inptJobDateRange.text = @"";
    inptJobTime.text = @"";
    inptPayAmount.text = @"";
    inptAdditionalInfo.text = @"";
    
    //Destroy address objects
    fromAddress = nil;
    destinationAddress = nil;
    //Create address objects
    fromAddress = [[MMJobAddress alloc] init];
    destinationAddress = [[MMJobAddress alloc] init];
    
    [segUrgent setSelectedSegmentIndex:0];
    [segTimeSensitive setSelectedSegmentIndex:0];
    [segSecuritySensitive setSelectedSegmentIndex:0];
    [segPerishable setSelectedSegmentIndex:0];
    [segFragile setSelectedSegmentIndex:0];
    [segWaterSensitive setSelectedSegmentIndex:0];
    
    //Refresh tables to reflect changes
    [tableViewDDDate reloadData];
    [tableViewDDDateRange reloadData];
    [tableViewDDTime reloadData];
    [tableViewDDWeight reloadData];
    
    
    //Reset date related fields
    [self pickerView:weightPicker didSelectRow:0 inComponent:0];
    [self pickerView:jobDateRangePicker didSelectRow:0 inComponent:0];
    
    //Limit time and dates 
    NSDate *currentDate = [NSDate date];
    jobDatePicker.minimumDate = currentDate;
    jobDatePicker.maximumDate = [GUICommon getDate:currentDate AfterYears:1];
    jobTimePicker.minimumDate = [GUICommon getNextHalfHour:[NSDate date]];
    
    //Select defaults
    [jobTimePicker setDate:[GUICommon getNextHalfHour:[NSDate date]]];
    [jobDatePicker setDate:[NSDate date]];
    
    //Scroll to top
    [self.scroller scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:TRUE];
    
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
    
    //Validate object name
    if ([inptObject.text isEqualToString:@""]){
        lblObjectNote.text = @"* Required field";
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
    
    //Validate from address - ANY field equal to nil indicates NO data has been entered
    if (fromAddress.streetName==nil){
        lblFromAddressNote.text = @"* Required field";
        fieldError = true;
    } else lblFromAddressNote.text = @"*";
    
    
    //Validate destination address - ANY field equal to nil indicates NO data has been entered
    if (destinationAddress.streetName==nil){
        lblDestinationAddressNote.text = @"* Required field";
        fieldError = true;
    } else lblDestinationAddressNote.text = @"*";    
    
    //Validate job delivery time frame
    
    if (inptJobTime.userInteractionEnabled==true){//User interaction enabled indicates it is meant to be included
        if (
            ([inptJobDate.text isEqualToString:@""])||
            ([inptJobDateRange.text isEqualToString:@""])||
            ([inptJobTime.text isEqualToString:@""])
            )
        {
            lblTimeFrameNote.text = @"* Required field";
            fieldError = true;
        }
    } else{
        if (
            ([inptJobDate.text isEqualToString:@""])||
            ([inptJobDateRange.text isEqualToString:@""])
            )
        {
            lblTimeFrameNote.text = @"* Required field";
            fieldError = true;
        }
    }
    
    //Validate payment amount
    if ([inptPayAmount.text isEqualToString:@""]){
        lblPayAmountNote.text = @"* Required field";
        fieldError = true;
    } else{
        NSNumber* paymentAmount = [[NSNumber alloc] init];
        paymentAmount = [GUICommon formatForNumber:inptPayAmount.text];    
        if ([paymentAmount doubleValue]<1){
            lblPayAmountNote.text = @"* Value too low";
            fieldError = true;
        } else lblPayAmountNote.text = @"*";
    }
    
    
    if (fieldError==true){
        //Display error message
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"One or more fields have not been entered correctly." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }
    
    return fieldError;
}






- (void) updateJobPost:(MMCreateJobActivityResult*) confirmationResultDetail {
    [loadingDialog removeView];
    postingJob = false;
    
    if (confirmationResultDetail.jobCreatedStatus == MMAsyncCreateJobStatusSuccessNoCreditCard) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Done!" message:@"Your job was posted successfully.\nNote: to accept bids you must register a credit card at meemeep.com." delegate:self cancelButtonTitle:@"I understand" otherButtonTitles:nil];
        [alertView show];
    }
    
    
    [restDeligate setShouldUpdateRecentJobs:true];
    [restDeligate setShouldUpdateMyJobs:true];
    
    [restDeligate showTabIndex:1 andPopViewToRoot:TRUE];
    [self resetInputFields];
    
}

- (void) showAlertOnFailureToConnect: (NSString*) message{
    [loadingDialog removeView];
    
    NSString* errorMessage = [NSString stringWithFormat:@"Could not create job. %@", message];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
    postingJob = false;
    [restDeligate setShouldUpdateRecentJobs:true];
    [restDeligate setShouldUpdateMyJobs:true];
}



- (void) showAlertOnFailureToConfirm: (NSString*) message{
    [loadingDialog removeView];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"We were unable to contact MeeMeep. Please check your connection settings, or try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
    postingJob = false;
    [restDeligate setShouldUpdateRecentJobs:true];
    [restDeligate setShouldUpdateMyJobs:true];
    [self resetInputFields];  
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
        
        postingJob = true;
        
        loadingDialog = [[LoadingView alloc] loadingViewInView:self.view];
        
        //Get clients from restDeligate
        id<MMRestClient> restClient = [restDeligate getRestClient];
        MMRestAccessToken* accessToken = [restDeligate getAccessToken];
        
        MMJobDetail* job = [[MMJobDetail alloc] init];
        
        destinationAddress.country = @"Australia";
        job.dropOffAddress = destinationAddress;
        
        fromAddress.country = @"Australia";
        job.pickupAddress = fromAddress;
        
        job.pickupDate = jobDatePicker.date;
        
        
        if (jobDateRangeIndex==0){            
            job.pickupDate = [JobDateGenerator date:jobDatePicker.date withTimeBasedOnDate:jobTimePicker.date];
            job.maximumPickupDate = job.pickupDate;
        } else {
            NSTimeInterval secondsPerDay = 24 * 60 * 60;
            if (jobDateRangeIndex==1) 
                job.maximumPickupDate = [jobDatePicker.date dateByAddingTimeInterval:secondsPerDay*1];
            else if (jobDateRangeIndex==2) 
                job.maximumPickupDate = [jobDatePicker.date dateByAddingTimeInterval:secondsPerDay*2];
            else if (jobDateRangeIndex==3) 
                job.maximumPickupDate = [jobDatePicker.date dateByAddingTimeInterval:secondsPerDay*4];
            else
                job.maximumPickupDate = job.pickupDate = [jobDatePicker.date dateByAddingTimeInterval:secondsPerDay*7];
        }
        
        job.suggestedPrice = [GUICommon formatForNumber:inptPayAmount.text];
        job.title = [NSString stringWithFormat:@"%@ to %@",inptObject.text,destinationAddress.suburb];
        
        
        if ([inptWeight.text isEqualToString: [weightsArray objectAtIndex:0]]) job.weight = [NSNumber numberWithInt: 1];
        else
            if ([inptWeight.text isEqualToString: [weightsArray objectAtIndex:1]]) job.weight = [NSNumber numberWithInt: 5];
            else
                if ([inptWeight.text isEqualToString: [weightsArray objectAtIndex:2]])  job.weight = [NSNumber numberWithInt: 10];
        if ([inptWeight.text isEqualToString: [weightsArray objectAtIndex:3]]) job.weight = [NSNumber numberWithInt: 20];
        else
            if ([inptWeight.text isEqualToString: [weightsArray objectAtIndex:4]]) job.weight = [NSNumber numberWithInt: 100];
        
        job.height = [GUICommon formatForNumber:inptDimensionHeight.text];
        job.width = [GUICommon formatForNumber:inptDimensionHeight.text];
        job.length = [GUICommon formatForNumber:inptDimensionLength.text];
        
        job.isFragile = [[NSNumber alloc] initWithBool:segFragile.selectedSegmentIndex];
        job.isPerishable = [[NSNumber alloc] initWithBool:segPerishable.selectedSegmentIndex];
        job.isSecuritySensitive = [[NSNumber alloc] initWithBool:segSecuritySensitive.selectedSegmentIndex];
        job.isTimeSensitive = [[NSNumber alloc] initWithBool:segTimeSensitive.selectedSegmentIndex];
        job.isUrgent = [[NSNumber alloc] initWithBool:segUrgent.selectedSegmentIndex];
        job.isWaterSensitive = [[NSNumber alloc] initWithBool:segWaterSensitive.selectedSegmentIndex];
        job.additionalInformation = inptAdditionalInfo.text;
        job.quantity = [[NSNumber alloc] initWithInt:1];
        job.userId = [restDeligate getAccessToken].userId;
        
        //Start asynchronous activity
        MMCreateJobAsyncActivity* activity = [[MMCreateJobAsyncActivity alloc] initWithActivityDelegate:self
                                                                                            accessToken:accessToken
                                                                                            jobToCreate:job
                                                                                             restClient:restClient
                                              ];
        [self.activityManagement dispatchMMAsyncActivity:activity];
    }
    
}


#pragma mark - Keyboard and component navigation related

-(void)unregisterKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:nil];
    
}

-(void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil]; 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFirstResponder:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFirstResponder:) name:UITextFieldTextDidBeginEditingNotification object:nil];
}

-(void)showFirstResponder:(NSNotification*)aNotification{
    DLog(@"SCROLL HEIGHT %f",scroller.frame.size.height);
    UIView *selectedField = (UIView*) [keyboardToolbar findFirstResponder];
    if (selectedField!=nil) if ([selectedField isKindOfClass:[UITextView class]]){
        [scroller scrollRectToVisible:selectedField.frame animated:TRUE];
    }
}


// Called when the UIKeyboardDidShowNotification is sent.
-(void)keyboardWasShown:(NSNotification*)aNotification
{
    
    NSInteger oldY = scroller.contentOffset.y;
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    NSInteger kbActualHeight;
    kbActualHeight =  kbSize.height;
    
    BOOL needsToAlignComponent;
    if (scroller.frame.size.height==originalScrollFrame.size.height) needsToAlignComponent=true;
    
    //scroller.frame = CGRectMake(originalScrollFrame.origin.x, originalScrollFrame.origin.y , originalScrollFrame.size.width, 200);

    scroller.frame = CGRectMake(0, scroller.frame.origin.y, scroller.frame.size.width, self.view.frame.size.height-kbActualHeight);
    
    if ((needsToAlignComponent==true)&&(oldY==scroller.contentOffset.y)){
        UIView *selectedField = (UIView*) [keyboardToolbar findFirstResponder];
       [scroller scrollRectToVisible:selectedField.frame animated:TRUE];
    }
     
}

-(void) keyboardWasHidden:(NSNotification *) notification {
    scroller.frame = CGRectMake(originalScrollFrame.origin.x, originalScrollFrame.origin.y, originalScrollFrame.size.width, originalScrollFrame.size.height);
}






#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"Create Job";
    
    // Styles dont button
    self.btnDone.layer.backgroundColor = [[UIColor cyanColor] CGColor];
    self.btnDone.layer.cornerRadius = 8.0;
    [self.btnDone setUserInteractionEnabled:YES];
    self.btnDone.reversesTitleShadowWhenHighlighted = YES;   
    
    
    //Weight options
    weightsArray = [[NSMutableArray alloc] init];
    [weightsArray addObject:@"Under 1 kg"];
    [weightsArray addObject:@"1 to 5kg"];
    [weightsArray addObject:@"5 to 10kg"];
    [weightsArray addObject:@"10 to 20kg"]; 
    [weightsArray addObject:@"Over 20kg"];
    
    
    //Job DateRange options
    dateRangesArray  = [[NSMutableArray alloc] init];    
    [dateRangesArray addObject:@"On this day"];
    [dateRangesArray addObject:@"Within 1 day of this day"];
    [dateRangesArray addObject:@"Within 2 days of this day"];
    [dateRangesArray addObject:@"Within 4 days of this day"];    
    [dateRangesArray addObject:@"Within a week of this day"];
    
    
    
    
    
    //Setup view controller and keyboard accessory
    //Initialises keyboard toolbar (input accessory that provides Previous,Next,Done functionality)
    keyboardToolbar = [[KeyboardToolBar alloc] initWithInputFields:self.view: [[NSArray alloc] initWithObjects:
                                                                               inptObject,
                                                                               inptWeight,
                                                                               inptDimensionLength,
                                                                               inptDimensionWidth,
                                                                               inptDimensionHeight,
                                                                               inptFromAddress,
                                                                               inptDestinationAddress,
                                                                               inptJobDate,
                                                                               inptJobDateRange,
                                                                               inptJobTime,
                                                                               inptOptions,
                                                                               inptAdditionalInfo,
                                                                               inptPayAmount,
                                                                               nil]];
    
    
    //Setup keyboard and input accessory (keyboardtoolbar) for various controls
    //
    inptObject.keyboardType = UIKeyboardTypeDefault;
    inptObject.inputAccessoryView = keyboardToolbar;
    
    inptWeight.inputView = weightPicker;
    inptWeight.inputAccessoryView = keyboardToolbar;
    
    inptDimensionLength.keyboardType = UIKeyboardTypeNumberPad;
    inptDimensionLength.inputAccessoryView = keyboardToolbar;
    
    inptDimensionWidth.keyboardType = UIKeyboardTypeNumberPad;
    inptDimensionWidth.inputAccessoryView = keyboardToolbar;
    
    inptDimensionHeight.keyboardType = UIKeyboardTypeNumberPad;
    inptDimensionHeight.inputAccessoryView = keyboardToolbar;
    
    inptJobDate.inputView = jobDatePicker;
    inptJobDate.inputAccessoryView = keyboardToolbar;
    jobDatePicker.datePickerMode = UIDatePickerModeDate;
    [jobDatePicker addTarget:self action:@selector(jobDateChange:)forControlEvents:UIControlEventValueChanged];
    inptJobDateRange.inputView = jobDateRangePicker;
    inptJobDateRange.inputAccessoryView = keyboardToolbar;
    inptJobTime.inputView = jobTimePicker;
    [jobTimePicker setMinuteInterval:30];
    jobTimePicker.datePickerMode = UIDatePickerModeTime;  
    [jobTimePicker addTarget:self action:@selector(jobTimeChange:)forControlEvents:UIControlEventValueChanged];    
    inptJobTime.inputAccessoryView = keyboardToolbar;   
    
    inptFromAddress.inputAccessoryView = keyboardToolbar;     
    inptDestinationAddress.inputAccessoryView = keyboardToolbar; 
    
    inptAdditionalInfo.keyboardType = UIKeyboardTypeDefault;
    inptAdditionalInfo.inputAccessoryView = keyboardToolbar;
    
    inptPayAmount.keyboardType = UIKeyboardTypeDecimalPad;
    inptPayAmount.inputAccessoryView = keyboardToolbar;
    
    inptOptions.keyboardType = UIKeyboardTypeDefault;
    inptOptions.inputAccessoryView = keyboardToolbar;
    
    
    
    //Styles additional information textfield (gives it borders - thanks apple *sarcasm*)
    inptAdditionalInfo.layer.cornerRadius = 5;
    inptAdditionalInfo.clipsToBounds = YES;        
    [inptAdditionalInfo.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [inptAdditionalInfo.layer setBorderWidth:1.0];
    
    
    //Style segmented controls (Options)
    UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
    [UISegmentedControl.appearance setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    segUrgent.segmentedControlStyle = UISegmentedControlStylePlain;
    segUrgent.frame = CGRectMake(segUrgent.frame.origin.x, segUrgent.frame.origin.y , segUrgent.frame.size.width, 25);
    segFragile.segmentedControlStyle = UISegmentedControlStylePlain;
    segFragile.frame = CGRectMake(segFragile.frame.origin.x, segFragile.frame.origin.y , segFragile.frame.size.width, 25);
    segPerishable.segmentedControlStyle = UISegmentedControlStylePlain;
    segPerishable.frame = CGRectMake(segPerishable.frame.origin.x, segPerishable.frame.origin.y, segPerishable.frame.size.width, 25);
    segTimeSensitive.segmentedControlStyle = UISegmentedControlStylePlain;
    segTimeSensitive.frame = CGRectMake(segTimeSensitive.frame.origin.x, segTimeSensitive.frame.origin.y, segTimeSensitive.frame.size.width, 25);
    segWaterSensitive.segmentedControlStyle = UISegmentedControlStylePlain;
    segWaterSensitive.frame = CGRectMake(segWaterSensitive.frame.origin.x, segWaterSensitive.frame.origin.y, segWaterSensitive.frame.size.width, 25);
    segSecuritySensitive.segmentedControlStyle = UISegmentedControlStylePlain;
    segSecuritySensitive.frame = CGRectMake(segSecuritySensitive.frame.origin.x, segSecuritySensitive.frame.origin.y, segSecuritySensitive.frame.size.width, 25);
    
    /*

    scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-80)]; 
    [scroller setAutoresizesSubviews:FALSE];
    [scroller addSubview:contentView]; 
    scroller.contentSize = CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
    [self.view addSubview:scroller];  

     */
     
    //Record original heights of views for resizing later (keyboard related)
    originalScrollFrame = CGRectMake(scroller.frame.origin.x, scroller.frame.origin.y, scroller.frame.size.width, scroller.frame.size.height);
    
     
    
    
    //Set fields to default values
    [self resetInputFields];
    
    
}


-(void) viewDidAppear:(BOOL)animated{[super viewWillAppear:animated];[fromAddressTableView reloadData];[self registerForKeyboardNotifications];}
-(void) viewDidDisappear:(BOOL)animated{[super viewDidDisappear:animated];[self unregisterKeyboardNotifications];}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{return (interfaceOrientation == UIInterfaceOrientationPortrait);}


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
    if (tableView==tableContentContainer) return contentView.frame.size.height; else return 31;     
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell;
    
    if (tableView==tableContentContainer){
        cell = [GUICommon getMyTableViewCell:tableView];
        [cell addSubview:contentView];
    } else {
    
    EditableTableViewCell* myCell = [GUICommon getEditableTableViewCell:tableView];
    [myCell.textField setUserInteractionEnabled:false];
    
    
    if ((tableView==tableViewDDWeight)||(tableView==tableViewDDDate)||(tableView==tableViewDDDateRange)||(tableView==tableViewDDTime)){
        //Code for dropdown boxes
        
        //Sets disclosure icon to down arrow
        UIButton* accessory = [UIButton buttonWithType:UIButtonTypeCustom];
        [accessory setImage:[UIImage imageNamed:@"DownArrow.png"] forState:UIControlStateNormal];
        accessory.frame = CGRectMake(0, 0, 26, 26);
        accessory.userInteractionEnabled = YES;
        [accessory setEnabled:false];
        myCell.accessoryView = accessory;
        
        //Sets relevant text data
        if (tableView==tableViewDDWeight){
            myCell.textField.placeholder = inptWeight.placeholder;
            myCell.textField.text = inptWeight.text;
        } else
            if (tableView==tableViewDDDate){            
                myCell.textField.placeholder = inptJobDate.placeholder;
                myCell.textField.text = inptJobDate.text;
                
            } else
                if (tableView==tableViewDDDateRange){
                    myCell.textField.placeholder = inptJobDateRange.placeholder;
                    myCell.textField.text = inptJobDateRange.text;
                } else
                    if (tableView==tableViewDDTime){
                        myCell.textField.placeholder = inptJobTime.placeholder;
                        myCell.textField.text = inptJobTime.text;
                    }
        cell = myCell;
        
    } else{
        //Code for address callout boxes
        
        //Sets disclosure icon to down arrow
        myCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;  
        
        
        //Set relevant text data
        MMJobAddress* address;
        if (tableView == fromAddressTableView) address=fromAddress;
        else
            if (tableView == destinationAddressTableView) address=destinationAddress;
        
        if (address!=nil){
            myCell.textField.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@",
                                     [GUICommon formatForString:address.streetNumber],
                                     [GUICommon formatForString:address.streetName],
                                     [GUICommon formatForString:address.suburb],
                                     [GUICommon formatForString:address.state],
                                     [GUICommon formatForString:address.postCode],
                                     [GUICommon formatForString:address.country]
                                     ];
        }
        cell=myCell;
        
    }
    }
    
    return cell;
    
}




#pragma mark - Table view delegate


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [keyboardToolbar resignKeyboard:nil];
    
    //Forces dummy objects to become first responder (scrolls tables into view and allows keyboard input)
    if (tableView==tableViewDDWeight)[inptWeight becomeFirstResponder]; else
        if (tableView==tableViewDDDate)[inptJobDate becomeFirstResponder]; else
            if (tableView==tableViewDDDateRange)[inptJobDateRange becomeFirstResponder]; else
                if (tableView==tableViewDDTime)[inptJobTime becomeFirstResponder];
    
    
    FromAddressAltViewController* newView;
    
    NSString* caption;
    
    //Sends user to Address entry ViewController (modal) - also passes relevent object to be populated with data
    //
    if (tableView==fromAddressTableView){
        newView = [[FromAddressAltViewController alloc] initWithAddress:fromAddress];  
        caption = @"From Address";
    } else
        if (tableView==destinationAddressTableView){
            newView = [[FromAddressAltViewController alloc] initWithAddress:destinationAddress];   
            caption = @"Destination Address";
        }
    if (newView!=nil){
        newView.modalTransitionStyle =  UIModalTransitionStyleFlipHorizontal;
        [self.navigationController presentModalViewController:newView animated:true];
        //Update Address entry viewcontroller title to reflect callout (from/destination)
        //newView.navBarTitleItem.title = caption;
    }
    
}

#pragma mark - Text field delegate


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
        if (
            (textField==inptWeight)||
            (textField==inptJobDateRange)||
            (textField==inptFromAddress)||
            (textField==inptJobDate)||
            (textField==inptJobDateRange)||
            (textField==inptJobTime)||
            (textField==inptDestinationAddress)
            ) return false; else
                return true;
    
    
    
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{      
    
    if ((textField==inptWeight) & ([inptWeight.text isEqualToString:@""]))
        [self pickerView:weightPicker didSelectRow:0 inComponent:0];
    else
        if ((textField==inptJobDate) & ([inptJobDate.text isEqualToString:@""]))
            [self jobDateChange:jobDatePicker];
        else
            if ((textField==inptJobDateRange) & ([inptJobDateRange.text isEqualToString:@""]))
                [self pickerView:jobDateRangePicker didSelectRow:0 inComponent:0];
            else
                if ((textField==inptJobTime)&([inptJobTime.text isEqualToString:@""]))
                    [self jobTimeChange: jobTimePicker];
    
    [jobTimePicker setSelected:TRUE];
    
    //if from or destination is selected then make those fields visible on screen (no keyboard)
    if (
        (textField==inptFromAddress)||
        (textField==inptDestinationAddress)
        )
    {
        CGRect areaToView = CGRectMake(
                                       inptFromAddress.frame.origin.x,
                                       inptFromAddress.frame.origin.y-30,
                                       inptFromAddress.frame.size.width,
                                       (inptDestinationAddress.frame.origin.y-inptFromAddress.frame.origin.y+30)
                                       );
        [self.scroller scrollRectToVisible:areaToView animated:TRUE];
        return false;
    }
    
    
    //if options (placeholder for segmented buttons) is selected then make those fields visible (no keyboard)
    if (textField==inptOptions){
        CGRect areaToView = CGRectMake(
                                       segUrgent.frame.origin.x,
                                       moreOptions.frame.origin.y+segUrgent.frame.origin.y,
                                       segUrgent.frame.size.width,
                                       (segSecuritySensitive.frame.origin.y-segUrgent.frame.origin.y+30)
                                       );
        [self.scroller scrollRectToVisible:areaToView animated:TRUE];
        return false;
    }
    
    //Change size of scrollView (Put it above the keyboard)
    //self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, 155);
    
    return YES;
    
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{return true;}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField==inptObject){
        //Remove extra white spaces
        textField.text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //Make sure the first letter is capitalized
        textField.text = textField.text.capitalizedString;
        return true;
    } else return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{return true;}





#pragma mark - Pickers / Spinners


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{return 1;}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView==weightPicker) return [weightsArray count]; else
        if (pickerView==jobDateRangePicker) return [dateRangesArray count];
        else return 0;
}


- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (thePickerView==weightPicker) return [weightsArray objectAtIndex:row]; else
        if (thePickerView==jobDateRangePicker) return [dateRangesArray objectAtIndex:row];
        else return nil;
    
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (thePickerView==weightPicker) inptWeight.text = [weightsArray objectAtIndex:row]; else
        if (thePickerView==jobDateRangePicker){
            inptJobDateRange.text = [dateRangesArray objectAtIndex:row];
            if (row>0){
                //TimeFrame >Today - Hide time box
                moreOptions.frame = CGRectMake(0, inptJobTime.frame.origin.y, moreOptions.frame.size.width, moreOptions.frame.size.height);
                [tableViewDDTime setHidden:TRUE];
                [inptJobTime setUserInteractionEnabled:FALSE];
                [jobTimePicker setUserInteractionEnabled:FALSE];
            } else{
                //TimeFrame = Today - Show time box
                moreOptions.frame = CGRectMake(0, inptJobTime.frame.origin.y+50, moreOptions.frame.size.width, moreOptions.frame.size.height);
                
                [tableViewDDTime setHidden:FALSE];
                [inptJobTime setUserInteractionEnabled:TRUE];
                [jobTimePicker setUserInteractionEnabled:TRUE];
            }
            jobDateRangeIndex=row;
        }
    [tableViewDDWeight reloadData];
    [tableViewDDDateRange reloadData];
}

- (void)jobDateChange:(id)sender{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	df.dateStyle = NSDateFormatterMediumStyle;
    inptJobDate.text = [NSString stringWithFormat:@"%@", [df stringFromDate:jobDatePicker.date]];
    [tableViewDDDate reloadData];
}

- (void)jobTimeChange:(id)sender{    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeStyle:NSDateFormatterShortStyle];
    inptJobTime.text = [NSString stringWithFormat:@"By %@", [df stringFromDate:jobTimePicker.date]];
    [tableViewDDTime reloadData];
}






@end
