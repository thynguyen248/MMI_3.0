//
//  MMMockHttpTransmissionGetMatcherImpl.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 4/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMMockHttpTransmissionGetMatcherImpl.h"

#import "MMMockHttpTransmissionResponseMatchingEntry.h"

@implementation MMMockHttpTransmissionGetMatcherImpl

@synthesize responses;

- (id) init {
    self = [super init];
    if (self) {
        self.responses = [[NSMutableArray alloc] init];
        return self;
    }
    
    return nil;
}

- (void) clearAllResponses {
    if (responses != nil) {
        [responses removeAllObjects];
    }
}

- (void) addResponse:(MMRestHttpResponse *) response forUrl:(NSString *) url andRequestParams:(NSDictionary *) params {

    if (responses == nil) {
        responses = [[NSMutableArray alloc] init];
    }
    
    if (response != nil && url != nil) {
        
        MMMockHttpTransmissionResponseMatchingEntry *entry = 
        [[MMMockHttpTransmissionResponseMatchingEntry alloc] initWithParams:params forUrl:url withResponse:response];        
                
        [responses addObject:entry];
    }
}

- (MMRestHttpResponse *) responseMatchingUrl:(NSString *) url andParams:(NSDictionary *) requestedHeaderParams {
    
    if (responses == nil) return nil;
    
    MMMockHttpTransmissionResponseMatchingEntry *matchingEntry = nil;
    for (MMMockHttpTransmissionResponseMatchingEntry *entry in responses) {
        
        if ([entry.url isEqualToString:url] &&
            [self configuredHeaders:entry.params containedInRequestedHeaders:requestedHeaderParams]) {
            matchingEntry = entry;
            break;
        }
    }
    
    if (matchingEntry) {
        NSString *bodyText = [[NSString alloc] initWithData:matchingEntry.response.responseBody encoding:NSUTF8StringEncoding];
        DLog(@"ResponseMatcher: Matched url [%@] to response: %@", url, bodyText);
    }
    
    return matchingEntry.response;
}

- (BOOL) configuredHeaders:(NSDictionary *) configuredHeaders containedInRequestedHeaders:(NSDictionary *) requestedHeaders {
    
    BOOL headersContained = YES;
    
    
    // if they are both nil then they match implicitly
    if (configuredHeaders == nil && requestedHeaders == nil) return YES;
    
    
    for (NSString *configuredHeaderKey in configuredHeaders) {
        NSString *val = [requestedHeaders objectForKey:configuredHeaderKey];
        
        if (val != nil) { // we have a value in the requested headers for the configured key - we now need to see if they match
            NSString *configuredVal = [configuredHeaders objectForKey:configuredHeaderKey];
            if (![configuredVal isEqualToString:val]) {
                // requested header contains configured header 
                // but values don't match - die
                headersContained = NO;
                break;
            } 
        } else {
            // not contained in requested headers - die
            headersContained = NO;
            break;
        }
    }
    
    return headersContained;
}

- (void) logResponses {
    for (MMMockHttpTransmissionResponseMatchingEntry *entry in responses) {
        NSString *url = entry.url;
        NSString *bodyText = [[NSString alloc] initWithData:entry.response.responseBody encoding:NSUTF8StringEncoding];
        DLog(@"Response: url={%@}, body=|%@|", url, bodyText);
    }
}

@end
