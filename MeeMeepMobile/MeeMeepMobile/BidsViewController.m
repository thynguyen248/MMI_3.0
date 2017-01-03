//
//  BidsViewController.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 1/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "BidsViewController.h"

#import "MMRestClient.h"
#import "MMRestJobsClient.h"
#import "MMRestAccessToken.h"

#import "MMAsyncActivityManagementImpl.h"
#import "MMRetrieveBidSummaryListActvityResult.h"
#import "MMRetrieveBidSummaryAsyncActivity.h"

@implementation BidsViewController


@synthesize bidTableView;

@synthesize activityManagement;


-(id) initWithCommandObject: (id<GUIRestDeligate>) commandObj {
    self = [super init];
    restDeligate = commandObj;
    self.activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
    [GUICommon setBackButton:self.navigationItem];
    return self;
}


-(id) initWithJob:(id<GUIRestDeligate>)commandObj job:(MMJobDetail*)jobDetail{
    self = [self initWithCommandObject: commandObj];
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
    
    [self refreshData];
}

-(void)refreshData {
    loadingBids = true;
    loadingDialog = [[LoadingView alloc] loadingViewInView:self.view];
    
    [self.activityManagement dispatchMMAsyncActivity:[[MMRetrieveBidSummaryAsyncActivity alloc] initWithActivityDelegate:self restDelegate:restDeligate forJobId:thisJob.jobId]];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([restDeligate getShouldUpdateBids] == TRUE){
        [self refreshData];
        [restDeligate setShouldUpdateBids:FALSE];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


- (void) updateBidsList:(NSArray *) bidsList {
    @synchronized (bids) {
        DLog(@"Updating bids with %d new bids", [bidsList count]);
        bids = bidsList;
    }
    [loadingDialog removeView];
    loadingBids=false;
    [bidTableView reloadData];
}


- (void) showAlertOnFailureToRetrieveBids{
    [loadingDialog removeView];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"We were unable to contact MeeMeep. Please check your connection settings, or try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
    loadingBids=false;
    [bidTableView reloadData];

    [self.navigationController popViewControllerAnimated:TRUE];
}



- (void) onAsyncActivityFailure:(NSError *)error {
    [self performSelectorOnMainThread:@selector(showAlertOnFailureToRetrieveBids) withObject:nil waitUntilDone:NO];
}

- (void) onAsyncActivityCompletion:(id<MMAsyncActivityResult>)result {
    if (result != nil) {
        if ([result isKindOfClass:[MMRetrieveBidSummaryListActvityResult class]]) {
            
            MMRetrieveBidSummaryListActvityResult *bidsResult = (MMRetrieveBidSummaryListActvityResult*) result;
            [self performSelectorOnMainThread:@selector(updateBidsList:) withObject: bidsResult.retrievedBidSummaryList waitUntilDone:NO];
            
        }
    }
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(loadingBids)
    {
        // need to display 'loading' label 
        return 1;
    }
    if ([bids count] > 0)
    {
        return [bids count];
    }
    
    // need to display 'no bids' and 'sign in' labels
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (loadingBids)
    {
        UITableViewCell* cell = [GUICommon getCustomTableViewCell:tableView];
        [cell.textLabel setText:@"Loading Quotes..."];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        [cell.textLabel setTextColor:[UIColor grayColor]];
        return cell;
    }
    
    @synchronized (bids) {
        if ([bids count] == 0)
        {
            CustomTableViewCell* myCell = [GUICommon getCustomTableViewCell:tableView];

            if(indexPath.row == 0)
            {
                [myCell.textLabel setText:@"No Quotes for this job"];
            }
            else if(indexPath.row == 1 && ![restDeligate isLoggedIn])
            {
                [myCell.textLabel setText:@"Sign in to quote on this job"];
            }
            
            myCell.userInteractionEnabled = NO;
            myCell.textLabel.font = [UIFont systemFontOfSize:15.0];
            [myCell.textLabel setTextColor:[UIColor grayColor]];
            return myCell;
        }
        
        BidSummaryTableViewCell* bsCell = [GUICommon getBidSummaryTableViewCell: tableView];
        
        MMBidSummary* summary = (MMBidSummary*)[bids objectAtIndex:[indexPath row]];
        [bsCell setupCellWithBidSummary:summary];
        
        MMRestAccessToken* accessToken = [restDeligate getAccessToken];
        BOOL canSelect = [GUICommon isMyBidSummary:summary accessToken:accessToken] || [GUICommon isOwnerOfJob:thisJob accessToken:accessToken];
        
        [bsCell setUserInteractionEnabled:canSelect];
        bsCell.accessoryType = canSelect ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
        
        return bsCell;
    }
}


#pragma mark - Table view delegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (loadingBids) {
        return tableView.rowHeight;
    }
    return 50;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(loadingBids || bids == nil || [bids count] == 0) {
        return;
    }
    
    MMBidSummary* bidSummary = [bids objectAtIndex:indexPath.row];
    
    BidDetailViewController* newView = [[BidDetailViewController alloc] initWithBidId:restDeligate bidId:bidSummary.bidId job:thisJob];
    [self.navigationController pushViewController:newView animated:YES];
}

@end
