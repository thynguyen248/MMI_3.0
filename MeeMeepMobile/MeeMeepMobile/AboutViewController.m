//
//  AboutViewController.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 15/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "AboutViewController.h"

#import "MMAsyncActivityManagementImpl.h"
#import "MMLogoutAsyncActivity.h"
#import "MMLogoutActivityResult.h"


@implementation AboutViewController

@synthesize btnLogout;

@synthesize scrollView, viewToScroll;

@synthesize activityManagement;

@synthesize lblUserNote;
@synthesize lblVersion;


-(id) initWithCommandObject: (id<GUIRestDeligate>) commandObj {
    self = [super init];
    restDeligate = commandObj;
    self.activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
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
    
    self.title=@"About";

    btnLogout = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(btnClicked:)];

    [scrollView addSubview:viewToScroll]; 
    scrollView.contentSize = CGSizeMake(viewToScroll.frame.size.width, viewToScroll.frame.size.height); 
    
    lblVersion.text = [NSString stringWithFormat:@"Version : %@", [self getBundleVersion]];
    ///Table Dynamic Cell Hieght
    self.tbAbout.rowHeight = UITableViewAutomaticDimension;
    self.tbAbout.estimatedRowHeight = 44;
}

-(NSString*) getBundleVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (void)viewDidUnload
{
    [self setLblVersion:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewWillAppear:(BOOL)animated{
    //Hide or show logout button - depending on login status
    if ([restDeligate isLoggedIn]==true){

        self.navigationItem.rightBarButtonItem = btnLogout; 
        
        MMRestAccessToken* accessToken = [restDeligate getAccessToken]; 
        NSString* note = [NSString stringWithFormat:@"You are currently logged in as %@", [GUICommon formatForString:accessToken.userName]];
        
        [lblUserNote setText:note];
        
    } else{
        self.navigationItem.rightBarButtonItem = nil; 
        [lblUserNote setText:@""];
    }
    

    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



-(void) btnClicked:(id)sender{
    
    loadingJobs = true;
    loadingDialog = [[LoadingView alloc] loadingViewInView:self.view];
    
    MMLogoutAsyncActivity *activity = [[MMLogoutAsyncActivity alloc]
                                       initWithActivityDelegate:self restDelegate:restDeligate];
    
    [self.activityManagement dispatchMMAsyncActivity:activity];
}





- (void) updateLogoutStatus{
    [restDeligate setShouldUpdateMyJobs:true];
    
    [loadingDialog removeView];
    loadingJobs=false;
    [restDeligate logout];
}





- (void) showAlertOnFailureToLogout {    
    [loadingDialog removeView];
    loadingJobs=false;
    [restDeligate logout];
}





- (void) onAsyncActivityFailure:(NSError *)error {
    DLog(@"ASYNC_FAILED");
    [self performSelectorOnMainThread:@selector(showAlertOnFailureToLogout) withObject:nil waitUntilDone:NO];
}





- (void) onAsyncActivityCompletion:(id<MMAsyncActivityResult>)result {
    DLog(@"ASYNC_COMPLETE");
    //if (result != nil) {
        //if ([result isKindOfClass:[MMLogoutActivityResult class]]) {
            //MMLogoutActivityResult* logoutResult = (MMLogoutActivityResult *) result;
            [self performSelectorOnMainThread:@selector(updateLogoutStatus) withObject:nil waitUntilDone:NO];
        //}
    //}
}






#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}





- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [GUICommon getMyTableViewCell:tableView];
    
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    cell.textLabel.font = [UIFont fontWithName: cell.textLabel.font.fontName size:15];

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text=@"MeeMeep Blog"; 
            break;
        case 1:
            cell.textLabel.text=@"Email Us Now";
            break;
        case 2: 
            cell.textLabel.text=@"Terms & Conditions";
            break;
        default:
            break;
    }
    
    return cell;
    
}






#pragma mark - Table view delegate


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://blog.meemeep.com"]];
    } else
    if (indexPath.row==1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://contact@meemeep.com"]];
    } else
    if (indexPath.row==2){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://meemeep.com/home/policies"]];
    }
}



@end
