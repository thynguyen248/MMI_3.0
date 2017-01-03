//
//  MMRestJobsClientHelper.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 9/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestJobsClientHelper.h"

@implementation MMRestJobsClientHelper

+ (NSString *) queryStringFromSearchParameters:(NSDictionary *) searchParameters {
    if (searchParameters == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Search parameters not provided (null)" userInfo:nil];
    
    if ([searchParameters count] == 0) return @"";
    
    NSArray *keyArray = [searchParameters allKeys];
    NSString *queryString = @"";
    for (NSInteger keyIndex = 0; keyIndex < [keyArray count]; keyIndex++) {
        NSString *key = [keyArray objectAtIndex:keyIndex];
        NSString *value = [searchParameters objectForKey:key];
        NSString *kvp = [NSString stringWithFormat:@"%@=%@", key, value];
        
        // if we have more to process, add a &
        queryString = [queryString stringByAppendingString:kvp];
        queryString = [queryString stringByAppendingString:((keyIndex < [keyArray count] - 1) ? @"&" : @"")];
    }
    
    return queryString;
}

@end
