//
//  MMBidCreationRequestSerialistion.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMBidCreationRequestSerialisation.h"
#import "MMBidCreationRequest.h"
#import "MMRestSerialisationException.h"
#import "MMRestNotImplementedException.h"
#import "MMSerialisationUtils.h"

@implementation MMBidCreationRequestSerialisation

@synthesize dateSerialisation;

- (id) initWithDateS11nHelper:(id<MMSerialisationDateHelper>) dateS11nHelper {
    self = [super init];
    if (self) {
        self.dateSerialisation = dateS11nHelper;
        return self;
    }
    
    return nil;
}

- (id<MMObject>) deserialiseData:(NSData*) data {
    MMRestNotImplementedException *nex = [[MMRestNotImplementedException alloc] initWithReason:@"Deserialisation not implemented!" userInfo:nil];
    
    @throw nex;
}

- (NSData*) serialise:(id <MMObject>) object {
    @try {
        if (object == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Object to serialise was nil" userInfo:nil];
        
        if ([object isKindOfClass:[MMBidCreationRequest class]]) {
            MMBidCreationRequest *bidRequest = (MMBidCreationRequest *) object;
            
            MMBidDetail *bidDetail = bidRequest.bidDetail;
            
            NSDictionary *bidDetailDictionary = [MMBidDetail getDictionaryFromBidDetail:bidDetail withDateHelper:self.dateSerialisation];
            
            return [MMSerialisationUtils serialiseData:bidDetailDictionary originalObject:object];
        } else {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Object to serialise was not a bid creation request" userInfo:nil];
        }
        
    } @catch (NSException *anyEx) {
        MMRestSerialisationException *s11nEx = [[MMRestSerialisationException alloc] initWithReason:@"Could not serialise bid creation request" userInfo:nil nestedException:anyEx containedError:nil unserialisedObject:nil];
        
        @throw s11nEx;
    }
}

@end
