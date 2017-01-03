//
//  JobSummaryListViewController.h
//  MeeMeepMobile
//
//  Created by Julian Raff on 26/03/13.
//
//

#import <UIKit/UIKit.h>
#import "JobSummaryTableViewCell.h"
#import "JobDetailViewController.h"
#import "JobSummaryTableViewCell.h"
#import "GUIViewInterface.h"

#import "MMAsyncActivityDelegate.h"
#import "MMAsyncActivityManagement.h"
#import "LoadingView.h"

@interface JobSummaryListViewController : UIViewController <GUIViewInterface, UITableViewDelegate, UITableViewDataSource, MMAsyncActivityDelegate>{
    
    BOOL loadingJobs;
    LoadingView* loadingDialog;
    id<MMAsyncActivityManagement> activityManagement;
    
    UITableView* jobsTableView;
    
    id<GUIRestDeligate> restDeligate;
    
    NSMutableArray* summaries;
}

@property (nonatomic, strong) IBOutlet UITableView *jobsTableView;
@property (nonatomic,strong)  UIBarButtonItem* btnRefresh;

- (MMAsyncActivity*) getActivity;
- (Boolean) getShouldUpdateJobs;
- (void) setShouldUpdateJobs:(Boolean)b;

- (void) clearList;

@end
