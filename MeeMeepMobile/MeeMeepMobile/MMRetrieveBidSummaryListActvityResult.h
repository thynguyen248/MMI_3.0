//
//  MMRetrieveBidSummaryListActvitiyResult.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 24/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMAsyncActivityResult.h"


@interface MMRetrieveBidSummaryListActvityResult : NSObject<MMAsyncActivityResult> {
    NSArray *retrievedBidSummaryList;
}

@property (strong, nonatomic) NSArray *retrievedBidSummaryList;

@end
