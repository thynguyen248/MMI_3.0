//
//  CompositeAsyncActivity.m
//  MeeMeepMobile
//
//  Created by casper on 8/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMCompositeAsyncActivity.h"

@implementation MMCompositeAsyncActivity

@synthesize activities;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)activityDelegate restDelegate:(id<GUIRestDeligate>)myRestDelegate activities:(NSArray*)myActivities {
    self = [super initWithActivityDelegate:activityDelegate restDelegate:myRestDelegate];
    if (self) {
        self.activities = myActivities;
        return self;
    }
    return nil;
}

- (id<MMAsyncActivityResult>) performAction {
    NSMutableArray * results = [[NSMutableArray alloc] init];
    
    for (MMReAuthenticatingActivity* activity in activities) {
        @try {
            [results addObject:[activity performAction]];
        }
        @catch (NSException *exception) {
            @throw exception;
        }
    }
    
    MMCompositeActivityResult *result = [[MMCompositeActivityResult alloc] init];
    result.results = results;
    return result;
}


@end
