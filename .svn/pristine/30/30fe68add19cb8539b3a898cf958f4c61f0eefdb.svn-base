//
//  MMConfig.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 20/02/13.
//
//

#import <Foundation/Foundation.h>

#import "MMObject.h"

@interface MMConfig : NSObject<MMObject> {
    NSArray* affiliateCategories;
    NSArray* jobCategories;
    NSArray* specialConditions;
    NSArray* transportTypes;
    NSArray* jobIndemnities;
    NSArray* ratingReasons;
}

-(NSString *) getHash;
-(NSArray *) getAffiliateCategories;
-(NSArray *) getTimePeriods;
-(NSArray *) getDimensionUnits;
-(NSArray *) getWeightUnits;
-(NSArray *) getJobCategories;
-(NSArray *) getSpecialConditions;
-(NSArray *) getFlexibilityTags;
-(NSArray *) getUrgencyTags;
-(NSArray *) getDateOptions;
-(NSArray *) getTransportTypes;
-(NSArray *) getJobIndemnities;
-(NSArray *) getRatingReasons;

@property (nonatomic) BOOL changed;
@property (nonatomic, strong) NSDictionary* configuration;

@end
