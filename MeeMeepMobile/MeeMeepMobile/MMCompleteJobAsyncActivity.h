//
//  MMRateUserAsyncActivity.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMReAuthenticatingActivity.h"
#import "MMRestClient.h"
#import "MMUserRating.h"

@interface MMCompleteJobAsyncActivity : MMReAuthenticatingActivity {
    MMUserRating *userRating;
    NSNumber* jobId;
}

@property (strong, nonatomic) MMUserRating *userRating;
@property (strong, nonatomic) NSNumber* jobId;

// job is done AND rate the user
- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>)restD rating:(MMUserRating *)rating;
- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>)restD jobId:(NSNumber *)jobID;

@end
