//
//  MMNewUser.m
//  MeeMeepMobile
//
//  Created by Julian Raff on 5/04/13.
//
//

#import "MMNewUser.h"
#import "MMSerialisationUtils.h"

@implementation MMNewUser

+ (NSDictionary *) getDictionaryFromUser:(MMNewUser *) user {
    if (user == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Input user was nil" userInfo:nil];
    
    NSMutableDictionary *rootObject = [[NSMutableDictionary alloc] init];
    
    [rootObject setValue:[MMSerialisationUtils nsNullForNil:user.username] forKey:@"register_username"];
    [rootObject setValue:[MMSerialisationUtils nsNullForNil:user.password] forKey:@"register_password"];
    [rootObject setValue:[MMSerialisationUtils nsNullForNil:user.firstName] forKey:@"firstName"];
    [rootObject setValue:[MMSerialisationUtils nsNullForNil:user.surname] forKey:@"lastName"];
    
    [rootObject setValue:[MMSerialisationUtils nsNullForNil:user.isInterestedInMoving] forKey:@"isMovingItems"];
    [rootObject setValue:[MMSerialisationUtils nsNullForNil:user.phoneNumber] forKey:@"mobileNumber"];
    [rootObject setValue:[MMSerialisationUtils nsNullForNil:user.validationCode] forKey:@"pin"];
    
    [rootObject setValue:[MMSerialisationUtils nsNullForNil:user.isProfessionalMover] forKey:@"isMover"];
    [rootObject setValue:[MMSerialisationUtils nsNullForNil:user.abn] forKey:@"abn"];
    [rootObject setValue:[MMSerialisationUtils nsNullForNil:user.businessName] forKey:@"businessName"];
    
    return rootObject;
}

@end
