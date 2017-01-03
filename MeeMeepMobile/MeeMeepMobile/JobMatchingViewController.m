//
//  JobListingSummaryViewController.m
//  MeeMeepMobile
//
//  Created by Julian Raff on 26/03/13.
//
//

#import "JobMatchingViewController.h"
#import "MMRetrieveMatchingJobSummaryListActivity.h"

@implementation JobMatchingViewController

-(id) initWithCommandObject: (id<GUIRestDeligate>) commandObj {
    self = [super initWithCommandObject:commandObj];
    if(self) {
        DLog(@"Created Job Matching");
    }
    return self;
}

- (MMAsyncActivity*) getActivity {
    return [[MMRetrieveMatchingJobSummaryListActivity alloc] initWithActivityDelegate:self restDelegate:restDeligate];
}

- (void) resetViewController {
    [self clearList];
}

- (Boolean) getShouldUpdateJobs {
    return [restDeligate getShouldUpdateMatchingJobs];
}

- (void) setShouldUpdateJobs:(Boolean)b {
    [restDeligate setShouldUpdateMatchingJobs:b];
}

@end
