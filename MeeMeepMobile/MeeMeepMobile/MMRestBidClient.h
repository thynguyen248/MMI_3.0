//
//  MMRestBidClient.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 1/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMBidDetail.h"
#import "MMRestAccessToken.h"
#import "MMBidAcceptRequest.h"

@protocol MMRestBidClient <NSObject>

- (MMBidDetail *) getBidDetailWithId:(NSNumber *) bidId andAccessToken:(MMRestAccessToken *) token;
- (BOOL) createBidWithDetail:(MMBidDetail *) bidDetail forJobWithId:(NSInteger) jobId withAccessToken:(MMRestAccessToken *) token;
- (BOOL) acceptBid:(MMBidAcceptRequest *) acceptBid andAccessToken:(MMRestAccessToken *) token;
- (BOOL) withdrawBidWithId:(NSNumber *) bidId andAccessToken:(MMRestAccessToken *) token;

@end
