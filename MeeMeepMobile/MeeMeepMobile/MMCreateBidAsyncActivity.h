//
//  MMCreateBidAsyncActivity.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMReAuthenticatingActivity.h"
#import "MMRestClient.h"

@interface MMCreateBidAsyncActivity : MMReAuthenticatingActivity {
    MMBidDetail *bidToCreate;
    NSInteger jobId;
}

@property (strong, nonatomic) MMBidDetail *bidToCreate;
@property (assign, nonatomic) NSInteger jobId;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD bidToCreate:(MMBidDetail *) bid forJobId:(NSInteger) jid;

@end
