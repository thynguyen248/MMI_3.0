//
//  AppDelegate.h
//  MeeMeepMobile
//
//  App delegate defines most major functionality of the application and is passed
//  to view controllers using the RestDeligate interface
//
//  App deligate is also responsible for the setup of (and interaction with) the 
//  tabBarController that forms the basis of the app
//
//  Created by Greg Soertsz on 24/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <NSCoding, UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
