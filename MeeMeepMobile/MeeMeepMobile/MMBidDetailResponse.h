//
//  MMBidDetailResponse.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 3/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMObject.h"
#import "MMBidDetail.h"

@interface MMBidDetailResponse : NSObject<MMObject> {
    MMBidDetail *bidDetail;
}

@property (strong, nonatomic) MMBidDetail *bidDetail;

@end
