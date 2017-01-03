//
//  MMAsyncActivityManagement.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 22/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMAsyncActivity.h"

@protocol MMAsyncActivityManagement <NSObject>

- (void) dispatchMMAsyncActivity:(MMAsyncActivity *) activity;

@end
