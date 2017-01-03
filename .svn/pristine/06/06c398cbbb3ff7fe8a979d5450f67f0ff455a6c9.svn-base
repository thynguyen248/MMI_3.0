//
//  MMSerialisationUtils.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 17/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMSerialisationUtils.h"
#import "MMRestDeserialisationException.h"
#import "MMRestSerialisationException.h"

@implementation MMSerialisationUtils

+ (id) nilIfNSNull:(id) object {
    if (object == nil) return nil;
    
    if ([object isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    return object;
}

+ (id) nsNullForNil:(id) object {
    if (object == nil) return [[NSNull alloc] init];
    else return object;
}

+ (NSDate*) getDateFromRFC3339String:(NSString*)rfc3339DateTimeString
{
    if(rfc3339DateTimeString == nil)
    {
        return nil;
    }
    // If the date formatters aren't already set up, create them and cache them for reuse.
    static NSDateFormatter *sRFC3339DateFormatter = nil;
    if (sRFC3339DateFormatter == nil) {
        sRFC3339DateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        
        [sRFC3339DateFormatter setLocale:enUSPOSIXLocale];
        [sRFC3339DateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [sRFC3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }
    
    // Convert the RFC 3339 date time string to an NSDate and return
    return [sRFC3339DateFormatter dateFromString:rfc3339DateTimeString];
}

+ (NSData*) serialiseData:(id)dictionary originalObject:(id<MMObject>)unserialisedObject {
    NSError *error;
    
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        
        if (data == nil) {
            @throw [[MMRestSerialisationException alloc] initWithReason:@"No foundation object returned from JSON parsing" userInfo:nil nestedException:nil containedError:error unserialisedObject:unserialisedObject];
        } else {
            return data;
        }
    } else {
        @throw [[MMRestSerialisationException alloc] initWithReason:@"Not a valid JSON object" userInfo:nil nestedException:nil containedError:nil unserialisedObject:unserialisedObject];
    }
}

+ (id) deserialiseData:(NSData*)data {
    if (data == nil)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Data to de-serialise was nil" userInfo:nil];
    }
    
    NSError *error = nil;
    
    id deserialised = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (deserialised == nil) {
        MMRestDeserialisationException *ex = [[MMRestDeserialisationException alloc] initWithReason:@"Could not de-serialise response" userInfo:nil nestedException:nil containedError:error serialisedData:data];
        
        @throw ex;
    }
    
    return deserialised;
}

@end
