//
//  MMUserProfile.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 5/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMUserProfile.h"
#import "MMSerialisationUtils.h"

@implementation MMUserProfile

+ (MMUserProfile *) getUserProfileFromDictionary:(NSDictionary *) dict {
    if (dict == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Dictionary was nil" userInfo:nil];
    
    MMUserProfile *profile = [[MMUserProfile alloc] init];

    profile.isTransportProvider = [(NSNumber*)[MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"transportProvider"]] boolValue];
     
    profile.hasBankDetails = [(NSNumber*)[MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"hasBankDetails"]] boolValue];
    profile.hasCreditCardDetails = [(NSNumber*)[MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"hasCreditCardDetails"]] boolValue];
    
    return profile;
}

@end
