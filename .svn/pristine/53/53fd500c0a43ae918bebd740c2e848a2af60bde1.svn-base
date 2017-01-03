//
//  CompositeAsyncActivity.h
//  MeeMeepMobile
//
//  Created by casper on 8/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMReAuthenticatingActivity.h"
#import "MMRestClient.h"
#import "MMAsyncActivityResult.h"
#import "MMCompositeActivityResult.h"

@interface MMCompositeAsyncActivity : MMReAuthenticatingActivity

@property (strong, nonatomic) NSArray* activities;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)activityDelegate restDelegate:(id<GUIRestDeligate>)restDelegate activities:(NSArray*)activities;

@end
