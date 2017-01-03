//
//  WithdrawBidViewController.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 9/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "WithdrawBidViewController.h"

#import "MMAsyncActivityManagementImpl.h"
#import "MMWithdrawBidAsyncActivityResult.h"
#import "MMWithdrawBidAsyncActivity.h"

// TODO refactor this with AcceptBidViewController (this is a copy but with Withdraw)
@implementation WithdrawBidViewController

@synthesize labelConfirmTitle;

@synthesize navController;

@synthesize dummyTextField;

@synthesize activityManagement;

@synthesize btnWithdraw;

-(IBAction)btnWithdrawClick{
    DLog(@"User requested withdraw quote %@", bid.bidId);
    
    //Start asynchronis activity
    MMWithdrawBidAsyncActivity* activity = [[MMWithdrawBidAsyncActivity alloc] initWithActivityDelegate:self restDelegate:restDeligate bidIdToReject:bid.bidId];
    
    WithdrawingBid = true;
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
    return self;
}



-(id) initWithBidDetail: (id<GUIRestDeligate>) commandObj bidDetail:(MMBidDetail*) bidDetail andNavigationController:(UINavigationController *) nc{
    self = [self initWithCommandObject:commandObj];
    if (self) {
        self.navController = nc;
        bid = bidDetail;
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

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {

    if ([alertView.title isEqualToString:@"Done!"]) {
        [restDeligate setShouldUpdateJobDetail:YES];
        [restDeligate setShouldUpdateMyJobs:YES];
        [restDeligate setShouldUpdateRecentJobs:YES];
        [restDeligate setShouldUpdateBids:YES];
        [restDeligate setShouldUpdateMatchingJobs:YES];
        
        [self dismissModalViewControllerAnimated:YES];
    }
}


- (void) updateBidConfirmed:(MMBidDetail*) confirmationObject {

    [loadingDialog removeView];
    WithdrawingBid = false;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Done!"
                                                        message:[NSString stringWithFormat:@"You have successfully Withdrawn your quote of $%@.",bid.price]
                                                       delegate:self
                                              cancelButtonTitle:@"ok"
                                              otherButtonTitles:nil
                              ];
    
    [alertView show];
}


- (void) showAlertOnFailureToConnect: (NSString*) message{
    [loadingDialog removeView];	
    
    NSString *alertMessage = @"We were unable to contact MeeMeep. ";
    alertMessage = [alertMessage stringByAppendingString:((message) ? message : @"Please check your connection settings, or try again.")];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:alertMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
    WithdrawingBid = false;
}


- (void) showAlertOnFailureToConfirm: (NSString*) message{
    [loadingDialog removeView];
    
    NSString *alertMessage = @"Unable to Withdraw quote. ";
    alertMessage = [alertMessage stringByAppendingString:((message) ? message : @"Please check your connection settings, or try again.")];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:alertMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
    WithdrawingBid = false;
}

- (void) onAsyncActivityFailure:(NSError *)error {
    [self performSelectorOnMainThread:@selector(showAlertOnFailureToConnect:) withObject:[error localizedDescription] waitUntilDone:NO];
}


- (void) onAsyncActivityCompletion:(id<MMAsyncActivityResult>)result {    
    if (result != nil) {
        if ([result isKindOfClass:[MMWithdrawBidAsyncActivityResult class]]) {
            
            MMWithdrawBidAsyncActivityResult* confirmationResult = (MMWithdrawBidAsyncActivityResult *) result;
            
            if (confirmationResult.bidRejectStatus == MMAsyncBidRejectResultSuccess){
                [self performSelectorOnMainThread:@selector(updateBidConfirmed:) withObject:confirmationResult waitUntilDone:YES];
            } else {
                NSString *errorMessage = @"Unexpected Error - Quote Withdrawal failed.";
                
                [self performSelectorOnMainThread:@selector(showAlertOnFailureToConfirm:) withObject:errorMessage waitUntilDone:YES];
            }
        }
    }
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Withdraw Quote";
    
    labelConfirmTitle.text = [NSString stringWithFormat:@"Withdraw %@'s quote (%@)",
                              [GUICommon formatForString:bid.userName],
                              [GUICommon formatCurrency:bid.price]
                              ];
    
    
    //Style withdraw button
    NSArray* normalColors = [GUICommon MeeMeepActionButtonGradient];
    NSArray* highlightedColors =  [GUICommon MeeMeepActionButtonGradientHighlighted];
    [btnWithdraw setGradientColor:highlightedColors forState:UIControlStateHighlighted];
    [btnWithdraw setGradientColor:normalColors forState:UIControlStateNormal]; 
     
    // Do any additional setup after loading the view from its nib.
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



@end
