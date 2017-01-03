//
//  MMBidAcceptRequestSerialisation.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 8/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMBidAcceptRequestSerialisation.h"

#import "MMBidAcceptRequest.h"

#import "MMRestSerialisationException.h"
#import "MMRestNotImplementedException.h"
#import "MMSerialisationUtils.h"

@implementation MMBidAcceptRequestSerialisation

@synthesize s11nDateHelper;

- (id) initWithDateHelper:(id<MMSerialisationDateHelper>) dateHelper {
    self = [super init];
    if (self) {
        self.s11nDateHelper = dateHelper;
        return self;
    }
    
    return nil;
}

- (id<MMObject>) deserialiseData:(NSData*) data {
    MMRestNotImplementedException *niEx = [[MMRestNotImplementedException alloc] initWithReason:@"Deserialisation of bid acceptance request not implemented!" userInfo:nil];
    
    @throw niEx;
}

- (NSData*) serialise:(id <MMObject>) object {
    @try {
        if (object == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Object to serialise was nil" userInfo:nil];
        
        if ([object isKindOfClass:[MMBidAcceptRequest class]]) {
            MMBidAcceptRequest *acceptRequest = (MMBidAcceptRequest*) object;
            
            // create a dictionary out of the request
            NSDictionary *bidDetailDict = [acceptRequest getAsDictionary];
            
            return [MMSerialisationUtils serialiseData:bidDetailDict originalObject:object];
        } else {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Object to serialise was not a bid acceptance request" userInfo:nil];
        }
    } @catch (NSException *exception) {
        MMRestSerialisationException *s11nEx = [[MMRestSerialisationException alloc] initWithReason:@"Could not serialise bid acceptance request" userInfo:nil nestedException:exception containedError:nil unserialisedObject:nil];
        
        @throw s11nEx;
    }
}

@end
