//
//  MMAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 22/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMAsyncActivity.h"
#import "MMException.h"
#import "MMErrorUtils.h"

@implementation MMAsyncActivity

@synthesize delegate;
@synthesize activityError;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>) d {
    self = [super init];
    
    if (self) {
        self.delegate = d;
        self.activityError = nil;
        return self;
    }
    
    return nil;
}

- (BOOL) isReady {
    return YES;
}

- (void) main {
    
    BOOL errored = NO;
    
    @try {
        id<MMAsyncActivityResult> result = [self doWork];
        [self.delegate onAsyncActivityCompletion:result];
        errored = NO;
    } @catch (NSException *anyEx) {
        errored = YES;
        if ([anyEx isKindOfClass:[MMException class]]) {
            MMException *mmex = (MMException *) anyEx;
            self.activityError = mmex.containedError;
        } else {
            NSError *error = [MMErrorUtils errorForException:anyEx withDomain:MMApplicationDomain andCode:nil];
            self.activityError = error;
        }
        
        NSString *errorString = [NSString stringWithFormat:@"Async Error:[desc=%@, reason=%@, code=%d]", [self.activityError localizedDescription], [self.activityError localizedFailureReason], [self.activityError code]];
        DLog(@"%@", errorString);
    }
    
    if (errored) {
        [self.delegate onAsyncActivityFailure:self.activityError];
    }
}

// subclasses must override this function
- (id<MMAsyncActivityResult>) doWork {
    @throw [NSException exceptionWithName:NSGenericException reason:@"Not implemented" userInfo:nil];
}

@end
