//
//  MMNewUser.h
//  MeeMeepMobile
//
//  Created by Julian Raff on 5/04/13.
//
//

#import <Foundation/Foundation.h>
#import "MMObject.h"

@interface MMNewUser : NSObject<MMObject>

@property (strong, nonatomic) NSString* username;
@property (strong, nonatomic) NSString* password;
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* surname;

@property (strong, nonatomic) NSString* phoneNumber;
@property (strong, nonatomic) NSString* validationCode;
@property (strong, nonatomic) NSString* abn;
@property (strong, nonatomic) NSString* businessName;

@property (assign, nonatomic) NSNumber* starRating;

// BOOLs
@property (assign, nonatomic) NSNumber* isInterestedInMoving;
@property (assign, nonatomic) NSNumber* isProfessionalMover;

+ (NSDictionary *) getDictionaryFromUser:(MMNewUser *) user;

@end
