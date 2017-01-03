//
//  MMJobSummary.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMJobSummary.h"
#import "MMSerialisationUtils.h"

@implementation MMJobSummary

+ (MMJobSummary*) getJobSummaryFromDictionary:(NSDictionary *) dictionary {
    
    MMJobSummary *job = [[MMJobSummary alloc] init];
    
    job.jobId           = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"id"]];
    job.title           = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"title"]];
    job.jobStatus       = [MMJobStatus statusFromString:[MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"status"]]];
    job.fromLocation    = [MMLocation getLocationForDictionary:[MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"fromLocation"]]];
    job.toLocation      = [MMLocation getLocationForDictionary:[MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"toLocation"]]];
    
    job.deliveryDate = [MMSerialisationUtils getDateFromRFC3339String:[MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"deliveryDateEnd"]]];
    job.pickupDate = [MMSerialisationUtils getDateFromRFC3339String:[MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"pickupDateStart"]]];
    
    job.expiryDate = [MMSerialisationUtils getDateFromRFC3339String:[MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"expiryDate"]]];
    
    return job;
}

@end
