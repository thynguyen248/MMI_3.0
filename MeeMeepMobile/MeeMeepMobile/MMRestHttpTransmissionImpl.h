//
//  MMRestHttpTransmissionImpl.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestHttpTransmission.h"
#import "MMHttpLogging.h"
#import "MMAsyncActivityManagement.h"

@interface MMRestHttpTransmissionImpl : NSObject<MMRestHttpTransmission> {
    id<MMHttpLogging> logging;
    NSUInteger httpRequestTimeout;
    
    id<MMAsyncActivityManagement> activityManagement;
}

@property (assign, nonatomic) NSUInteger httpRequestTimeout;
@property (strong, nonatomic) id<MMHttpLogging> logging;

@property (strong, nonatomic) id<MMAsyncActivityManagement> activityManagement;

- (id) initWithLogging:(id<MMHttpLogging>) log;
- (id) initWithRequestTimeout:(NSUInteger) timeout andLogging:(id<MMHttpLogging>) logging;

@end
