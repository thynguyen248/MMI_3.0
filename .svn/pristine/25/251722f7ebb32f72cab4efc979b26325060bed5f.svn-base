//
//  BaseCommsViewController.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 8/04/13.
//
//

#import <UIKit/UIKit.h>
#import "GradientButtonControl.h"
#import "GUIRestDeligate.h"
#import "GUIViewInterface.h"
#import "MMAsyncActivityDelegate.h"
#import "MMAsyncActivityManagement.h"
#import "LoadingView.h"

@interface BaseCommsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,
                                                      UITextViewDelegate, UIAlertViewDelegate,
                                                      GUIViewInterface,
                                                      MMAsyncActivityDelegate>
{
    id<GUIRestDeligate> restDelegate;
    id<MMAsyncActivityManagement> activityManagement;
    MMJobDetail* job;
    LoadingView* loadingDialog;
    
    BOOL loadingMessages;
    NSArray* messages;
    
    BOOL sendingMessage;
}

-(id) initWithCommandObject: (id<GUIRestDeligate>) commandObj job:(MMJobDetail*) initJob;
-(IBAction) sendButtonPressed:(id)sender;
-(IBAction) cancelButtonPressed:(id)sender;

@property (nonatomic,strong) IBOutlet UIView *messageBar;
@property (nonatomic,strong) IBOutlet UITextView *inptMessage;
@property (nonatomic,strong) IBOutlet GradientButtonControl* btnSend;
@property (nonatomic,strong) IBOutlet UITableView* tableView;
@property (nonatomic,strong) IBOutlet GradientButtonControl* btnCancel;

@property (nonatomic,strong)  UIBarButtonItem* btnRefresh;

@end
