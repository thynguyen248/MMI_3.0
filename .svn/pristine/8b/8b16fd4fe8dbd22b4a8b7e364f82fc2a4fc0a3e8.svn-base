//
//  MMMockAsyncActivityDelegate.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 22/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMAsyncActivityDelegate.h"

@interface MMMockAsyncActivityDelegate : NSObject <MMAsyncActivityDelegate> {
    BOOL activityStarted;
    BOOL activityEnded;
    NSError *activityError;
    id<MMAsyncActivityResult> activityResult;
}

@property (strong, nonatomic) NSError *activityError;
@property (strong, nonatomic) id<MMAsyncActivityResult> activityResult;

- (id) init;

@end
