//
//  BidDetailViewController.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 5/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "BidDetailViewController.h"

#import "MMAsyncActivityManagementImpl.h"
#import "MMRetrieveBidDetailActivityResult.h"
#import "MMRetrieveBidDetailAsyncActivity.h"
#import "MMCompositeAsyncActivity.h"
#import "MMRetrieveUserAsyncActivity.h"
#import "MMRetrieveUserActivityResult.h"


@implementation BidDetailViewController

@synthesize detailTableView, navBar;

@synthesize activityManagement;

NSString * const AcceptBidTitle = @"Accept";
NSString * const WithdrawBidTitle = @"Withdraw";


-(void) openTelephoneAppWithPhonenumber: (NSString*) phoneNumber{
    NSString* encodedLocation = [GUICommon urlEncodeString:phoneNumber];
    NSString* address = [NSString stringWithFormat:@"tele:%@",encodedLocation];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:address]];
}

-(IBAction) onBtnActionsClick:(id)sender{
    
    NSString* buttonTitle = btnActions.title;
    
    if ([buttonTitle isEqualToString:AcceptBidTitle]) {
        MMUserProfile* user = [restDeligate getUserProfile];
        if(user && user.hasCreditCardDetails) {
            // Go to the bid detail screen on clicking the "Bids" tableview item
            ConfirmBidViewController* newView = [[ConfirmBidViewController alloc] initWithRestDeligate:restDeligate andBidDetail:bid andJobDetail:thisJob];
            
            [self.navigationController presentModalViewController:newView animated:true];
        } else {
            // You must have a credit card on file to accept a bid
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Next Step" message:@"We need you to enter your credit card details on the website. Please tap below to open in Safari.\nWhen you're done, please come back to the app." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Open Safari", nil];
            [alertView show];
        }
    }
    else if ([buttonTitle isEqualToString:WithdrawBidTitle]) {
        WithdrawBidViewController* newView = [[WithdrawBidViewController alloc]
                                              initWithBidDetail:restDeligate bidDetail:bid andNavigationController:self.navigationController];
        
        [self.navigationController presentModalViewController:newView animated:true];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    DLog(@"clickedButtonAtIndex: %d", buttonIndex);
    switch (buttonIndex) {
        case 0:
            // Cancel
            // Do nothing
            break;
        case 1:
            // View Website
            [GUICommon openUserPaymentDetailsWebsite:restDeligate];
            break;
    }
}

-(void) refreshBidDetail{
    if (!loadingBidDetails){
        loadingBidDetails = true;
    
        loadingDialog = [[LoadingView alloc] loadingViewInView:self.view];
        
        MMRetrieveBidDetailAsyncActivity* bidActivity = [[MMRetrieveBidDetailAsyncActivity alloc] initWithActivityDelegate:self restDelegate:restDeligate bidId:myBidId];
        
        [self.activityManagement dispatchMMAsyncActivity:bidActivity];
    }
}


-(id) initWithCommandObject:(id <GUIRestDeligate>)commandObj {
    self = [super init];
    restDeligate = commandObj;
    self.activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
    [GUICommon setBackButton:self.navigationItem];
    return self;
}


-(id) initWithBidId:(id<GUIRestDeligate>)commandObj bidId:(NSNumber*)bidId job:(MMJobDetail *)jobDetail{
    self = [self initWithCommandObject:commandObj];
    myBidId = bidId;
    thisJob = jobDetail;
    [self setTitle:thisJob.title];
    return self;
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
    
    loadingBidDetails = false;
    
    //Create and style actions button
    btnActions = [[UIBarButtonItem alloc] initWithTitle:@"Actions" style:UIBarButtonItemStyleBordered target:self action:@selector(onBtnActionsClick:)];
    [GUICommon styleActionButton:btnActions];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self refreshBidDetail];
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

- (void) updateBidDetails:(MMBidDetail*)bidDetail {
    [loadingDialog removeView];
    loadingBidDetails = false;
    
    bid = bidDetail;
    
    if([bid.status isEqualToString:@"BID_EXPIRED"] || [bid.status isEqualToString:@"BID_CANCELLED"]) {
        [self.navigationController popViewControllerAnimated:true];
        return;
    }
    
    NSString* buttonTitle = nil;
    UIColor* buttonColor = nil;
    
    if([bid.status isEqualToString:@"BID_CREATED"] && [thisJob.jobStatus is:JOB_CREATED])
    {
        if ([GUICommon isOwnerOfJob:thisJob accessToken:[restDeligate getAccessToken]]) {
            // job owner can accept an active bid
            buttonTitle = AcceptBidTitle;
            buttonColor = [GUICommon MeeMeepGoButton];
        }
        else if ([GUICommon isMyBid:bid accessToken:[restDeligate getAccessToken]]) {
            // bid owner can withdraw an active bid
            buttonTitle = WithdrawBidTitle;
            buttonColor = [GUICommon MeeMeepWarningButton];
        }
    }
    
    if(buttonTitle) {
        [btnActions setTitle:buttonTitle];
        [btnActions setTintColor:buttonColor];
        self.navigationItem.rightBarButtonItem = btnActions;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    [detailTableView reloadData];
}

-(void)onRatingChange:(NSInteger)rating {
    //
}

- (void) showAlertOnFailureToRetrieveBid: (NSString*) message {
    [loadingDialog removeView];
    loadingBidDetails = false;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"We were unable to contact MeeMeep. Please check your connection settings, or try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];

    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void) onAsyncActivityFailure:(NSError *)error {
    [self performSelectorOnMainThread:@selector(showAlertOnFailureToRetrieveBid:) withObject:[error localizedDescription] waitUntilDone:YES];
}

- (void) onAsyncActivityCompletion:(id<MMAsyncActivityResult>)result {
    if (result != nil) {
        if ([result isKindOfClass:[MMRetrieveBidDetailActivityResult class]]) {
            MMRetrieveBidDetailActivityResult *detailResult = (MMRetrieveBidDetailActivityResult *) result;
            [self performSelectorOnMainThread:@selector(updateBidDetails:) withObject:detailResult.retrievedBidDetail waitUntilDone:YES];
        }
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    switch (indexPath.row) {
        case 0:
        {
            KeyValueTableViewCell* myCell = [GUICommon getKeyValueTableViewCell:tableView];
            myCell.key.text = @"Username";
            myCell.value.text = [GUICommon formatForString:bid.userName];
            cell = myCell;
        }
            break;
        case 1:
        {
            RatingTableViewCell* myCell = [GUICommon getRatingTableViewCell:tableView];
            [myCell setUpCellWithRating:[[GUICommon formatForNumber:bid.userRating] intValue] isEditable:NO andDelegate:self];
            cell = myCell;
        }
            break;
        case 2:
        {
            KeyValueTableViewCell* myCell = [GUICommon getKeyValueTableViewCell:tableView];
            myCell.key.text = @"Amount";
            myCell.value.text = [GUICommon formatCurrency:bid.price];
            cell = myCell;
        }
            break;
        case 3:
        {
            if(bid.pickupTime) {
                DoubleKeyValueTableViewCell* myCell = [GUICommon getDoubleKeyValueTableViewCell:tableView];
                myCell.key.text = @"Pick-up";
                myCell.value.text = [GUICommon formatDate:bid.pickupDate];
                myCell.value2.text = bid.pickupTime;
                cell = myCell;
            } else {
                KeyValueTableViewCell* myCell = [GUICommon getKeyValueTableViewCell:tableView];
                myCell.key.text = @"Pick-up";
                myCell.value.text = [GUICommon formatDate:bid.pickupDate];
                cell = myCell;
            }
        }
            break;
        case 4:
        {
            if(bid.deliveryTime) {
                DoubleKeyValueTableViewCell* myCell = [GUICommon getDoubleKeyValueTableViewCell:tableView];
                myCell.key.text = @"Delivery";
                myCell.value.text = [GUICommon formatDate:bid.deliveryDate];
                myCell.value2.text = bid.deliveryTime;
                cell = myCell;
            } else {
                KeyValueTableViewCell* myCell = [GUICommon getKeyValueTableViewCell:tableView];
                myCell.key.text = @"Delivery";
                myCell.value.text = [GUICommon formatDate:bid.deliveryDate];
                cell = myCell;
            }
        }
            break;
        case 5:
        {
            KeyValueTableViewCell* myCell = [GUICommon getKeyValueTableViewCell:tableView];
            myCell.key.text = @"Delivery Method";
            myCell.value.text = [GUICommon formatForString:bid.deliveryVehicle];
            cell = myCell;
        }
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    // Create label with section title
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(20, 6, 300, 60);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [GUICommon MeeMeepHeadingText];
    
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = sectionTitle;
    label.numberOfLines = 2;
    
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    [view addSubview:label];
    
    return view;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (!loadingBidDetails && bid != nil)
    {
        return [NSString stringWithFormat:@"%@'s Quote", [GUICommon formatForString:bid.userName]];
    }
    return @"";
}

@end
