//
//  MMUserRating.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 7/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMUserRating.h"
#import "MMSerialisationUtils.h"

@implementation MMUserRating

@synthesize jobId;
@synthesize comment;
@synthesize rating;
@synthesize reasons;

+ (NSDictionary *) dictionaryFromUserRating:(MMUserRating *) userRating {
    if (userRating == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Input user rating was nil" userInfo:nil];
    
    NSMutableDictionary *rootObject = [[NSMutableDictionary alloc] init];
    
    [rootObject setValue:[MMSerialisationUtils nsNullForNil:userRating.jobId] forKey:@"id"];
    [rootObject setValue:[MMSerialisationUtils nsNullForNil:userRating.comment] forKey:@"comment"];
    [rootObject setValue:[MMSerialisationUtils nsNullForNil:userRating.rating] forKey:@"starRating"];
    [rootObject setValue:[MMSerialisationUtils nsNullForNil:userRating.reasons] forKey:@"ratingReasons"];
    
    return rootObject;
}

@end
