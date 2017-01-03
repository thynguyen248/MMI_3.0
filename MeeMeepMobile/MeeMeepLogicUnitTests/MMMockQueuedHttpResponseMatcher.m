//
//  MMMockQueuedHttpResponseMatcher.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMMockQueuedHttpResponseMatcher.h"

@implementation MMMockQueuedHttpResponseMatcher

- (id) init {
    self = [super init];
    if (self) {
        urlDictionary = [[NSMutableDictionary alloc] init];
        return self;
    }
    
    return nil;
}

- (void) addResponse:(MMRestHttpResponse *) response forUrl:(NSString *) url {
    // ignores request parameters -- simply dequeues the next response for that url
    
    // if url dictionary contains a reference to the url, get the array behind it and add the response to the end
    // otherwise create a new mapping
    NSMutableArray *responseList = [urlDictionary objectForKey:url];
    if (responseList) {
        [responseList addObject:response];
    } else {
        NSMutableArray *newArray = [NSMutableArray arrayWithObject:response];
        [urlDictionary setValue:newArray forKey:url];
    }
    
    DLog(@"URL [%@] has [%d] responses", url, [[urlDictionary objectForKey:url] count]);
}

- (MMRestHttpResponse *) responseMatchingUrl:(NSString *) url andParams:(NSDictionary *) requestedHeaderParams {
    // again header params are ignored
    
    NSMutableArray *responses = [urlDictionary objectForKey:url];
    if (responses && [responses count] > 0) {
        MMRestHttpResponse *firstResponse = [responses objectAtIndex:0];
        [responses removeObjectAtIndex:0];
        
        NSString *bodyText = [[NSString alloc] initWithData:firstResponse.responseBody encoding:NSUTF8StringEncoding];
        
        DLog(@"QueuedResponseMatcher: matched url [%@] with response: %@", url, bodyText);
        
        return firstResponse;
    } else {
        @throw [NSException exceptionWithName:NSGenericException reason:@"No response for url" userInfo:nil];
    }
}

@end
