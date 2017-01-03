//
//  InitializerViewController.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 19/03/13.
//
//

#import <UIKit/UIKit.h>
#import "MMRestClient.h"
#import "MMRestClientFactoryImpl.h"
#import "MMRestJobsClient.h"
#import "RecentJobsViewController.h"
#import "MyJobsViewController.h"
#import "LoginViewController.h"
#import "GUIRestDeligate.h"
#import "AboutViewController.h"
#import "CreateJobViewController.h"
#import "CredentialsManagement.h"

#import "JobMatchingViewController.h"

@interface InitializerViewController : UIViewController<NSCoding, UIApplicationDelegate, UITabBarControllerDelegate, GUIRestDeligate, UIAlertViewDelegate> {
    id<MMRestClient> restClient;
    
    UITabBarController* tabBarController;
    
    
    //tabRecentJobs,tabCreateJob .etc are views that form tabs on the tabBarController by virtue of their respective navigation controllers
    RecentJobsViewController* tabRecentJobs;
    JobMatchingViewController* tabMatching;
    CreateJobViewController* tabCreateJob;
    MyJobsViewController* tabMyJobs;
    AboutViewController* tabAbout;
    
    
    /*
     Each view in the tabBarController is encapsulated in a navigation controller
     ie.
     tabRecentJobs is inside navRecentJobs which is an item on the tabController.
     (tabController -> NavigationController -> View)
     */
    UINavigationController* navRecentJobs;
    UINavigationController* navMatching;
    UINavigationController* navMyJobs;
    UINavigationController* navCreateJob;
    UINavigationController* navAbout;
    
    //Navigation Controller of the tabController
    UINavigationController* rootNav;
    
    MMUserProfile* myUserProfile;
    MMRestAccessToken* myAccessToken;
    MMConfig* config;
    
    BOOL shouldUpdateMyJobs;
    BOOL shouldUpdateRecentJobs;
    BOOL shouldUpdateMatchingJobs;
    BOOL shouldUpdateJobDetail;
    BOOL shouldUpdateBids;
    
    id<CredentialsManagement> credentialsManagement;
    UIWindow* window;
}

@property (nonatomic, strong) IBOutlet UIImageView* imageView;
@property (nonatomic,strong) MMRestAccessToken *myAccessToken;

-(id) initWithWindow:(UIWindow*) window;

@end
