//
//  JobDetailViewController.h
//  MeeMeepMobile
//
//  Displays details about a job
//  This view controller is part of the user workflow but has additional options for movers and shakers
//
//  - Uses async operation to get job detail (using job id)
//  - Displays job detail in table
//
//  Created by Aydan Bedingham on 1/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "GUIViewInterface.h"

#import "MMJobDetail.h"
#import "BidsViewController.h"
#import "StyledKeyValueTableViewCell.h"
#import "StyledKeyValueMultilineTableViewCell.h"
#import "DoubleKeyValueTableViewCell.h"
#import "BidsButtonTableViewCell.h"
#import "GUICommon.h"

#import "MMAsyncActivityDelegate.h"
#import "MMAsyncActivityManagement.h"
#import "LoadingView.h"

#import "CompleteJobViewController.h"
#import "CreateBidViewController.h"

#import "BidsMessagesLinkerCellDelegate.h"

#import "CommunicationsViewController.h"

#import "MWPhotoBrowser.h"
#import "GMMapAnnotation.h"

typedef enum {
    SectionDetails,
    SectionMessagesBids,
    SectionItems,
    SectionSpecialCons
} JobDetailSection;

@interface JobDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MMAsyncActivityDelegate, UIActionSheetDelegate, UIAlertViewDelegate,BidsMessagesLinkerCellDelegate, MWPhotoBrowserDelegate>{
    
    BOOL loadingData;
    
    LoadingView* loadingDialog;    
    id<MMAsyncActivityManagement> activityManagement;
    
    id<GUIRestDeligate> restDeligate;
    MMJobDetail* job;

    
    NSNumber* myJobId;
    NSString* baseUrl;
    
    UIButton* btnViewOnWebsite;
    
    NSDateComponents* timeLeft;
    
    UIBarButtonItem* btnLoginToBid;
    
    UIBarButtonItem* btnActions;
    
    UIActionSheet* actionSheet;
    
    NSMutableArray* photos;
    
    UIAlertView* failureToLoadJobsAlertView;
}

@property (nonatomic,strong) IBOutlet UIButton* btnViewOnWebsite;

@property (weak, nonatomic) IBOutlet UITableView *MainTableView;

@property (nonatomic, strong) id<MMAsyncActivityManagement> activityManagement;

@property (nonatomic,strong) IBOutlet UITableView* detailTableView;

@property (nonatomic, strong) GMMapAnnotation* mapPin;
@property (nonatomic, strong) MKMapView* mapView;
@property (nonatomic, strong) UIViewController* mapViewController;

-(id) initWithDelegate: (id<GUIRestDeligate>) commandObj andJobId: (NSNumber*) jobId;

-(IBAction) btnViewBidsClick;

-(IBAction) btnViewJobOnlineClick;

-(void) updateJobDetails:(MMJobDetail*)jobDetail;

-(void) finishLoading;


@end
