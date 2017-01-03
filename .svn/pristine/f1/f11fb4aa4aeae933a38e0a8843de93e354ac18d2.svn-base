//
//  MMJobDetailResponseSerialisation.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMJobDetailResponseSerialisation.h"
#import "MMJobDetailResponse.h"
#import "MMJobDetail.h"
#import "MMJobAddress.h"
#import "MMRestDeserialisationException.h"
#import "MMRestNotImplementedException.h"
#import "MMSerialisationUtils.h"

@implementation MMJobDetailResponseSerialisation

@synthesize dateSerialisation;

- (id<MMObject>) deserialiseData:(NSData*) data {
    @try {
        NSDictionary *rootJobDetail = [MMSerialisationUtils deserialiseData:data];
        
        MMJobDetail *jobDetail = [MMJobDetail getJobDetailForDictionary:[rootJobDetail valueForKey:@"job"] withDateSerialiser:self.dateSerialisation];
        
        MMJobDetailResponse *response = [[MMJobDetailResponse alloc] init];
        response.jobDetail = jobDetail;
        
        return response;
    } @catch (NSException *ex) {
        MMRestDeserialisationException *ds11nEx = [[MMRestDeserialisationException alloc] initWithReason:@"Could not deserialise job detail response data" userInfo:nil nestedException:ex containedError:nil serialisedData:nil];
        
        @throw ds11nEx;
    }
}


- (NSData*) serialise:(id <MMObject>) object {
    MMRestNotImplementedException *nex = [[MMRestNotImplementedException alloc] initWithReason:@"Serialisation of job detail response not implemented!" userInfo:nil];
    @throw nex;
}



- (id) initWithDateHelper:(id<MMSerialisationDateHelper>) dateHelper {
    
    self = [super init];
    
    if (self) {
        self.dateSerialisation = dateHelper;
        return self;
    }
    
    return nil;
}



@end
