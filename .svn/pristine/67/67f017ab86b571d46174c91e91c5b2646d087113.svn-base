//
//  MMJobStatus.m
//  MeeMeepMobile
//
//  Created by Julian Raff on 1/03/13.
//
//

#import "MMJobStatus.h"

static NSMutableArray* mapping;

@implementation MMJobStatus

+ (void) initialize
{
    DLog(@"MMJobStatus main()");
    if(mapping == nil)
    {
        mapping = [NSMutableArray arrayWithCapacity:9];
        
        [mapping addObject:[[MMJobStatus alloc] initWithString:@"JOB_CREATED"
                                             displayableString:@"Created"
                                                       andEnum:JOB_CREATED]];
        
        [mapping addObject:[[MMJobStatus alloc] initWithString:@"BID_ACCEPTED"
                                             displayableString:@"Bid Accepted"
                                                       andEnum:BID_ACCEPTED]];
        
        [mapping addObject:[[MMJobStatus alloc] initWithString:@"JOB_EXPIRED"
                                             displayableString:@"Expired"
                                                       andEnum:JOB_EXPIRED]];
        
        [mapping addObject:[[MMJobStatus alloc] initWithString:@"JOB_CANCELLED"
                                             displayableString:@"Cancelled"
                                                       andEnum:JOB_CANCELLED]];
        
        [mapping addObject:[[MMJobStatus alloc] initWithString:@"AWAITING_CUSTOMER_COMPLETION"
                                             displayableString:@"Awaiting Customer Completion"
                                                       andEnum:AWAITING_CUSTOMER_COMPLETION]];
        
        [mapping addObject:[[MMJobStatus alloc] initWithString:@"COMPLETED"
                                             displayableString:@"Completed"
                                                       andEnum:COMPLETED]];
        
        [mapping addObject:[[MMJobStatus alloc] initWithString:@"CLOSED"
                                             displayableString:@"Closed"
                                                       andEnum:CLOSED]];
        
        [mapping addObject:[[MMJobStatus alloc] initWithString:@"DISPUTED"
                                             displayableString:@"Disputed"
                                                       andEnum:DISPUTED]];
    }
}

-(id) initWithString:(NSString*)statusStr displayableString:(NSString*)displayableStr andEnum:(JobStatus)jobStatus
{
    self = [super init];
    if(self)
    {
        self.statusString = statusStr;
        self.displayableString = displayableStr;
        self.status = jobStatus;
    }
    return self;
}

+(MMJobStatus*) statusFromString:(NSString*)statusString
{
    if(statusString == nil)
    {
        return nil;
    }
    for (MMJobStatus* jobStatus in mapping) {
        if([jobStatus.statusString isEqualToString:statusString])
        {
            return jobStatus;
        }
    }
    return nil;
}

+(MMJobStatus*) statusFromEnum:(JobStatus)status
{
    for (MMJobStatus* jobStatus in mapping) {
        if(jobStatus.status == status)
        {
            return jobStatus;
        }
    }
    return nil;
}

-(Boolean) is:(JobStatus)status
{
    return self.status == status;
}

-(Boolean) compareTo:(MMJobStatus*)otherStatus
{
    if(otherStatus == nil)
    {
        return false;
    }
    if(self.status != otherStatus.status)
    {
        return false;
    }
    if(![self.statusString isEqualToString:otherStatus.statusString])
    {
        return false;
    }
    if(![self.displayableString isEqualToString:otherStatus.displayableString])
    {
        return false;
    }
    return true;
}

@end
