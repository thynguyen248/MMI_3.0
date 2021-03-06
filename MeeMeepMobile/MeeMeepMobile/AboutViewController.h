//
//  AboutViewController.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 15/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GUIViewInterface.h"
#import "GUICommon.h"

#import "MMAsyncActivityDelegate.h"
#import "MMAsyncActivityManagement.h"
#import "LoadingView.h"


@interface AboutViewController : UIViewController <MMAsyncActivityDelegate, GUIViewInterface, UITableViewDelegate>{
    id<GUIRestDeligate> restDeligate;
    UIBarButtonItem* btnLogout;
    
    UIScrollView* scrollView;
    
    id<MMAsyncActivityManagement> activityManagement;
    BOOL loadingJobs;
    LoadingView* loadingDialog;
    NSString* version;
}

@property (nonatomic,strong) id<MMAsyncActivityManagement> activityManagement;

@property (nonatomic,strong) UIBarButtonItem* btnLogout;

@property (nonatomic,strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic,strong) IBOutlet UIView* viewToScroll;

@property (strong, nonatomic) IBOutlet UITableView *tbAbout;
@property (nonatomic,strong) IBOutlet UILabel* lblUserNote;

@property (strong, nonatomic) IBOutlet UILabel *lblVersion;

-(NSString*) getBundleVersion;

@end
