//
//  MMRestClient.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestJobsClient.h"
#import "MMRestAuthorisationClient.h"
#import "MMRestAccessToken.h"
#import "MMRestUserClient.h"
#import "MMRestBidClient.h"
#import "MMRestConfigClient.h"
#import "MMRestMessageClient.h"
#import "MMRestAccessToken.h"

@protocol MMRestClient <NSObject>

- (id<MMRestJobsClient>) getJobsClient;

- (id<MMRestUserClient>) getUserClient;

- (id<MMRestAuthorisationClient>) getAuthorisationClient;

- (id<MMRestBidClient>) getBidClient;

- (id<MMRestMessageClient>) getMessageClient;

- (id<MMRestConfigClient>) getConfigClient;

- (NSString*) getBaseUrl;


@end
