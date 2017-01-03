//
//  MMAsyncActivityManagementImpl.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 22/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMAsyncActivityManagement.h"

@interface MMAsyncActivityManagementImpl : NSObject<MMAsyncActivityManagement> {
    NSOperationQueue *operationQueue;
}

@property (strong, nonatomic) NSOperationQueue *operationQueue;

- (id) init;

@end
