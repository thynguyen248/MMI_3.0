//
//  MMJobCreationRequestSerialisation.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 15/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMJobCreationRequestSerialisation.h"
#import "MMJobCreationRequest.h"

#import "MMRestSerialisationException.h"
#import "MMRestNotImplementedException.h"
#import "MMSerialisationUtils.h"

@implementation MMJobCreationRequestSerialisation

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
    MMRestNotImplementedException *nex = [[MMRestNotImplementedException alloc] initWithReason:@"Deserialiation of job creation request not implemented!" userInfo:nil];
    
    @throw nex;
}

- (NSData*) serialise:(id <MMObject>) object {
    @try {
        if (object == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Object to serialise was nil" userInfo:nil];
        
        if ([object isKindOfClass:[MMJobCreationRequest class]]) {
            MMJobCreationRequest *jobRequest = (MMJobCreationRequest *) object;
            
            MMJobDetail *jobDetail = jobRequest.jobDetail;
            
            NSDictionary *jobDetailDictionary = [MMJobDetail dictionaryFromJobDetail:jobDetail withDateSerialiser:self.dateSerialisation];
            
            return [MMSerialisationUtils serialiseData:jobDetailDictionary originalObject:object];
        } else {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Object to serialise was not a job creation request" userInfo:nil];
        }
    
    } @catch (NSException *anyEx) {
        MMRestSerialisationException *s11nEx = [[MMRestSerialisationException alloc] initWithReason:@"Could not serialise job creation request" userInfo:nil nestedException:anyEx containedError:nil unserialisedObject:nil];
        
        @throw s11nEx;
    }
}

@end
