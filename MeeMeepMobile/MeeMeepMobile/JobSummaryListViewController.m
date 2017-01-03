//
//  JobSummaryListViewController.m
//  MeeMeepMobile
//
//  Created by Julian Raff on 26/03/13.
//
//

#import "JobSummaryListViewController.h"

#import "MMAsyncActivityManagementImpl.h"
#import "MMRetrieveJobsSummaryListActivityResult.h"
#import "MMRetrieveJobSummaryListActivity.h"

@implementation JobSummaryListViewController

@synthesize jobsTableView;
@synthesize btnRefresh;

- (MMAsyncActivity*) getActivity {
    DLog(@"%@", [self class]);
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (Boolean) getShouldUpdateJobs {
    DLog(@"%@", [self class]);
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void) setShouldUpdateJobs:(Boolean)b {
    DLog(@"%@", [self class]);
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Do any additional setup after loading the view.
    
    btnRefresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshData)];
    self.navigationItem.rightBarButtonItem = btnRefresh;
    
    DLog(@"Frame Height: %f", self.view.frame.size.height);
    
    jobsTableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [jobsTableView setBackgroundColor:[GUICommon MeeMeepBackground]];
    
    [self.view addSubview:jobsTableView];
    
    [jobsTableView setDataSource:self];
    [jobsTableView setDelegate:self];
    
    jobsTableView.rowHeight = 90;
}

-(id) initWithCommandObject: (id<GUIRestDeligate>) commandObj {
    if(self = [super init]) {
        restDeligate = commandObj;
        activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
        [GUICommon setBackButton:self.navigationItem];
        summaries = [[NSMutableArray alloc] init];
    }
    
    return self;
}


#pragma mark - View lifecycle

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //Setup the frame here as our frame will have been properly initialised.
    [jobsTableView setFrame:self.view.frame];    
    
    if ([self getShouldUpdateJobs]) {
        [self refreshData];
    }
}

- (void) refreshData {
    if (loadingJobs==false) {
        loadingJobs = true;
        [self setShouldUpdateJobs:false];
        loadingDialog = [[LoadingView alloc] loadingViewInView:self.view];
        
        [activityManagement dispatchMMAsyncActivity:[self getActivity]];
    }
}


- (void)viewWillAppear:(BOOL)animated {[super viewWillAppear:animated];}
- (void)viewWillDisappear:(BOOL)animated{[super viewWillDisappear:animated];}
- (void)viewDidDisappear:(BOOL)animated{[super viewDidDisappear:animated];}



#pragma mark - Async

- (void) clearList {
    @synchronized (summaries) {
        [summaries removeAllObjects];
        [self setShouldUpdateJobs:YES];
    }
}

- (void) updateSummariesList:(NSArray *) jobsList {
    
    @synchronized (summaries) {
        
        DLog(@"Updating jobs with %d new jobs", [jobsList count]);
        [summaries removeAllObjects];
        
        [summaries addObjectsFromArray:jobsList];
        DLog(@"Summaries list size after update from async activity [%d]", [summaries count]);
    }
    [loadingDialog removeView];
    loadingJobs=false;
    [jobsTableView reloadData];
}

- (void) showAlertOnFailureToRetrieveJobs {
    [loadingDialog removeView];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"We were unable to contact MeeMeep. Please check your connection settings, or try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    loadingJobs=false;
    
    [jobsTableView reloadData];
}

- (void) onAsyncActivityFailure:(NSError *)error {
    [self performSelectorOnMainThread:@selector(showAlertOnFailureToRetrieveJobs) withObject:nil waitUntilDone:NO];
}


- (void) onAsyncActivityCompletion:(id<MMAsyncActivityResult>)result {
    if (result != nil) {
        if ([result isKindOfClass:[MMRetrieveJobsSummaryListActivityResult class]]) {
            MMRetrieveJobsSummaryListActivityResult *jobsResult = (MMRetrieveJobsSummaryListActivityResult *) result;
            [self performSelectorOnMainThread:@selector(updateSummariesList:) withObject:jobsResult.jobSummaryList waitUntilDone:NO];
        }
    }
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger numberOfRows = 1;
    @synchronized (summaries) {
        DLog(@"Summaries in row number query [%d]", [summaries count]);
        if ([summaries count] > 0) {
            numberOfRows = [summaries count];
        }
    }
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([summaries count]==0){ //if no jobs exist
        //Create default cell
        CustomTableViewCell *cell = [GUICommon getCustomTableViewCell:tableView];
        
        //Check if loading jobs and populate with info
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        if (loadingJobs==true){
            cell.textLabel.text = @"Loading Deliveries ...";
        } else {
            cell.textLabel.text = @"No Deliveries Avaliable";
        }
        [cell setUserInteractionEnabled:FALSE];
        return cell;
    } else {
        
        //Create job summary cell
        JobSummaryTableViewCell* cell =[GUICommon getJobSummaryTableViewCell:tableView];
        
        //Populate cell with info
        MMJobSummary* summary = (MMJobSummary*)[summaries objectAtIndex:[indexPath row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.jobSummary = summary;
        [cell update];
        return cell;
    }
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Get summary object for row
    MMJobSummary* summary = (MMJobSummary*)[summaries objectAtIndex:[indexPath row]];
    
    //Create and execute job detail controller (passing summary)
    JobDetailViewController* newView = [[JobDetailViewController alloc] initWithDelegate:restDeligate andJobId:summary.jobId];
    [self.navigationController pushViewController:newView animated:YES];
}

@end
