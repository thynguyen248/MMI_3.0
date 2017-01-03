//
//  MMMyMovingJobsResponseSerialisation.m
//  MeeMeepMobile
//
//  Created by Julian Raff on 15/03/13.
//
//

#import "MMMyMovingJobsResponseSerialisation.h"

#import "MMSerialisationUtils.h"
#import "MMMyMovingJobsResponse.h"
#import "MMJobSummary.h"
#import "MMRestDeserialisationException.h"
#import "MMRestNotImplementedException.h"

@implementation MMMyMovingJobsResponseSerialisation

- (MMMyMovingJobsResponse *) deserialiseData:(NSData*) data {
    @try {
        NSDictionary *rootJobsDictionary = [MMSerialisationUtils deserialiseData:data];
        
        MMMyMovingJobsResponse *response = [[MMMyMovingJobsResponse alloc] init];
        response.jobs = [[NSMutableDictionary alloc] initWithCapacity:3];
        for(id key in rootJobsDictionary) {
            [response.jobs setObject:[self deserialiseJobsArray:[rootJobsDictionary objectForKey:key]] forKey:key];
        }
        
        return response;
    } @catch (NSException *anyEx) {
        MMRestDeserialisationException *dex = [[MMRestDeserialisationException alloc] initWithReason:@"Could not deserialise MyMovingJobs response object" userInfo:nil nestedException:anyEx containedError:nil serialisedData:nil];
        
        @throw dex;
    }
}

- (NSArray*) deserialiseJobsArray:(NSArray*)rawArray
{
    NSMutableArray *jobsArray = [[NSMutableArray alloc] initWithCapacity:[rawArray count]];
    
    for (NSDictionary *jobDictionary in rawArray) {
        
        MMJobSummary *job = [MMJobSummary getJobSummaryFromDictionary:jobDictionary];
        
        if (job != nil) {
            [jobsArray addObject:job];
        }
    }
    
    return jobsArray;
}


- (NSData*) serialise:(MMMyMovingJobsResponse *) object {
    MMRestNotImplementedException *nex = [[MMRestNotImplementedException alloc] initWithReason:@"Serialisation function not implemented for MyMovingJobs" userInfo:nil];
    
    @throw nex;
}

@end
