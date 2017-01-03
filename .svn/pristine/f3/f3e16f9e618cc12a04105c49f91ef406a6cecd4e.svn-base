//
//  MMSerialisationUtils.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 17/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMObject.h"

@interface MMSerialisationUtils : NSObject

+ (id) nilIfNSNull:(id) object;
+ (id) nsNullForNil:(id) object;

+ (NSDate*) getDateFromRFC3339String:(NSString*)rfc3339DateTimeString;

+ (id) deserialiseData:(NSData*)data;
+ (NSData*) serialiseData:(id)dictionary originalObject:(id<MMObject>)unserialisedObject;

@end
