//
//  MMUserRatingSerialisation.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 7/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMCompleteJobRequestSerialisation.h"
#import "MMRestSerialisationException.h"
#import "MMRestNotImplementedException.h"
#import "MMUserRating.h"
#import "MMCompleteJobRequest.h"
#import "MMSerialisationUtils.h"

@implementation MMCompleteJobRequestSerialisation

- (id<MMObject>) deserialiseData:(NSData*) data {
    @throw [[MMRestNotImplementedException alloc] initWithReason:@"Not implemented" userInfo:nil];
}

- (NSData*) serialise:(id <MMObject>) object {
    @try {
        if (object == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Object to serialise was nil" userInfo:nil];
        
        if ([object isKindOfClass:[MMCompleteJobRequest class]]) {
            MMCompleteJobRequest *userRatingReq = (MMCompleteJobRequest *) object;
            
            NSDictionary *userRatingDict = [MMUserRating dictionaryFromUserRating:userRatingReq.userRating];
            
            return [MMSerialisationUtils serialiseData:userRatingDict originalObject:object];
        } else {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Object to serialise was not a user rating request type" userInfo:nil];
        }
    } @catch (NSException *anyEx) {
        MMRestSerialisationException *s11nEx = [[MMRestSerialisationException alloc] initWithReason:@"Serialisation of user rating request failed" userInfo:nil nestedException:anyEx containedError:nil unserialisedObject:nil];
        
        @throw s11nEx;
    }
}

@end
