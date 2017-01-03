//
//  MMRetrieveJobDetailAsyncActivity.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 24/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMReAuthenticatingActivity.h"
#import "MMRestClient.h"

@interface MMRetrieveJobDetailAsyncActivity : MMReAuthenticatingActivity {
    NSNumber *jobIdToRetrieve;
}

@property (strong, nonatomic) NSNumber *jobIdToRetrieve;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD jobIdToRetrieve:(NSNumber*) jobId;

@end
