//
//  MMConfig.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 20/02/13.
//
//

#import "MMConfig.h"
#import "MMPair.h"
#import "MMJobIndemnity.h"

@interface MMConfig(Privates)
-(NSArray *) extractPairs:(NSString *) pairsKey firstKey:(NSString *)
       firstKey secondKey:(NSString *) secondKey;
@end

@implementation MMConfig

@synthesize changed;
@synthesize configuration;

-(id) init {
    if(self = [super init]) {
        jobCategories = nil;
        specialConditions = nil;
    }
    
    return self;
}

-(NSString *) getHash {
    return [configuration objectForKey:@"hashCode"];
}

-(NSArray *) getTimePeriods {
    return [configuration objectForKey:@"timePeriods"];
}

-(NSArray *) getDimensionUnits {
    //NSArray* arrayWithObjects = [NSArray arrayWithObjects:@"cm", @"metres", nil];
    //return arrayWithObjects;
    return [configuration objectForKey:@"measurementUnits"];
}

-(NSArray *) getWeightUnits {
    return [configuration objectForKey:@"weightUnits"];
}

-(NSArray *) getFlexibilityTags {
    return [configuration objectForKey:@"flexibility"];
}

-(NSArray *) getUrgencyTags {
    return [configuration objectForKey:@"urgency"];   
}

-(NSArray *) getDateOptions {
    return [configuration objectForKey:@"dateOptions"];
}

-(NSArray *) getAffiliateCategories {
    if(affiliateCategories == nil) {
        affiliateCategories = [self extractPairs:@"affiliates" firstKey:@"id" secondKey:@"name"];
    }
    
    return affiliateCategories;
}

-(NSArray *) getJobCategories {
    if(jobCategories == nil) {
        jobCategories = [self extractPairs:@"jobCategories" firstKey:@"id" secondKey:@"name"];        
    }
    
    return jobCategories;
}

-(NSArray *) getSpecialConditions {
    if(specialConditions == nil) {
        specialConditions = [self extractPairs:@"specialConsiderations" firstKey:@"id" secondKey:@"description"];
    }
    return specialConditions;
}

-(NSArray *) getTransportTypes {
    if(transportTypes == nil) {
        transportTypes = [self extractPairs:@"deliveryTypes" firstKey:@"id" secondKey:@"type"];
    }
    return transportTypes;
}

-(NSArray *) getJobIndemnities {
    if(jobIndemnities == nil) {
        jobIndemnities = [self extractJobIndemnities];
    }
    return jobIndemnities;
}

-(NSArray *) getRatingReasons {
    if(ratingReasons == nil) {
        ratingReasons = [self extractPairs:@"ratingReasons" firstKey:@"id" secondKey:@"reason"];
    }
    return ratingReasons;
}


-(NSArray *) extractJobIndemnities {
    NSArray* details = [configuration objectForKey:@"jobIndemnities"];
    
    NSMutableArray* indemnities = [NSMutableArray arrayWithCapacity:[details count]];
    for(NSDictionary* dict in details) {
        if(dict) {
            [indemnities addObject:[MMJobIndemnity getJobIndemnityFromDictionary:dict]];
        }
    }
    
    return indemnities;
}


-(NSArray *) extractPairs:(NSString *) pairsKey firstKey:(NSString *) firstKey secondKey:(NSString *) secondKey {
    NSArray* details = [configuration objectForKey:pairsKey];
    
    NSMutableArray* pairs = [NSMutableArray arrayWithCapacity:[details count]];
    for(NSDictionary* dict in details) {
        id identifier = [dict objectForKey:firstKey];
        id description = [dict objectForKey:secondKey];
        
        [pairs addObject:[[MMPair alloc] initWithPair:identifier second:description]];
    }
    
    return pairs;
}

@end
