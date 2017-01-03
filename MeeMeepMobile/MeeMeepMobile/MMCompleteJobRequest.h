//
//  MMUserRatingRequest.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 7/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMObject.h"
#import "MMUserRating.h"

@interface MMCompleteJobRequest : NSObject<MMObject>

@property (strong, nonatomic) MMUserRating *userRating;

@end
