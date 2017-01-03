//
//  MMRestJobsClient.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestAccessToken.h"
#import "MMJobId.h"
#import "MMJobDetail.h"
#import "MMRestBidClient.h"
#import "MMMessageDetail.h"
#import "MMUserRating.h"

@protocol MMRestJobsClient <NSObject>

- (NSArray *) getRecentlyPostedSummaryJobsWithAccessToken:(MMRestAccessToken *)token;
- (MMJobDetail *) getJobDetailForJobId:(NSNumber *) jobId withToken:(MMRestAccessToken *) token;
- (NSArray *) getBidSummaryListForJobId:(NSNumber *) jobId andAccessToken:(MMRestAccessToken *) token;
- (BOOL) createJobWithDetail:(MMJobDetail *) jobDetail andAccessToken:(MMRestAccessToken *) token;
- (BOOL) createBidWithDetail:(MMBidDetail *) bidDetail forJobWithId:(NSInteger) jobId withAccessToken:(MMRestAccessToken *) token;
- (NSArray *) searchJobsWithParameters:(NSDictionary *)searchParameters andToken:(MMRestAccessToken *) token;
- (NSArray *) getMessagesForJobWithId:(NSNumber *) jobId withToken:(MMRestAccessToken *) token;
- (BOOL) customerCompleteJobWithRating:(MMUserRating*)userRating withToken:(MMRestAccessToken *) token;
- (BOOL) tpCompleteJob:(NSNumber *)jobId withToken:(MMRestAccessToken *) token;

@end
