//
//  MMUserProfileResponseSerialisation.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 5/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMUserProfileResponseSerialisation.h"

#import "MMRestNotImplementedException.h"
#import "MMRestDeserialisationException.h"
#import "MMUserProfile.h"
#import "MMUserProfileResponse.h"
#import "MMSerialisationUtils.h"

@implementation MMUserProfileResponseSerialisation

- (id<MMObject>) deserialiseData:(NSData*) data {
    @try {
        NSDictionary *userProfileRootDict = [MMSerialisationUtils deserialiseData:data];
        
        MMUserProfile *profile = [MMUserProfile getUserProfileFromDictionary:[userProfileRootDict valueForKey:@"user"]];
        
        MMUserProfileResponse *resp = [[MMUserProfileResponse alloc] initWithUserProfile:profile];
        
        return resp;
        
    } @catch (NSException *anyEx) {
        MMRestDeserialisationException *desex = [[MMRestDeserialisationException alloc] initWithReason:@"Could not deserialise user profile response" userInfo:nil nestedException:anyEx containedError:nil];
        @throw desex;
    }
}

- (NSData*) serialise:(id <MMObject>) object {
    MMRestNotImplementedException *nex = [[MMRestNotImplementedException alloc] initWithReason:@"Serialisation not implemented!" userInfo:nil];
    
    @throw nex;
}

@end
