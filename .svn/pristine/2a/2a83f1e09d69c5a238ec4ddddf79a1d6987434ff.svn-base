//
//  MMCreateJobUnitTest.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 18/03/13.
//
//

#import "MMCreateJobUnitTest.h"

#import "MMJobDetail.h"
#import "MMJobItem.h"
#import "GUICommon.h"
#import "MMSerialisationDateHelper.h"
#import "MMSerialisationDateHelperImpl.h"
#import "UnitTestHelper.h"

@implementation MMCreateJobUnitTest

-(id<MMSerialisationDateHelper>) createDateHelper {
    NSString* format = @"dd/MM/yyyy";
    NSLocale *locale = [NSLocale currentLocale];
    // need to be changed to out format
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    
    NSDateFormatter *formatterIn = [[NSDateFormatter alloc] init];
    [formatterIn setLocale:locale];
    [formatterIn setDateFormat:format];
    [formatterIn setTimeZone:tz];
    
    NSDateFormatter *formatterOut = [[NSDateFormatter alloc] init];
    [formatterOut setLocale:locale];
    [formatterOut setDateFormat:format];
    [formatterOut setTimeZone:tz];
    
    return [[MMSerialisationDateHelperImpl alloc] initWithDateFormatterToString:formatterIn toDate:formatterOut];
}

-(MMJobDetail *) createJobDetails:(NSInteger) userId jobId:(NSInteger)jobId fromSuburb:(NSString*) fromSuburb toSuburb:(NSString*) toSuburb dateOptionSelect:(NSString *) dateOptionSelect pickupTime:(NSString *) pickupTime pickupDate:(NSDate *) pickupDate deliveryTime:(NSString *) deliveryTime deliveryDate:(NSDate *) deliveryDate
urgentCollectionSelector:(NSString *)urgentCollectionSelector urgentDeliverySelector:(NSString *)urgentDeliverySelector
pickupDateOptionGroup:(NSString *)pickupDateOptionGroup deliveryDateOptionGroup:(NSString *)deliveryDateOptionGroup
affiliateID:(NSNumber*)affiliateID affiliateJobID:(NSNumber*)affiliateJobID jobCategory:(NSInteger)jobCategory
specialConsiderations:(NSArray *) specialConsiderations item:(MMJobItem*) item{
    MMJobDetail* jobDetails = [[MMJobDetail alloc] init];
    jobDetails.userId = [NSNumber numberWithInt:userId];
    jobDetails.jobId = [NSNumber numberWithInt:jobId];
    jobDetails.fromSuburb = fromSuburb;
    jobDetails.toSuburb = toSuburb;
    jobDetails.dateOptionSelect = dateOptionSelect;
    jobDetails.pickupTime = pickupTime;
    jobDetails.pickupDate = pickupDate;
    jobDetails.deliveryTime = deliveryTime;
    jobDetails.deliveryDate = deliveryDate;
    jobDetails.urgentCollectionSelector = urgentCollectionSelector;
    jobDetails.urgentDeliverySelector = urgentDeliverySelector;
    jobDetails.pickupDateOptionGroup = pickupDateOptionGroup;
    jobDetails.deliveryDateOptionGroup = deliveryDateOptionGroup;
    jobDetails.affiliateID = affiliateID;
    jobDetails.affiliateJobID = affiliateJobID;
    jobDetails.jobCategory = [NSNumber numberWithInt:jobCategory];
    [jobDetails addJobItem:item];
    jobDetails.specialConsiderations = nil;
    
    return jobDetails;
}

-(MMJobItem*) createJobItem:(NSString *)description width:(NSInteger) width height:(NSInteger) height length:(NSInteger) length weight:(NSInteger)weight weightUnit:(NSString*)weightUnit {
    MMJobItem* item = [[MMJobItem alloc] init];
    
    item.description = description;
    item.width = [NSNumber numberWithInt:width];
    item.length = [NSNumber numberWithInt:length];
    item.height = [NSNumber numberWithInt:height];
    item.weight = [NSNumber numberWithInt:weight];
    item.weightUnit = weightUnit;
    
    return item;
}

- (void)testMarshall {
    @try {
        MMJobItem* jobItem = [self createJobItem:@"Test" width:1 height:2 length:3 weight:4 weightUnit:@"kgs"];
        NSArray* specialConsiderations = [NSArray arrayWithObject:@"Fragile"];
        MMJobDetail* jobDetails = [self createJobDetails:1 jobId:2 fromSuburb:@"Somewhere, Victoria" toSuburb:@"Somewhere Else, Victoria" dateOptionSelect:@"Flexible" pickupTime:@"After 6pm" pickupDate:[NSDate date] deliveryTime:@"Before 8am" deliveryDate:[NSDate date] urgentCollectionSelector:@"Fixed" urgentDeliverySelector:@"Tomorrow" pickupDateOptionGroup:@"Tomorrow" deliveryDateOptionGroup:@"Today" affiliateID:[NSNumber numberWithInt:1] affiliateJobID:[NSNumber numberWithInt:2] jobCategory:1 specialConsiderations:specialConsiderations item:jobItem];
        
        id<MMSerialisationDateHelper> dateSerialiser = [self createDateHelper];
        
        NSDictionary* jobAsDictionary = [MMJobDetail dictionaryFromJobDetail:jobDetails withDateSerialiser:dateSerialiser];
        STAssertNotNil(jobAsDictionary, @"Job dictionary is null");
        STAssertEquals([jobAsDictionary count], (NSUInteger)16, @"Wrong number of fields serialised");
    }
    @catch (NSException *exception) {
        STFail(@"Unexpected exception occurred");
    }
}

@end
