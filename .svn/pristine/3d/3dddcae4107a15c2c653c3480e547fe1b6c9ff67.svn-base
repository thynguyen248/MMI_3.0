//
//  MMRestErrorSerialisation.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 30/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestErrorSerialisation.h"
#import "MMRestSerialisationException.h"
#import "MMRestDeserialisationException.h"
#import "MMRestNotImplementedException.h"
#import "MMRestError.h"
#import "MMSerialisationUtils.h"

@implementation MMRestErrorSerialisation


- (id<MMObject>) deserialiseData:(NSData*) data {
    @try {
        NSDictionary *rootErrorDict = [MMSerialisationUtils deserialiseData:data];
        
        MMRestError *restError = [MMRestError errorFromDictionary:rootErrorDict];
        
        return restError;
        
    } @catch (NSException *anyEx) {
        MMRestDeserialisationException *deS11nEx = [[MMRestDeserialisationException alloc] initWithReason:@"Could not parse error" userInfo:nil nestedException:anyEx containedError:nil serialisedData:nil];
        @throw deS11nEx;
    }
}

- (NSData*) serialise:(id <MMObject>) object {
    MMRestNotImplementedException *ex = [[MMRestNotImplementedException alloc] initWithReason:@"Serialisation not implemented" userInfo:nil];
    
    @throw ex;
}

@end
