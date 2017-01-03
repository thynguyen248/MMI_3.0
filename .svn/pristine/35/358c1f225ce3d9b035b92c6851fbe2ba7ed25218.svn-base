//
//  CompleteJobViewController.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 3/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "CompleteJobViewController.h"
#import "MMCompleteJobAsyncActivity.h"
#import "MMCompleteJobAsyncActivityResult.h"
#import "MMCompositeAsyncActivity.h"
#import "MMCompositeActivityResult.h"
#import "RatingReasonListDelegate.h"
#import "MMConfig.h"

@implementation CompleteJobViewController

@synthesize reviewTableView;

@synthesize btnSubmit;

@synthesize lblRateUser;

@synthesize keyboardToolbar;

-(id) initWithCommandObject: (id<GUIRestDeligate>) commandObj{
    self = [super init];
    if (self){
        restDeligate = commandObj;
        activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
        [GUICommon setBackButton:self.navigationItem];
        return self;
    } else return nil;
}


-(id) initWithJob:(id<GUIRestDeligate>)commandObj job:(MMJobDetail*)jobDetail{
    self = [self initWithCommandObject: commandObj];
    if (self){
        thisJob = jobDetail;
        showReasons = false;
        return self;
    } else return nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [reviewTableView reloadData];
}

-(IBAction)btnSubmitClick:(id)sender{
    
    NSInteger rating = [ratingCell getRating];
    
    if (rating <= 0)
    {
        // They need to select a rating
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You have not set a rating" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    MMUserRating *userRating = [[MMUserRating alloc] init];
    userRating.jobId = thisJob.jobId;
    userRating.rating = [NSNumber numberWithInt:rating];
    userRating.comment = [[commentsCell value] text];
    
    if(showReasons) {
        if([self.reasonsSet count] == 0) {
            // They need to select a reason
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You have not selected a reason. Please click \"What didn't work?\"." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        NSMutableArray* reasonsArray = [[NSMutableArray alloc] initWithCapacity:[self.reasonsSet count]];
        for(RatingReasonListItem* reason in self.reasonsSet) {
            [reasonsArray addObject:reason.description];
        }
        userRating.reasons = reasonsArray;
    }
    
    loadingDialog = [[LoadingView alloc] loadingViewInView:self.view];
    
    MMCompleteJobAsyncActivity* activity = [[MMCompleteJobAsyncActivity alloc] initWithActivityDelegate:self
                                                                                     restDelegate:restDeligate
                                                                                           rating:userRating];
    
    [activityManagement dispatchMMAsyncActivity:activity];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self getSectionFromIndex:indexPath.section] == SectionReason)
    {
        RatingReasonListDelegate* delegate = [[RatingReasonListDelegate alloc] initWithController:self data:[[restDeligate getConfig] getRatingReasons]];
        ListSelectorViewController* controller = [[ListSelectorViewController alloc] initWithDelegate:delegate];
        if(self.reasonsSet != nil) {
            [controller initialiseSelectedItems:self.reasonsSet];
        }
        controller.modalTransitionStyle =  UIModalTransitionStyleFlipHorizontal;
        [self presentModalViewController:controller animated:true];
        return;
    }
}





-(IBAction)btnCancelClick:(id)sender{
    [self dismissModalViewControllerAnimated:TRUE];
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
    // Do any additional setup after loading the view from its nib.
    
    // Job owner rates bidder
    [lblRateUser setText:[NSString stringWithFormat:@"Rate %@", thisJob.winningBidder]];
    
    //Style 'i agree' button
    NSArray* normalColors = [GUICommon MeeMeepActionButtonGradient];
    NSArray* highlightedColors =  [GUICommon MeeMeepActionButtonGradientHighlighted];
    [btnSubmit setGradientColor:highlightedColors forState:UIControlStateHighlighted];
    [btnSubmit setGradientColor:normalColors forState:UIControlStateNormal];
    
    // ratings cell
    ratingCell = [GUICommon getRatingTableViewCell:reviewTableView];
    [ratingCell setUpCellWithRating:0 isEditable:YES andDelegate:self];
    
    // comments cell
    commentsCell = [GUICommon getLargeEditableKeyValueTableViewCell:reviewTableView];
    [commentsCell.key setText:@"Optional comments"];
    [commentsCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //Initialises keyboard toolbar (input accessory that provides Previous,Next,Done functionality)
    keyboardToolbar = [[KeyboardToolBar alloc] initWithInputFields:self.view inputs: [[NSArray alloc] initWithObjects:
                                                                                      commentsCell.value,
                                                                                      nil]];
    commentsCell.value.inputAccessoryView = keyboardToolbar;
    
    [self registerForKeyboardNotifications];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return showReasons ? 3 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([self getSectionFromIndex:indexPath.section]) {
        case SectionComments:
            return 160;
        default:
            break;
    }
    return tableView.rowHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch ([self getSectionFromIndex:indexPath.section]) {
        case SectionRating:
            return ratingCell;
        case SectionReason:
        {
            NSMutableString* reasons = [[NSMutableString alloc] init];
            EditableTableViewCell* cell = [GUICommon getEditableTableViewCell:tableView];
            [cell.textField setUserInteractionEnabled:false];
            
            //Sets disclosure icon to arrow
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            
            if([_reasonsSet count] == 0) {
                cell.textField.placeholder = @"What didn't work?";
            } else {
                int i = 0;
                for(ListSelectorItem* item in _reasonsSet) {
                    ++i;
                    [reasons appendString:item.description];
                    
                    if(i < [_reasonsSet count]) {
                        [reasons appendString:@", "];
                    }
                }
                
                cell.textField.text = reasons;
            }
            
            return cell;
        }
        case SectionComments:
            return commentsCell;
        default:
            break;
    }
    return [GUICommon getMyTableViewCell:tableView];
}

-(CompleteJobSection) getSectionFromIndex:(NSInteger)index
{
    if (index == 0) {
        return index;
    } else {
        return showReasons ? index : index + 1;
    }
}

-(void)onRatingChange:(NSInteger)rating {
    if(rating == 0 || rating > 3) {
        // reasons not needed
        showReasons = false;
        [reviewTableView reloadData];
    } else {
        // reasons needed
        showReasons = true;
        [reviewTableView reloadData];
    }
}


#pragma mark - Keyboard related

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

- (void) keyboardWasShown:(NSNotification *) theNotification {    
    // calculate here how fast the keyboard is moving and how much of the screen has been shifted up!
    CGRect keyboardFrame;
    NSDictionary* userInfo = theNotification.userInfo;
    keyboardSlideDuration = [[userInfo objectForKey: UIKeyboardAnimationDurationUserInfoKey] floatValue];
    keyboardFrame = [[userInfo objectForKey: UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    keyboardShiftAmount = 110; //Amount to shift - do not remove
    
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

-(void) showAlertOnFailure:(NSString*)message {
    [loadingDialog removeView];
        
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
        
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void) finishLoading:(id)ignore {    
    [loadingDialog removeView];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Job Complete!" message:@"Job has been completed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
    [restDeligate setShouldUpdateJobDetail:TRUE];
    [restDeligate setShouldUpdateMyJobs:TRUE];
    [restDeligate setShouldUpdateRecentJobs:TRUE];
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissModalViewControllerAnimated:TRUE];
}

- (void) onAsyncActivityFailure:(NSError *)error {
    [self performSelectorOnMainThread:@selector(showAlertOnFailure:) withObject:[error localizedDescription] waitUntilDone:YES];
}

- (void) onAsyncActivityCompletion:(id<MMAsyncActivityResult>)result {    
    if (result != nil) {
        // finished loading all results
        [self performSelectorOnMainThread:@selector(finishLoading:) withObject:nil waitUntilDone:YES];
    }
}

-(IBAction)backgroundTouched:(id)sender
{
    [self.keyboardToolbar resignKeyboard:nil];
}

@end
