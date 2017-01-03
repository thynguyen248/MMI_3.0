//
//  MMJobSummaryResponseSerialisation.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRecentJobSummaryResponseSerialisation.h"
#import "MMRecentSummaryJobsResponse.h"
#import "MMJobSummary.h"
#import "MMSerialisationUtils.h"
#import "MMRestDeserialisationException.h"
#import "MMRestNotImplementedException.h"
#import "MMSerialisationUtils.h"

@implementation MMRecentJobSummaryResponseSerialisation

@synthesize dateSerialisation;

- (MMRecentSummaryJobsResponse *) deserialiseData:(NSData*) data {
    @try {
        NSDictionary *rootJobsDictionary = [MMSerialisationUtils deserialiseData:data];
        
        NSArray* rootJobsArray = [rootJobsDictionary objectForKey:@"jobs"];
        
        NSMutableArray *jobsArray = [[NSMutableArray alloc] initWithCapacity:[rootJobsArray count]];
        
        for (NSDictionary *jobDictionary in rootJobsArray) {
            
            MMJobSummary *job = [MMJobSummary getJobSummaryFromDictionary:jobDictionary];
            
            if (job != nil) {
                [jobsArray addObject:job];
            }
        }
        
        MMRecentSummaryJobsResponse *response = [[MMRecentSummaryJobsResponse alloc] init];
        response.jobs = jobsArray;
        response.totalAvailable = [rootJobsDictionary objectForKey:@"total"];
        
        return response;
    } @catch (NSException *anyEx) {
        MMRestDeserialisationException *dex = [[MMRestDeserialisationException alloc] initWithReason:@"Could not deserialise summary jobs response object" userInfo:nil nestedException:anyEx containedError:nil serialisedData:nil];
        
        @throw dex;
    }
}


- (NSData*) serialise:(MMRecentSummaryJobsResponse *) object {
    MMRestNotImplementedException *nex = [[MMRestNotImplementedException alloc] initWithReason:@"Serialisation function not implemented for Login Response" userInfo:nil];
    
    @throw nex;
}

- (id) initWithDateHelper:(id<MMSerialisationDateHelper>) dateS11nHelper {
    self = [super init];
    if (self) {
        self.dateSerialisation = dateS11nHelper;
        
        return self;
    }
    
    return nil;
}

@end
