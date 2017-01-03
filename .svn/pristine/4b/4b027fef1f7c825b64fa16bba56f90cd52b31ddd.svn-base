//
//  MMRegistrationSerialisation.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 7/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRegistrationRequestSerialisation.h"
#import "MMRestSerialisationException.h"
#import "MMRestNotImplementedException.h"
#import "MMUserProfile.h"
#import "MMRegistrationRequest.h"
#import "MMSerialisationUtils.h"

@implementation MMRegistrationRequestSerialisation

- (id<MMObject>) deserialiseData:(NSData*) data {
    @throw [[MMRestNotImplementedException alloc] initWithReason:@"Not implemented" userInfo:nil];
}

- (NSData*) serialise:(id <MMObject>) object {
    @try {
        if (object == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Object to serialise was nil" userInfo:nil];
        
        if ([object isKindOfClass:[MMRegistrationRequest class]]) {
            MMRegistrationRequest *request = (MMRegistrationRequest *) object;
            
            NSDictionary *dictionary = [MMNewUser getDictionaryFromUser:request.userProfile];
            
            return [MMSerialisationUtils serialiseData:dictionary originalObject:object];
        } else {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Object to serialise was not a registration request type" userInfo:nil];
        }
    } @catch (NSException *anyEx) {
        MMRestSerialisationException *s11nEx = [[MMRestSerialisationException alloc] initWithReason:@"Serialisation of registration request failed" userInfo:nil nestedException:anyEx containedError:nil unserialisedObject:nil];
        
        @throw s11nEx;
    }
}

@end
