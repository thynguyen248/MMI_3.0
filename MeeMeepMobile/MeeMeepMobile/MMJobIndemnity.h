//
//  MMJobIndemnity.h
//  MeeMeepMobile
//
//  Created by Julian Raff on 3/04/13.
//
//

#import <Foundation/Foundation.h>
#import "MMObject.h"

@interface MMJobIndemnity : NSObject<MMObject>

@property (strong, nonatomic) NSNumber* indemnityId;
@property (strong, nonatomic) NSNumber* cover;
@property (strong, nonatomic) NSNumber* excess;
@property (strong, nonatomic) NSNumber* price;
@property (strong, nonatomic) NSString* description;

+(MMJobIndemnity*) getJobIndemnityFromDictionary:(NSDictionary*)dictionary;
+(MMJobIndemnity*) getNoneObject;
+(MMJobIndemnity*) getNotOfferedObject;

- (bool) isNone;

@end
