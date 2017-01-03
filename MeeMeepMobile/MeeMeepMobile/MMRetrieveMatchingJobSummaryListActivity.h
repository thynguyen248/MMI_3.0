//
//  MMRetrieveMyJobSummaryListActivity.h
//  MeeMeepMobile
//
//  Created by Julian Raff on 26/03/13.
//
//

#import "MMReAuthenticatingActivity.h"
#import "MMRestJobsClient.h"
#import "MMRestClient.h"

@interface MMRetrieveMatchingJobSummaryListActivity : MMReAuthenticatingActivity {
}

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD;

@end
