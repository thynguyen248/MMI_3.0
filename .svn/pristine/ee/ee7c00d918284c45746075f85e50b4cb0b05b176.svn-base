//
//  MMCreateJobAsyncActivity.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 30/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMReAuthenticatingActivity.h"
#import "MMJobDetail.h"

@interface MMCreateJobAsyncActivity : MMReAuthenticatingActivity {
    MMJobDetail *jobToCreate;
    BOOL jobCreated;
}

@property (strong, nonatomic) MMJobDetail *jobToCreate;

- (id)initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD jobToCreate:(MMJobDetail *) job;

@end
