//
//  RecentJobsViewController.m
//  MeeMeepMobile
//
//  Created by Julian Raff on 26/03/13.
//  Copyright (c) 2013 Unico Computer Systems. All rights reserved.
//

#import "RecentJobsViewController.h"
#import "MMRetrieveJobSummaryListActivity.h"

@implementation RecentJobsViewController

-(id) initWithCommandObject: (id<GUIRestDeligate>) commandObj {
    self = [super initWithCommandObject:commandObj];
    if(self) {
        DLog(@"Created Recent Jobs");
    }
    return self;
}

- (MMAsyncActivity*) getActivity {
    return [[MMRetrieveJobSummaryListActivity alloc] initWithActivityDelegate:self restDelegate:restDeligate];
}

- (Boolean) getShouldUpdateJobs {
    return [restDeligate getShouldUpdateRecentJobs];
}

- (void) setShouldUpdateJobs:(Boolean)b {
    [restDeligate setShouldUpdateRecentJobs:b];
}

@end
