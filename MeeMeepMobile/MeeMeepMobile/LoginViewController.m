//
//  LoginViewController.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 29/02/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//


#import "LoginViewController.h"

#import "MMAsyncActivityManagement.h"
#import "MMAsyncActivityManagementImpl.h"
#import "MMLoginAsyncActivity.h"
#import "MMLoginActivityResult.h"

#import "RegistrationViewController.h"


@implementation LoginViewController

@synthesize logoView, btnSignIn, btnRegister, loginForm;

@synthesize activityManagement;


-(IBAction) btnCancelClick{
    [self dismissModalViewControllerAnimated:YES];
}


-(id) initWithCommandObject: (id <GUIRestDeligate>) commandObj {
    self = [super init];
    if (self) {
        restDeligate = commandObj;
        loginOnViewAppearing = FALSE;
        self.activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
        completionIndex = 0;
        return self;
    }
    return nil;
}

-(id) initWithTabIndex: (id <GUIRestDeligate>) commandObj tabIndex:(int) tabIndex{
    self = [self initWithCommandObject:commandObj];
    if (self) {
        loginOnViewAppearing = FALSE;
        completionIndex = tabIndex;
        return self;
    }
    return nil;
}



-(IBAction) btnForgotPasswordClick{
    //Load Url of meemeep password recovery page in default browser
    NSString* url = [[[restDeligate getRestClient] getBaseUrl] stringByAppendingPathComponent:@"public/password/forgotPassword"];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}





-(IBAction) btnRegisterClick{
    RegistrationViewController* vc = [[RegistrationViewController alloc] initWithCommandObject:restDeligate loginController:self];
    
    [self.navigationController pushViewController:vc animated:TRUE]; 
}

-(IBAction) btnSignInClick{

    NSIndexPath* usernameIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    EditableKeyValueTableViewCell* usernameCell = (EditableKeyValueTableViewCell*) [loginForm cellForRowAtIndexPath:usernameIndex];
    NSString* username = usernameCell.value.text;

    NSIndexPath* passwordIndex = [NSIndexPath indexPathForRow:1 inSection:0];
    EditableKeyValueTableViewCell* passwordCell = (EditableKeyValueTableViewCell*) [loginForm cellForRowAtIndexPath:passwordIndex];
    NSString* password = passwordCell.value.text;
    
    UITextField *usernameField = usernameCell.value;
    [usernameField resignFirstResponder];
    
    UITextField *passwordField = passwordCell.value;
    [passwordField resignFirstResponder];

    
    if (    ([username isEqualToString:@""])    ||  ([password isEqualToString:@""])    ){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Email and password fields cannot be empty." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    } else{
    

        MMLoginAsyncActivity *loginActivity = [[MMLoginAsyncActivity alloc] initWithActivityDelegate:self andRestClient:[restDeligate getRestClient] loginEmail:username loginPassword:password credentialsManagement:[restDeligate getCredentialsManagement]];
        
        [self.activityManagement dispatchMMAsyncActivity:loginActivity];
    
        loadingDialog = [[LoadingView alloc] loadingViewInView:self.view];
        
        [restDeligate setShouldUpdateJobDetail:true];
        [restDeligate setShouldUpdateMyJobs:true];
    }
}



- (void) onAsyncActivityCompletion:(id<MMAsyncActivityResult>) result {
    DLog(@"Activity Complete!");
    if (result != nil) {
        if ([result isKindOfClass:[MMLoginActivityResult class]]) {
            MMLoginActivityResult *res = (MMLoginActivityResult *) result;
            MMRestAccessToken *token = res.loginResultAccessToken;
            if (token != nil) {
                // review this action - potentially can be performed by the async activity
                [restDeligate setAccessToken:token];
                [restDeligate setUserProfile:res.loginResultUserProfile];
                [self performSelectorOnMainThread:@selector(dismissMe) withObject:nil waitUntilDone:NO];
            } else {
                [self performSelectorOnMainThread:@selector(showLoginFailureAlert:) withObject:@"Login failed" waitUntilDone:NO];
            }
        }
    }
}


- (void) onAsyncActivityFailure:(NSError *) error {
    NSString *additionalInformation = (error) ? [error localizedDescription] : nil;
    [self performSelectorOnMainThread:@selector(showLoginFailureAlert:) withObject:additionalInformation waitUntilDone:NO];
}


- (void) dismissMe {
    [loadingDialog removeView];
    [restDeligate saveAccessToken];
    [restDeligate showTabIndex:completionIndex andPopViewToRoot:FALSE];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) showLoginFailureAlert:(NSString *) additionalInformation {
    
    NSString *alertMessageFormat = @"We were unable to sign in to MeeMeep. ";
    alertMessageFormat = [alertMessageFormat stringByAppendingString:((additionalInformation) ? additionalInformation : @"")];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:alertMessageFormat delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alertView show];
    [loadingDialog removeView];
}


/*
 * Okay, so the story here goes:
 *
 * 1) When the user selects a text field, the keyboard is shown. Doing nothing
 * the keyboard will obscure the textfield until its dismissed. 
 * The approach should be to 'shift' the parent view until the position of the 
 * text field is 'above' the keyboard by its width
 * 2) In order to react to the keyboard being shown we have to register for local
 * notifications
 * 3) When we are redrawing the view we have to recalculate its visible drawing frame (x,y)
 *
 */

- (void) registerForKeyboardNotifications {
    DLog(@"Registering for keyboard notifications...");
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [notificationCenter addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
}


- (void) deRegisterKeyboardNotifications {
    
    DLog(@"deRegistering for keyboard notifications...");
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [notificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
}




- (void) keyboardWasShown:(NSNotification *) theNotification {    
    // calculate here how fast the keyboard is moving and how much of the screen has been shifted up!
    CGRect keyboardFrame;
    NSDictionary* userInfo = theNotification.userInfo;
    keyboardSlideDuration = [[userInfo objectForKey: UIKeyboardAnimationDurationUserInfoKey] floatValue];
    keyboardFrame = [[userInfo objectForKey: UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    UIInterfaceOrientation theStatusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if UIInterfaceOrientationIsLandscape (theStatusBarOrientation)
        keyboardShiftAmount = keyboardFrame.size.width;
    else 
        keyboardShiftAmount = keyboardFrame.size.height-34;
    
    [UIView beginAnimations: @"ShiftUp" context: nil];
    [UIView setAnimationDuration: keyboardSlideDuration];
    self.view.center = CGPointMake( self.view.center.x, self.view.center.y - keyboardShiftAmount);
    [UIView commitAnimations];
    viewShiftedForKeyboard = TRUE;
}

- (void) keyboardWasHidden:(NSNotification *) notification {
    if (viewShiftedForKeyboard) {
        [UIView beginAnimations: @"ShiftUp" context: nil];
        [UIView setAnimationDuration: keyboardSlideDuration];
        self.view.center = CGPointMake( self.view.center.x, self.view.center.y + keyboardShiftAmount);
        [UIView commitAnimations];
        viewShiftedForKeyboard = FALSE;
    }
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


- (void)viewDidAppear:(BOOL)animated{
    // register for keyboard notifications here
    [self registerForKeyboardNotifications];
    
    if(loginOnViewAppearing) {
        [self btnSignInClick];
        loginOnViewAppearing = FALSE;
    }
}

-(void) viewWillDisappear:(BOOL)animated{
    
    //Unregister keyboard notifications
    [self deRegisterKeyboardNotifications];
    
    
    //Resign keyboard
    NSIndexPath* usernameIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    EditableKeyValueTableViewCell* usernameCell = (EditableKeyValueTableViewCell*) [loginForm cellForRowAtIndexPath:usernameIndex];
    NSIndexPath* passwordIndex = [NSIndexPath indexPathForRow:1 inSection:0];
    EditableKeyValueTableViewCell* passwordCell = (EditableKeyValueTableViewCell*) [loginForm cellForRowAtIndexPath:passwordIndex];
    UITextField *usernameField = usernameCell.value;
    [usernameField resignFirstResponder];
    UITextField *passwordField = passwordCell.value;
    [passwordField resignFirstResponder];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Sign In";
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"signin_bg.png"]];
    //self.navigationController.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    
    logoView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Logo.png"]];
    
    //Style signin and register buttons
    NSArray* normalColors = [GUICommon MeeMeepActionButtonGradient];
    NSArray* highlightedColors =  [GUICommon MeeMeepActionButtonGradientHighlighted];
    [btnSignIn setGradientColor:highlightedColors forState:UIControlStateHighlighted];
    [btnSignIn setGradientColor:normalColors forState:UIControlStateNormal]; 
    [btnRegister setGradientColor:highlightedColors forState:UIControlStateHighlighted];
    [btnRegister setGradientColor:normalColors forState:UIControlStateNormal]; 

    
    cancelButton = [[UIBarButtonItem alloc]
                           initWithTitle:@"Cancel" 
                           style:UIBarButtonItemStylePlain	
                           target:self 
                           action:@selector(btnCancelClick)];	
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    
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


-(IBAction)textFileReturn:(id)sender {
    [sender resignFirstResponder];
}

-(IBAction)backgroundTouched:(id)sender {
    
    //Resign responder on textinputs
    
    NSMutableArray *potentiallyActiveTextFields = [[NSMutableArray alloc] init];
    
    EditableKeyValueTableViewCell *emailCell = (EditableKeyValueTableViewCell*) [loginForm cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [potentiallyActiveTextFields addObject:emailCell.value];
    
    EditableKeyValueTableViewCell *passwordCell = (EditableKeyValueTableViewCell*) [loginForm cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    [potentiallyActiveTextFields addObject:passwordCell.value];
    
    for (UITextField *tf in potentiallyActiveTextFields) {
        [tf resignFirstResponder];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections - it's the same for every tableview
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section - it's the same for every tableview
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EditableKeyValueTableViewCell* cell = [GUICommon getEditableKeyValueTableViewCell:tableView];
    
    if (indexPath.row==0){
        
        // load the email from the stored credential
        id<CredentialsManagement> credMgmt = [restDeligate getCredentialsManagement];
        Credentials *creds = [credMgmt getCredentials];
        
        if (creds) {
            cell.value.text = creds.email;
        } else {
            cell.value.placeholder = @"Your Email";  
        }
        
        cell.key.text = @"Email";
        cell.value.keyboardType = UIKeyboardTypeEmailAddress;
    } else
    if (indexPath.row==1){  
        cell.key.text = @"Password";
        cell.value.placeholder = @"Your Password";
        cell.value.secureTextEntry = true;
    }
    cell.value.delegate=cell;
     
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


#pragma mark - Table view delegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

-(void) populateLoginInfo:(NSString *) username password:(NSString *)password {
    NSIndexPath* usernameIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    EditableKeyValueTableViewCell* usernameCell = (EditableKeyValueTableViewCell*) [loginForm cellForRowAtIndexPath:usernameIndex];
    usernameCell.value.text = username;
    
    NSIndexPath* passwordIndex = [NSIndexPath indexPathForRow:1 inSection:0];
    EditableKeyValueTableViewCell* passwordCell = (EditableKeyValueTableViewCell*) [loginForm cellForRowAtIndexPath:passwordIndex];
    passwordCell.value.text = password;
    loginOnViewAppearing = TRUE;
}


@end
