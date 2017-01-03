//
//  MMItem.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 7/02/13.
//
//

#import "MMJobItem.h"
#import "MMSerialisationUtils.h"

@implementation MMJobItem

@synthesize description;
@synthesize width;
@synthesize height;
@synthesize length;
@synthesize dimensionsUnit;
@synthesize weight;
@synthesize weightUnit;

@synthesize itemId;
@synthesize photoId;

+ (MMJobItem *) getJobItemForDictionary:(NSDictionary *) dictionary {
    if (dictionary == nil)
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Input job item to deserialise was nil" userInfo:nil];
    
    MMJobItem* jobItem = [[MMJobItem alloc] init];
    jobItem.description = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"description"]];
    jobItem.width = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"width"]];
    jobItem.height = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"height"]];
    jobItem.length = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"length"]];
    jobItem.dimensionsUnit = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"measurementUnit"]];
    jobItem.weight = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"weight"]];
    jobItem.weightUnit = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"weightUnit"]];
    
    jobItem.itemId = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"id"]];
    jobItem.photoId = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"imageId"]];
    
    return jobItem;
}

+ (NSDictionary *) dictionaryFromJobItem:(MMJobItem *) jobDetail {
    if (jobDetail == nil)
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Input job item to serialise was nil" userInfo:nil];
    
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:jobDetail.description] forKey:@"description"];
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:[jobDetail.width stringValue]] forKey:@"width"];
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:[jobDetail.height stringValue]] forKey:@"height"];
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:[jobDetail.length stringValue]] forKey:@"length"];
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:jobDetail.dimensionsUnit] forKey:@"measurementUnit"];
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:[jobDetail.weight stringValue]] forKey:@"weight"];
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:jobDetail.weightUnit] forKey:@"weightUnit"];
    
    return dictionary;
}

@end
