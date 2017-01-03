//
//  MMAsyncActivityManagementImpl.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 22/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMAsyncActivityManagementImpl.h"
#import "MMException.h"

@implementation MMAsyncActivityManagementImpl

@synthesize operationQueue;

- (id) init {
    self = [super init];
    if (self) {
        self.operationQueue = [[NSOperationQueue alloc] init];
        [self.operationQueue setMaxConcurrentOperationCount:2];
        return self;
    }
    
    return nil;
}

- (void) dispatchMMAsyncActivity:(MMAsyncActivity *)activity {
    @try {
        if (activity == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Activity to dispatch was nil" userInfo:nil];
        
        if (self.operationQueue == nil) @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Operation queue not initialised" userInfo:nil];
    
        // basic dispatch
        DLog(@"Dispatching MeeMeep activity!");
        [self.operationQueue addOperation:activity];
        DLog(@"%@ dispatched", [[activity class] description]);
        
    } @catch (NSException *anyEx) {
        @throw [[MMException alloc] initWithName:NSGenericException reason:@"Could not dispatch async activity" userInfo:nil nestedError:nil];
    }
}


@end
