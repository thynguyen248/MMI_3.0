//
//  MMJobIndemnity.m
//  MeeMeepMobile
//
//  Created by Julian Raff on 3/04/13.
//
//

#import "MMJobIndemnity.h"
#import "MMSerialisationUtils.h"

@implementation MMJobIndemnity

static MMJobIndemnity* noneObject;
static MMJobIndemnity* notOfferedObject;

+ (void) initialize
{
    noneObject = [[MMJobIndemnity alloc] init];
    
    noneObject.indemnityId = [NSNumber numberWithInt:-1];
    noneObject.cover = [NSNumber numberWithInt:0];
    noneObject.excess = [NSNumber numberWithInt:0];
    noneObject.price = [NSNumber numberWithInt:0];
    noneObject.description = @"None";
    
    notOfferedObject = [[MMJobIndemnity alloc] init];
    
    notOfferedObject.indemnityId = [NSNumber numberWithInt:-1];
    notOfferedObject.cover = [NSNumber numberWithInt:0];
    notOfferedObject.excess = [NSNumber numberWithInt:0];
    notOfferedObject.price = [NSNumber numberWithInt:0];
    notOfferedObject.description = @"Not offered for this transport provider";
}

+(MMJobIndemnity*) getJobIndemnityFromDictionary:(NSDictionary*)dictionary
{
    MMJobIndemnity* jobIndemnity = [[MMJobIndemnity alloc] init];
    
    jobIndemnity.indemnityId = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"id"]];
    jobIndemnity.cover = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"cover"]];
    jobIndemnity.excess = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"excess"]];
    jobIndemnity.price = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"price"]];
    jobIndemnity.description = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"displayValue"]];
    
    return jobIndemnity;
}

+ (MMJobIndemnity*) getNoneObject
{
    return noneObject;
}

+ (MMJobIndemnity*) getNotOfferedObject {
    return notOfferedObject;
}

- (bool) isEqualTo:(MMJobIndemnity*) other
{
    if([_indemnityId isEqualToNumber:other.indemnityId] &&
       [_cover isEqualToNumber:other.cover] &&
       [_excess isEqualToNumber:other.excess] &&
       [_price isEqualToNumber:other.price] &&
       [[self description] isEqualToString:other.description])
    {
        return true;
    }
    return false;
}

- (bool) isNone
{
    if([self isEqualTo:[MMJobIndemnity getNoneObject]] || [self isEqualTo:[MMJobIndemnity getNotOfferedObject]])
    {
        return true;
    }
    return false;
}

@end
