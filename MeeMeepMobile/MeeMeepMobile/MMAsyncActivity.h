//
//  MMAsyncActivity.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 22/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMAsyncActivityDelegate.h"

@interface MMAsyncActivity : NSOperation {
    id<MMAsyncActivityDelegate> delegate;
    NSError *activityError;
}

@property (strong, nonatomic) NSError *activityError;
@property (strong, nonatomic) id<MMAsyncActivityDelegate> delegate;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>) d;
- (id<MMAsyncActivityResult>) doWork;

@end
