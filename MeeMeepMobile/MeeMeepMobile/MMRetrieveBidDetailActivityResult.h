//
//  MMRetrieveBidDetailActivityResult.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 25/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMAsyncActivityResult.h"
#import "MMBidDetail.h"

@interface MMRetrieveBidDetailActivityResult : NSObject <MMAsyncActivityResult> {
    MMBidDetail *retrievedBidDetail;
}

@property (strong, nonatomic) MMBidDetail *retrievedBidDetail;

@end
