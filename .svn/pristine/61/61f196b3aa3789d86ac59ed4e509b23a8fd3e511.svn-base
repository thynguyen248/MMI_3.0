//
//  MMUserRating.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 7/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMObject.h"

@interface MMUserRating : NSObject<MMObject> {
    NSNumber *jobId;
    NSString *comment;
    NSNumber *rating;
    NSArray* reasons;
}

@property (strong, nonatomic) NSNumber *jobId;
@property (strong, nonatomic) NSString *comment;
@property (strong, nonatomic) NSNumber *rating;
@property (strong, nonatomic) NSArray* reasons;

+ (NSDictionary *) dictionaryFromUserRating:(MMUserRating *) userRating;

@end
