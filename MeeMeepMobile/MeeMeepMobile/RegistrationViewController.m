//
//  RegistrationViewController.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 7/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "RegistrationViewController.h"
#import "MMRegistrationAsyncActivity.h"
#import "MMRegistrationAsyncActivityResult.h"
#import "MMVerifyPhoneAsyncActivity.h"
#import "MMRegistrationAsyncActivityResult.h"


@interface RegistrationViewController (Privates)
-(void) scrollToSelectedTextField;
-(NSInteger) calculateYOffset:(UIView *)view;
@end

@implementation RegistrationViewController

@synthesize keyboardToolbar;

@synthesize regTableView;

@synthesize btnSubmit;

NSString* const CheckBox_Checked = @"Checkbox-checked.png";
NSString* const CheckBox_Unchecked = @"Checkbox-unchecked.png";

NSString* const SegControl_Mover_Text = @"Are you interested in delivering items?";
NSString* const SegControl_Professional_Text = @"Are you a professional transport provider?";

NSInteger const MOBILE_NUMBER_MAX_LENGTH = 12;

NSInteger const COMMON_SECTION = 0;
NSInteger const USERNAME_ROW = 0;
NSInteger const PASSWORD_ROW = 1;
NSInteger const FIRSTNAME_ROW = 2;
NSInteger const SURNAME_ROW = 3;

NSInteger const MOVER_SECTION = 1;
NSInteger const PHONE_NUMBER_ROW = 0;
NSInteger const VALIDATION_CODE_ROW = 1;

NSInteger const PRO_MOVER_SECTION = 2;
NSInteger const ABN_ROW = 0;
NSInteger const BUSINESS_NAME_ROW = 1;

-(id) initWithCommandObject:(id<GUIRestDeligate>)commandObj
            loginController:(LoginViewController *) initLoginController {
    self = [super init];
    if (self){
        restDeligate = commandObj;
        loginController = initLoginController;
        activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
        [GUICommon setBackButton:self.navigationItem];
        footerCache = [[NSMutableDictionary alloc] initWithCapacity:2];
        inputCells = [[NSMutableDictionary alloc] initWithCapacity:8];
        inputMappings = [[NSMutableDictionary alloc] init];
        return self;
    } else return nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom etc
        [GUICommon setBackButton:self.navigationItem];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction) btnSubmitClicked{
    loadingDialog = [[LoadingView alloc] loadingViewInView:self.view];
    
    BOOL interestedInMoving = (sectionState != SectionState_Default);
    BOOL professionalMover = (sectionState == SectionState_ProMover);
    
    @try {
        MMNewUser *userProfile = [[MMNewUser alloc] init];
        
        userProfile.username = [self getCellValueAtIndex:USERNAME_ROW
                                              andSection:COMMON_SECTION andValidate:YES];
        userProfile.password = [self getCellValueAtIndex:PASSWORD_ROW
                                              andSection:COMMON_SECTION andValidate:YES];
        userProfile.firstName = [self getCellValueAtIndex:FIRSTNAME_ROW
                                               andSection:COMMON_SECTION andValidate:YES];
        userProfile.surname = [self getCellValueAtIndex:SURNAME_ROW
                                             andSection:COMMON_SECTION andValidate:YES];
        
        userProfile.isInterestedInMoving = [NSNumber numberWithBool:interestedInMoving];
        userProfile.phoneNumber = [self getCellValueAtIndex:PHONE_NUMBER_ROW
                                                 andSection:MOVER_SECTION andValidate:interestedInMoving];
        userProfile.validationCode = [self getCellValueAtIndex:VALIDATION_CODE_ROW
                                                    andSection:MOVER_SECTION andValidate:interestedInMoving];
        
        userProfile.isProfessionalMover = [NSNumber numberWithBool:professionalMover];
        userProfile.abn = [self getCellValueAtIndex:ABN_ROW andSection:PRO_MOVER_SECTION andValidate:professionalMover];
        userProfile.businessName = [self getCellValueAtIndex:BUSINESS_NAME_ROW andSection:PRO_MOVER_SECTION andValidate:professionalMover];
        
        [activityManagement dispatchMMAsyncActivity:[[MMRegistrationAsyncActivity alloc] initWithActivityDelegate:self restDelegate:restDeligate userProfile:userProfile]];
    }
    @catch (NSException *exception) {
        [self showAlertOnFailure:[exception name]];
    }
}

-(StyledKeyValueTableViewCell*) getCellAtIndex:(NSInteger)index andSection:(NSInteger)section {
    if(section >= [regTableView numberOfSections] || index >= [regTableView numberOfRowsInSection:section])
    {
        return nil;
    }
    
    UITableViewCell* cell = [inputCells objectForKey:[NSIndexPath indexPathForRow:index inSection:section]];
    if ([cell isKindOfClass:[StyledKeyValueTableViewCell class]])
    {
        return (StyledKeyValueTableViewCell*)cell;
    }
    return nil;
}

-(NSString*) getCellValueAtIndex:(NSInteger)index andSection:(NSInteger)section andValidate:(bool)isRequired {
    StyledKeyValueTableViewCell* kvCell = [self getCellAtIndex:index andSection:section];
    if(kvCell!=nil){
        [kvCell validate:isRequired];
        return kvCell.value.text;
    }
    return nil;
}

-(NSString*) getCellValueAtIndex:(NSInteger)index andSection:(NSInteger)section {
    StyledKeyValueTableViewCell* kvCell = [self getCellAtIndex:index andSection:section];
    
    if(kvCell!=nil){
        return kvCell.value.text;
    }
    return nil;
}

-(IBAction) btnTCNoteClicked:(id)sender{
    NSString* tcUrl = [[[restDeligate getRestClient] getBaseUrl] stringByAppendingPathComponent:@"public/home/policies"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tcUrl]];
}

- (void) registerForKeyboardNotifications {
    
    DLog(@"Registering for keyboard notifications...");
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [notificationCenter addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0,
                                                  kbSize.height,
                                                  0.0);
    
    regTableView.contentInset = contentInsets;
    regTableView.scrollIndicatorInsets = contentInsets;
    
    [self scrollToSelectedTextField];    
}

- (void) keyboardWasHidden:(NSNotification *) notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    regTableView.contentInset = contentInsets;
    regTableView.scrollIndicatorInsets = contentInsets;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    activeTextField = textField;
    
    //[self scrollToSelectedTextField];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    activeTextField = nil;
    
    return TRUE;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
    replacementString:(NSString *)string {
    if(textField == msisdnTextField) {
        return !([textField.text length] >= MOBILE_NUMBER_MAX_LENGTH && [string length] > range.length);
    } else {
        return TRUE;
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Sign Up"];
    
    sectionState = SectionState_Default;
    
    //Style submit button
    NSArray* normalColors = [GUICommon MeeMeepActionButtonGradient];
    NSArray* highlightedColors =  [GUICommon MeeMeepActionButtonGradientHighlighted];
    [btnSubmit setGradientColor:highlightedColors forState:UIControlStateHighlighted];
    [btnSubmit setGradientColor:normalColors forState:UIControlStateNormal];
    
    [self registerForKeyboardNotifications];
    
    [self setupKeyboardToolbar];
     
}

- (IBAction)onValidateClick:(id)sender
{
    DLog(@"Validate Clicked");
    
    loadingDialog = [[LoadingView alloc] loadingViewInView:self.view];
    @try {
        NSString* phoneNumber = [self getCellValueAtIndex:0 andSection:1 andValidate:YES];
        if(phoneNumber)
        {
            validateButton.enabled = FALSE;
            // Perform API call
            [activityManagement dispatchMMAsyncActivity:
             [[MMVerifyPhoneAsyncActivity alloc] initWithActivityDelegate:self restDelegate:restDeligate phoneNumber:phoneNumber]];
        }
    }
    @catch (NSException *exception) {
        [self showAlertOnFailure:[exception name]];
    }    
}

- (void) setupKeyboardToolbar
{
    [inputMappings removeAllObjects];
    if(!keyboardToolbar) {
        keyboardToolbar = [[KeyboardToolBar alloc] initWithInputFields:self.view inputs:nil];
    }
    //Setup keyboard - Pass it inputs of table cells
    NSMutableArray* inputs = [[NSMutableArray alloc] init];
    
    for (NSInteger j = 0; j < [regTableView numberOfSections]; j++) {
        for (NSInteger i = 0; i < [regTableView numberOfRowsInSection:j]; i++){
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:j];
            
            UITableViewCell* cell = [self tableView:regTableView cellForRowAtIndexPath:indexPath];
            
            if([cell isKindOfClass:[StyledKeyValueTableViewCell class]])
            {
                StyledKeyValueTableViewCell* sCell = (StyledKeyValueTableViewCell*) cell;
                sCell.value.delegate = self;
                sCell.value.inputAccessoryView = keyboardToolbar;
                sCell.value.tag = j * 10 + i;
                [inputs addObject:sCell.value];
                [inputMappings setObject:indexPath forKey:[NSNumber numberWithInt:sCell.value.tag]];
            }
        }
    }
    [keyboardToolbar setInputs:inputs];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    DLog(@"determine number of sections");
    return sectionState + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DLog(@"determine number of rows");
    switch (section) {
        case SectionState_Default:
            return 4;
            break;
        case SectionState_Mover:
            return validateClicked ? 2 : 1;
            break;
        case SectionState_ProMover:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Geg previously created cell
    StyledKeyValueTableViewCell* cell = [inputCells objectForKey:indexPath];
    if(cell != nil) {
        [[cell value] setBorderStyle:UITextBorderStyleRoundedRect];
        return cell;
    }
    
    // Cell doesn't exist - needs to be created
    cell = [GUICommon getStyledKeyValueTableViewCellDontCache:tableView];
    
    switch (indexPath.section) {
        case SectionState_Default:
            switch (indexPath.row) {
                case 0:
                    [cell setupCellWithKey:@"Email" andValue:@"" andValuePlaceHolder:@"" isEditable:YES];
                    [cell.value setKeyboardType:UIKeyboardTypeEmailAddress];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    break;
                case 1:
                    [cell setupCellWithKey:@"Password" andValue:@"" andValuePlaceHolder:@"" isEditable:YES];
                    [cell.value setSecureTextEntry:TRUE];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    break;
                case 2:
                    [cell setupCellWithKey:@"First Name" andValue:@"" andValuePlaceHolder:@"" isEditable:YES];
                    [cell.value setAutocapitalizationType:UITextAutocapitalizationTypeWords];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    break;
                case 3:
                    [cell setupCellWithKey:@"Last Name" andValue:@"" andValuePlaceHolder:@"" isEditable:YES];
                    [cell.value setAutocapitalizationType: UITextAutocapitalizationTypeWords];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    break;
                default:
                    break;
            }
            break;
        case SectionState_Mover:
            switch(indexPath.row) {
                case 0:
                    [cell setupCellWithKey:@"Mobile Number" andValue:@"" andValuePlaceHolder:@"" isEditable:YES];
                    [cell.value setKeyboardType:UIKeyboardTypePhonePad];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    msisdnTextField = cell.value;
                    break;
                case 1:
                    [cell setupCellWithKey:@"Verification Code" andValue:@"" andValuePlaceHolder:@"" isEditable:YES];
                    [cell.value setKeyboardType:UIKeyboardTypeNumberPad];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    break;
                default:
                    break;
            }
            break;
        case SectionState_ProMover:
            switch (indexPath.row) {
                case 0:
                    [cell setupCellWithKey:@"ABN" andValue:@"" andValuePlaceHolder:@"" isEditable:YES];
                    [cell.value setKeyboardType:UIKeyboardTypeNumberPad];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    break;
                case 1:
                    [cell setupCellWithKey:@"Business Name" andValue:@"" andValuePlaceHolder:@"" isEditable:YES];
                    [cell.value setAutocapitalizationType: UITextAutocapitalizationTypeWords];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    break;
                default:
                    break;
            }
        default:
            break;
    }
    
    cell.value.delegate = self;
    
    // Store created cell for next time it's needed
    [inputCells setObject:cell forKey:indexPath];
    return cell;
}

-(GradientButtonControl*) createValidateButton
{
    if(!validateButton)
    {
        validateButton = [[GradientButtonControl alloc] init];
        [validateButton setFrame:CGRectMake(20, 5.0, 280.0, 37.0)];
        [validateButton addTarget:self action:@selector(onValidateClick:) forControlEvents:UIControlEventTouchUpInside];
        //[validateButton setTitle:@"Verify with SMS" forState:UIControlStateNormal];
        
        NSArray* normalColors = [GUICommon MeeMeepActionButtonGradient];
        NSArray* highlightedColors =  [GUICommon MeeMeepActionButtonGradientHighlighted];
        NSArray* disabledColors = [GUICommon MeeMeepButtonGradientGray];

        
        [validateButton setGradientColor:highlightedColors forState:UIControlStateHighlighted];
        [validateButton setGradientColor:normalColors forState:UIControlStateNormal];
        [validateButton setGradientColor:disabledColors forState:UIControlStateDisabled];        
        
        UILabel* btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, 280.0, 21.0)];
        [btnLabel setText:@"Send SMS to verify account"];
        [btnLabel setTextColor:[UIColor whiteColor]];
        [btnLabel setTextAlignment:NSTextAlignmentCenter];
        [btnLabel setBackgroundColor:[UIColor clearColor]];
        [btnLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
        [validateButton addSubview:btnLabel];
    }
    return validateButton;
}

-(IBAction)backgroundTouched:(id)sender
{
    [self.keyboardToolbar resignKeyboard:nil];
}

#pragma mark - Table view delegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"Selected row %d, %d", indexPath.section, indexPath.row);
    //
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    shouldPopOnCompletion = NO;
}

-(void) showAlertOnFailure:(NSString*)message {
    [loadingDialog removeView];
    shouldPopOnCompletion = NO;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    validateButton.enabled = TRUE;
}


-(void) finishLoading:(id)ignore {    
    [loadingDialog removeView];
    shouldPopOnCompletion = YES;
    NSString* username = [self getCellValueAtIndex:USERNAME_ROW
                                          andSection:COMMON_SECTION andValidate:YES];
    NSString* password = [self getCellValueAtIndex:PASSWORD_ROW
                                          andSection:COMMON_SECTION andValidate:YES];
    [loginController populateLoginInfo:username password:password];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"User Registered!" message:@"You have successfully been registered. You will now be logged in." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

-(void) onValidateNumberSuccess {
    [loadingDialog removeView];    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Verification SMS Sent" message:@"We’ve just sent you an SMS with verification code in it.\nPlease enter the code into the Verification Code field" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:    nil];
    [alertView show];
    
    validateButton.enabled = TRUE;
    
    if(!validateClicked) {
        validateClicked = true;
        NSMutableArray* paths = [[NSMutableArray alloc] init];
        [paths addObject:[NSIndexPath indexPathForRow:1 inSection:1]];
        [regTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        [self setupKeyboardToolbar];
    }
}

- (void) alertView:(UIAlertView *) alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (shouldPopOnCompletion) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) onAsyncActivityFailure:(NSError *)error {
    [self performSelectorOnMainThread:@selector(showAlertOnFailure:) withObject:[error localizedDescription] waitUntilDone:YES];
}

- (void) onAsyncActivityCompletion:(id<MMAsyncActivityResult>)result {    
    if (result != nil) {
        if([result isKindOfClass:[MMRegistrationAsyncActivityResult class]])
        {
            [self performSelectorOnMainThread:@selector(finishLoading:) withObject:nil waitUntilDone:YES];
        } else {
            [self performSelectorOnMainThread:@selector(onValidateNumberSuccess) withObject:nil waitUntilDone:YES];
        }
    }
}

- (void)onSegControlChange:(NSString *)labelText withNewValue:(NSInteger)index
{
    if([SegControl_Mover_Text isEqualToString:labelText])
    {
        if(index == 0) {
            DLog(@"I am a mover");
            NSRange range = NSMakeRange(SectionState_Mover, 1);
            NSIndexSet* set = [NSIndexSet indexSetWithIndexesInRange:range];
            DLog(@"Set: %@", set);
            sectionState = SectionState_Mover;
            [regTableView insertSections:set withRowAnimation:UITableViewRowAnimationFade];
            
            // hack to fix the silly 'pro-mover' segControl
            SegmentedTableHeader* pro = [footerCache objectForKey:[NSNumber numberWithInteger:1]];
            if(pro)
            {
                [pro.segControl setSelectedSegmentIndex:1];
            }
        } else {
            DLog(@"I am not a mover");
            
            NSRange range = NSMakeRange(SectionState_Mover, sectionState - SectionState_Mover + 1);
            NSIndexSet* set = [NSIndexSet indexSetWithIndexesInRange:range];
            DLog(@"Set: %@", set);
            
            sectionState = SectionState_Default;
            [regTableView deleteSections:set withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    else if([SegControl_Professional_Text isEqualToString:labelText])
    {
        NSRange range = NSMakeRange(SectionState_ProMover, 1);
        NSIndexSet* set = [NSIndexSet indexSetWithIndexesInRange:range];
        DLog(@"Set: %@", set);
        if(index == 0) {
            DLog(@"I am a pro");
            sectionState = SectionState_ProMover;
            [regTableView insertSections:set withRowAnimation:UITableViewRowAnimationFade];
        } else {
            DLog(@"I am not a pro");
            sectionState = SectionState_Mover;
            [regTableView deleteSections:set withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    
    [self setupKeyboardToolbar];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (section) {
        case SectionState_Default:
            return 44;
        case SectionState_Mover:
            return 88;
    }
    return 0;
}

- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section {
    NSNumber* key = [NSNumber numberWithInteger:section];
    SegmentedTableHeader* header = [footerCache objectForKey:key];
    if(header != nil) {
        return header;
    }
    
    header = [GUICommon getSegmentedTableHeader:tableView];
    [header setDelegate:self];
    [header fixHeight];
    switch (section) {
        case SectionState_Default:
            [header.label setText:SegControl_Mover_Text];
            break;
        case SectionState_Mover:
        {
            CGRect labelFrame = header.label.frame;
            CGRect segFrame = header.segControl.frame;
            
            [header.label setText:SegControl_Professional_Text];
            
            [header.label setFrame:CGRectMake(labelFrame.origin.x, labelFrame.origin.y + 44.0, labelFrame.size.width, labelFrame.size.height)];
            [header.segControl setFrame:CGRectMake(segFrame.origin.x, segFrame.origin.y + 44.0, segFrame.size.width, segFrame.size.height)];
            
            [header addSubview:[self createValidateButton]];
            break;
        }
        default:
            header = nil;
            break;
    }
    
    if(header != nil) {
        [footerCache setObject:header forKey:key];
    }
    
    return header;
}

-(NSInteger) calculateYOffset:(UIView *)view {
    UIView* containerView = view;
    NSInteger yLocation = view.frame.origin.y;
    
    while (containerView!=self.regTableView){
        containerView = [containerView superview];
        if(containerView == nil) {
            break;
        }
        
        yLocation += containerView.frame.origin.y;
    }
    
    return yLocation;
}

-(void) scrollToSelectedTextField {
    NSIndexPath* indexPath = [inputMappings objectForKey:[NSNumber numberWithInt:activeTextField.tag]];
    if(indexPath != nil) {
        [regTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:TRUE];
    }
}

@end
