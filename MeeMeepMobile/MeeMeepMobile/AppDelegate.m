//
//  AppDelegate.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 24/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "InitializerViewController.h"

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
        
    //Creates the window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    

    InitializerViewController* viewController = [[InitializerViewController alloc] initWithWindow:self.window];
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self.window setRootViewController:navController];
    return YES;
}

// Called when unserialized
- (id) initWithCoder: (NSCoder *)coder {
    if (self = [super init]) {
        //self.username = [coder decodeObjectForKey:@"username"];
    }
    return self;
}

// Called when serialized
- (void) encodeWithCoder: (NSCoder *)coder {
    //[coder encodeObject: self.username forKey:@"username"];
}

- (void)applicationWillResignActive:(UIApplication *)application{}
- (void)applicationDidEnterBackground:(UIApplication *)application{}
- (void)applicationWillEnterForeground:(UIApplication *)application{}
- (void)applicationDidBecomeActive:(UIApplication *)application{}
- (void)applicationWillTerminate:(UIApplication *)application{}
- (void)tabBarController:(UITabBarController *)ptabBarController didSelectViewController:(UIViewController *)pviewController{}

@end
