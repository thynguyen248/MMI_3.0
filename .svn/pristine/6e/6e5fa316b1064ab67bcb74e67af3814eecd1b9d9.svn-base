//
//  MMJobAddress.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMObject.h"

@interface MMJobAddress : NSObject<MMObject> {
    NSString *country;
    NSNumber *latitude;
    NSNumber *longitude;
    NSString *postCode;
    NSString *state;
    NSString *streetName;
    NSString *streetNumber;
    NSString *streetType;
    NSString *suburb;
    NSString *unitNumber;
}

@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSNumber *latitude;
@property (copy, nonatomic) NSNumber *longitude;
@property (copy, nonatomic) NSString *postCode;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *streetName;
@property (copy, nonatomic) NSString *streetNumber;
@property (copy, nonatomic) NSString *streetType;
@property (copy, nonatomic) NSString *suburb;
@property (copy, nonatomic) NSString *unitNumber;

+ (MMJobAddress *) getAddressForDictionary:(NSDictionary *) dictionary;
+ (NSDictionary *) getDictionaryForAddress:(MMJobAddress *) address;

@end
