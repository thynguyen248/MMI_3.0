//
//  MMMockAsyncActivityDelegate.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 22/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMMockAsyncActivityDelegate.h"

@implementation MMMockAsyncActivityDelegate

@synthesize activityError;
@synthesize activityResult;

- (id) init {
    self = [super init];
    if (self) {
        self.activityError = nil;
        self.activityResult = nil;
        return self;
    }
    
    return self;
}
- (void) onAsyncActivityCompletion:(id<MMAsyncActivityResult>) result {
    DLog(@"Mock Activity Delegate: onAsyncActivityCompletion");
    self.activityResult = result;
}

- (void) onAsyncActivityFailure:(NSError *) error {
    DLog(@"Mock Activity Delegate: onAsyncActivityFailure");
    self.activityError = error;;
}

@end
