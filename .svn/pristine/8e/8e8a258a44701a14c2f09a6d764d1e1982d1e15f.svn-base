//
//  MMRestError.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 30/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMObject.h"

@interface MMRestError : NSObject<MMObject> {
    NSString *detail;
    NSString *reason;
    NSNumber *statusCode;
}

@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) NSString *reason;
@property (strong, nonatomic) NSNumber *statusCode;

- (id) initWithDetail:(NSString *) det reason:(NSString *) rsn statusCode:(NSNumber *) code;
+ (MMRestError *) errorFromDictionary:(NSDictionary *) dict;
- (NSError *) error;

@end
