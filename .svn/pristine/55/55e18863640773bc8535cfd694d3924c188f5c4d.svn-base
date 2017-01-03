//
//  MMUserProfile.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 5/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMObject.h"

@interface MMUserProfile : NSObject<MMObject>

@property (assign, nonatomic) BOOL isTransportProvider;

@property (assign, nonatomic) BOOL hasBankDetails;
@property (assign, nonatomic) BOOL hasCreditCardDetails;

+ (MMUserProfile *) getUserProfileFromDictionary:(NSDictionary *) dict;

@end
