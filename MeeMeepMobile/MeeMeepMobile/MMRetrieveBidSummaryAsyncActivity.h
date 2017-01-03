//
//  MMRetrieveBidSummaryAsyncActivity.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 24/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "MMRestClient.h"
#import "MMReAuthenticatingActivity.h"

@interface MMRetrieveBidSummaryAsyncActivity : MMReAuthenticatingActivity {
    NSNumber *jobId;
}

@property (strong, nonatomic) NSNumber *jobId;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>)restD forJobId:(NSNumber *) jId;

@end
