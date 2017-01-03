//
//  MMJobDetailDataUtils.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 2/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMJobDetail.h"

@interface MMJobDetailDataUtils : NSObject

+ (MMJobDetail *) getJobDetailToCreateForUserWithName:(NSString *) username userId:(NSNumber *) userId;

@end
