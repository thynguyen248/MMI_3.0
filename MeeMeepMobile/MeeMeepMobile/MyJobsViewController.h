//
//  MyJobsViewController.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 1/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobSummaryTableViewCell.h"
#import "JobDetailViewController.h"
#import "GUIViewInterface.h"
#import "JobSummaryTableViewCell.h"

#import "MMAsyncActivityDelegate.h"
#import "MMAsyncActivityManagement.h"
#import "LoadingView.h"
#import "MMNamedJobSearchRequest.h"

@interface MyJobsViewController : UIViewController <GUIViewInterface, UITableViewDelegate, UITableViewDataSource,MMAsyncActivityDelegate>{
    
    id<GUIRestDeligate> restDeligate;
    
    UINib *cellLoader;
    
    NSNumber* userId;
    
    BOOL loadingJobs;
    LoadingView* loadingDialog;
    UIView *segmentedControlView;
    
    NSInteger selectedSearchId;
    
    NSMutableDictionary* postedJobs;
    NSMutableDictionary* movingJobs;
}

@property (nonatomic, strong) id<MMAsyncActivityManagement> activityManagement;
@property (nonatomic, strong) IBOutlet UITableView* myJobsTableView;
@property (nonatomic, strong) IBOutlet UIView *segmentedControlView;

@property (nonatomic, strong) IBOutlet GradientButtonControl *postedButton;
@property (nonatomic, strong) IBOutlet GradientButtonControl *movingButton;

@property (nonatomic,strong)  UIBarButtonItem* btnRefresh;

- (NSInteger) getIndexFromSelectedButton:(id) sender;

- (IBAction) searchSelectorButtonTouchedDown:(id) sender;

- (void) configureUIForJobCurrentSelection;

-(void) resetViewController;


@end
