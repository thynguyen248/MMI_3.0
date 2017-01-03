//
//  MMBidSummaryResponse.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 1/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMObject.h"

@interface MMBidSummaryResponse : NSObject<MMObject> {
    NSArray *bids;
    NSDictionary *links;
}

@property (strong, nonatomic) NSArray *bids;
@property (strong, nonatomic) NSDictionary *links;

@end
