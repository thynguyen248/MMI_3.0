//
//  MyJobsViewController.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 1/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "MyJobsViewController.h"
#import "MMAsyncActivityManagementImpl.h"

#import "MMNamedJobSearchRequest.h"
#import "MMJobSearchAsyncActivity.h"
#import "MMJobSearchAsyncActivityResult.h"

#import "MMRestJobsSearchParams.h"

#import "GradientButtonControl.h"

@implementation MyJobsViewController

NSString* const POSTED_OPEN = @"Deliveries open for quotes";
NSString* const POSTED_IN_PROGRESS = @"Deliveries in progress";
NSString* const POSTED_COMPLETED = @"Deliveries that have been completed";

NSString* const MOVING_OPEN = @"Deliveries I have bid on";
NSString* const MOVING_IN_PROGRESS = @"Deliveries I am making";
NSString* const MOVING_COMPLETED = @"Deliveries I have completed";

@synthesize myJobsTableView;
@synthesize activityManagement;

@synthesize segmentedControlView;

@synthesize movingButton, postedButton;

@synthesize btnRefresh;

NSInteger const NUMBER_OF_SECTIONS = 3;

-(void) resetViewController {
    [postedJobs removeAllObjects];
    [movingJobs removeAllObjects];
    [myJobsTableView reloadData];
}

-(id) initWithCommandObject: (id<GUIRestDeligate>) commandObj {
    if(self = [super init]) {
        restDeligate = commandObj;
        [GUICommon setBackButton:self.navigationItem];
        
        postedJobs = [[NSMutableDictionary alloc] initWithCapacity:NUMBER_OF_SECTIONS];
        movingJobs = [[NSMutableDictionary alloc] initWithCapacity:NUMBER_OF_SECTIONS];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [GUICommon setBackButton:self.navigationItem];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    DLog(@"Memory warning!");
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    DLog(@"Dashboard view did load!");
    [super viewDidLoad];
    
    btnRefresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshData)];
    self.navigationItem.rightBarButtonItem = btnRefresh;
    
    self.activityManagement = [[MMAsyncActivityManagementImpl alloc] init];

    loadingJobs = NO;
    self.view.backgroundColor = [UIColor grayColor];
    self.myJobsTableView.rowHeight=90;
    
    selectedSearchId = 0;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    NSMutableDictionary *movingButtonAttrs = [[NSMutableDictionary alloc] init];
    [movingButtonAttrs setValue:@"MovingButton" forKey:@"ButtonName"];
    movingButton.attributes = movingButtonAttrs;
    
    NSMutableDictionary *postedButtonAttrs = [[NSMutableDictionary alloc] init];
    [postedButtonAttrs setValue:@"PostedButton" forKey:@"ButtonName"];
    postedButton.attributes = postedButtonAttrs;

    
    // set up the job search selector here!
    [movingButton setGradientColor:[GUICommon MeeMeepButtonGradientGray] forState:UIControlStateNormal];
    [movingButton setGradientColor:[GUICommon MeeMeepActionButtonGradientHighlighted] forState:UIControlStateHighlighted];

    [postedButton setGradientColor:[GUICommon MeeMeepActionButtonGradient] forState:UIControlStateNormal];
    [postedButton setGradientColor:[GUICommon MeeMeepActionButtonGradientHighlighted] forState:UIControlStateHighlighted];
}


- (void)viewDidUnload
{
    DLog(@"Dashboard view did unload");
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for .supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated{
    //This is a transport provider and the segmented control is not present so we need to add it.
    if([restDeligate getUserProfile].isTransportProvider && segmentedControlView.superview == nil) {
        [self.view addSubview:segmentedControlView];
        CGRect segmentedFrame = segmentedControlView.frame;
        
        CGRect tableFrame = myJobsTableView.frame;
        tableFrame.origin.y += segmentedFrame.size.height;
        tableFrame.size.height -= segmentedFrame.size.height;
        myJobsTableView.frame = tableFrame;
    //This is not a transport provider and the segmented control is present so we need to remove it.        
    } else if(![restDeligate getUserProfile].isTransportProvider && segmentedControlView.superview != nil){
        CGRect segmentedFrame = segmentedControlView.frame;
        [segmentedControlView removeFromSuperview];
        
        CGRect tableFrame = myJobsTableView.frame;
        tableFrame.origin.y = segmentedFrame.origin.y;
        tableFrame.size.height += segmentedFrame.size.height;
        myJobsTableView.frame = tableFrame;
        
        //Make sure that the posted stuff is displayed for a standard user
        [self searchSelectorButtonTouchedDown:postedButton];
    }
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    DLog(@"MyJobs View did appear");
    
    
    //Update jobs if needed
    if ([restDeligate getShouldUpdateMyJobs]) {
        [self refreshData];
    }
    
    
    DLog(@"MyJobs: View will appear complete!");
}

- (void) refreshData {
    if (!loadingJobs) {
        DLog(@"MyJobs: Loading jobs...");
        [restDeligate setShouldUpdateMyJobs:false];
        loadingJobs = true;
        loadingDialog = [[LoadingView alloc] loadingViewInView:self.view];
        
        DLog(@"MyJobs: dispatching search request activity");
        MMJobSearchAsyncActivity *activity = [[MMJobSearchAsyncActivity alloc] initWithActivityDelegate:self restDelegate:restDeligate];
        [self.activityManagement dispatchMMAsyncActivity:activity];
    }
}

- (void)viewWillDisappear:(BOOL)animated{[super viewWillDisappear:animated];}
- (void)viewDidDisappear:(BOOL)animated{[super viewDidDisappear:animated];}

#pragma mark - search emphasis button handlers

- (void) searchSelectorButtonTouchedDown:(id) sender {
    if (sender != nil && [sender isKindOfClass:[GradientButtonControl class]]) {
        // get index of the button
        
        selectedSearchId = [self getIndexFromSelectedButton:sender];
        
        [self configureUIForJobCurrentSelection];
    
        DLog(@"selected tab %d", selectedSearchId);
        if (selectedSearchId >= 0) {
            [myJobsTableView reloadData];
        }
    }
}

- (void) configureUIForJobCurrentSelection {
    // set the current selected id as the depressed button
    // un set all other buttons
    if (selectedSearchId >= 0) {
        // 0 == posted
        switch (selectedSearchId) {
            // if posted is selected - posted should be blue - moving should be gray
            case 0:
                [postedButton setGradientColor:[GUICommon MeeMeepActionButtonGradient] forState:UIControlStateNormal];
                [postedButton setGradientColor:[GUICommon MeeMeepActionButtonGradientHighlighted] forState:UIControlStateHighlighted];
                [movingButton setGradientColor:[GUICommon MeeMeepButtonGradientGray] forState:UIControlStateNormal];
                [movingButton setGradientColor:[GUICommon MeeMeepButtonGradientGray] forState:UIControlStateHighlighted];
                
                break;
            case 1:
                [postedButton setGradientColor:[GUICommon MeeMeepButtonGradientGray] forState:UIControlStateNormal];
                [postedButton setGradientColor:[GUICommon MeeMeepButtonGradientGray] forState:UIControlStateHighlighted];
                [movingButton setGradientColor:[GUICommon MeeMeepActionButtonGradient] forState:UIControlStateNormal];
                [movingButton setGradientColor:[GUICommon MeeMeepActionButtonGradientHighlighted] forState:UIControlStateHighlighted];
            default:
                break;
        }
        
    }
}

- (NSInteger) getIndexFromSelectedButton:(id) sender {
    if (sender != nil && [sender isKindOfClass:[GradientButtonControl class]]) {
        GradientButtonControl *btn = (GradientButtonControl *) sender;
        NSDictionary *attrs = btn.attributes;
        NSString *buttonName = [attrs objectForKey:@"ButtonName"];
        DLog(@"Button name: %@", buttonName);
        
        if ([buttonName isEqualToString:@"MovingButton"]) {
            return 1;
        } else  if ([buttonName isEqualToString:@"PostedButton"]) {
            return 0;
        } else return -1;
    }
    
    return -1;
}

#pragma mark - Async


- (void) updateAllLists:(MMJobSearchAsyncActivityResult *) result {
    DLog(@"MyJobs: updating results");
    [postedJobs removeAllObjects];
    [movingJobs removeAllObjects];
    
    for(MMJobSummary* postedJob in result.postedArray)
    {
        DLog(@"job: %@", postedJob.title);
        NSString* status = [self stringForStatus:postedJob.jobStatus];
        NSMutableArray* jobsForStatus = [postedJobs objectForKey:status];
        if(!jobsForStatus) {
            jobsForStatus = [[NSMutableArray alloc] init];
            [postedJobs setValue:jobsForStatus forKey:status];
        }
        [jobsForStatus addObject:postedJob];
    }
    
    [self getFromDictionary:result.movingDictionary withKey:@"biddingOn" andAddTo:movingJobs withKey:MOVING_OPEN];
    [self getFromDictionary:result.movingDictionary withKey:@"moving" andAddTo:movingJobs withKey:MOVING_IN_PROGRESS];
    [self getFromDictionary:result.movingDictionary withKey:@"completed" andAddTo:movingJobs withKey:MOVING_COMPLETED];
    
    [loadingDialog removeView];
    loadingJobs=false;
    [myJobsTableView reloadData];
}

- (void) getFromDictionary:(NSDictionary*)fromDict withKey:(NSString*)fromKey andAddTo:(NSMutableDictionary*)toDict withKey:(NSString*)toKey
{
    if(fromDict && fromKey && toDict && toKey)
    {
        id obj = [fromDict objectForKey:fromKey];
        if(obj) {
            [toDict setObject:obj forKey:toKey];
        }
    }
}

- (NSString*) stringForStatus:(MMJobStatus*)status {
    switch (status.status) {
        case JOB_CREATED:
            return POSTED_OPEN;
            
        case AWAITING_CUSTOMER_COMPLETION:
        case BID_ACCEPTED:
        case DISPUTED:
            return POSTED_IN_PROGRESS;
            
        case COMPLETED:
        case CLOSED:
            return POSTED_COMPLETED;
            
        case JOB_CANCELLED:
        case JOB_EXPIRED:
            return @"";
    }
    return @"";
}


- (void) showAlertOnFailureToRetrieveJobs {
    [loadingDialog removeView];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"We were unable to contact MeeMeep. Please check your connection settings, or try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    loadingJobs=false;
    [myJobsTableView reloadData];

    [self.navigationController popViewControllerAnimated:TRUE];
}


- (void) onAsyncActivityFailure:(NSError *)error {
    DLog(@"Activity error");
    [self performSelectorOnMainThread:@selector(showAlertOnFailureToRetrieveJobs) withObject:nil waitUntilDone:NO];
}


- (void) onAsyncActivityCompletion:(id<MMAsyncActivityResult>)result {
    DLog(@"Activity Complete!");
    if (result != nil) {
        if ([result isKindOfClass:[MMJobSearchAsyncActivityResult class]]) {
            MMJobSearchAsyncActivityResult *jobsResult = (MMJobSearchAsyncActivityResult *) result;
            [self performSelectorOnMainThread:@selector(updateAllLists:) withObject:jobsResult waitUntilDone:NO];
        }
    }
}


#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return NUMBER_OF_SECTIONS;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DLog(@"Number of rows in section");
    NSDictionary* dict = [self getCurrentDictionary];
    if(dict)
    {
        NSArray* sectionArray = [dict valueForKey:[self tableView:tableView titleForHeaderInSection:section]];
        return (sectionArray != nil && [sectionArray count] > 0) ? [sectionArray count] : 1;
    }
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // draw a rect to be the width of the table view and about 10 pixels high
    NSInteger width = tableView.bounds.size.width;
    
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    
    // create a gradient
    NSArray *gradientColourArray = [GUICommon MeeMeepButtonGradientGray];
    
    // add the section from the map
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = sectionHeaderView.frame;
    
    [gradientLayer setColors:gradientColourArray];

    [sectionHeaderView.layer insertSublayer:gradientLayer atIndex:0];
    
    // create a label and attach it as a subview
    
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 2, width, 25)];
    
    sectionLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    sectionLabel.font = [UIFont systemFontOfSize:15.0];
    sectionLabel.backgroundColor = [UIColor clearColor];
    
    [sectionHeaderView addSubview:sectionLabel];
    
    return sectionHeaderView;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch(selectedSearchId) {
        case 0:
            switch (section) {
                case 0:
                    return POSTED_OPEN;
                    
                case 1:
                    return POSTED_IN_PROGRESS;
                    
                case 2:
                    return POSTED_COMPLETED;
            }
        case 1:
            switch (section) {
                case 0:
                    return MOVING_OPEN;
                    
                case 1:
                    return MOVING_IN_PROGRESS;
                    
                case 2:
                    return MOVING_COMPLETED;
            }
    }
    return @"";
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* results = [self getResultsWithTableView:tableView andSection:indexPath.section];
    if (results == nil || [results count] == 0) {
        return 44; //Appropriate height for this type of cell
    } else {
        JobSummaryTableViewCell* jobCell = [GUICommon getJobSummaryTableViewCell:tableView];
        return jobCell.frame.size.height;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cellToRender = nil;
    
    // create the default cell to render
    CustomTableViewCell *defaultCell = [GUICommon getCustomTableViewCell:tableView];
    
    defaultCell.userInteractionEnabled = NO;
    defaultCell.textLabel.font = [UIFont systemFontOfSize:15.0];

    if (loadingJobs) {
        defaultCell.textLabel.text = @"Loading Deliveries ...";
        cellToRender = defaultCell;
    } else {
        // find the section results
        NSArray* results = [self getResultsWithTableView:tableView andSection:indexPath.section];
        
        MMJobSummary *summary;
        
        if ([results count] == 0 || (summary = [results objectAtIndex:indexPath.row]) == nil) {
            defaultCell.textLabel.text = @"No Deliveries Available";
            cellToRender = defaultCell;
        }
        else
        {
            //Create job summary cell            
            //Populate cell with info
            JobSummaryTableViewCell* jobCell = [GUICommon getJobSummaryTableViewCell:tableView];
            jobCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            jobCell.jobSummary = summary;
            [jobCell update];
            
            cellToRender = jobCell;
            
        }
    }
    
    assert(cellToRender != nil);
    return cellToRender;
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Get summary object for row
    MMJobSummary *summary = [[self getResultsWithTableView:tableView andSection:indexPath.section] objectAtIndex:indexPath.row];
    
    //Create and execute job detail controller (passing summary)
    JobDetailViewController* newView = [[JobDetailViewController alloc] initWithDelegate:restDeligate andJobId:summary.jobId];
    [self.navigationController pushViewController:newView animated:YES];
    
}

-(NSArray*) getResultsWithTableView:(UITableView*)tableView andSection:(NSInteger)section {
    NSDictionary* resultsDictionary = [self getCurrentDictionary];
    if(resultsDictionary == nil || [resultsDictionary count] == 0) {
        return [[NSArray alloc] init];
    }
    return [resultsDictionary valueForKey:[self tableView:tableView titleForHeaderInSection:section]];
}

-(NSDictionary*) getCurrentDictionary {
    if (selectedSearchId == 0) {
        return postedJobs;
    }
    return movingJobs;
}


@end
