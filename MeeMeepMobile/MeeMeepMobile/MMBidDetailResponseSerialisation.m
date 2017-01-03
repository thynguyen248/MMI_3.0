//
//  MMBidDetailResponseSerialistion.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 3/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMBidDetailResponseSerialisation.h"
#import "MMBidDetail.h"
#import "MMBidDetailResponse.h"
#import "MMRestDeserialisationException.h"
#import "MMRestNotImplementedException.h"
#import "MMSerialisationUtils.h"

@implementation MMBidDetailResponseSerialisation

@synthesize s11nDateHelper;

- (id<MMObject>) deserialiseData:(NSData*) data {
    @try {
        NSDictionary *bidResponseDict = [MMSerialisationUtils deserialiseData:data];
        
        MMBidDetail *bidDetail = [MMBidDetail getBidDetailFromDictionary:[bidResponseDict valueForKey:@"bid"]];
        
        if (bidDetail == nil) {
            MMRestDeserialisationException *anotherBadEx = [[MMRestDeserialisationException alloc] initWithReason:@"Bid detail was nil after construction from dictionary" userInfo:nil nestedException:nil containedError:nil serialisedData:data];
            
            @throw anotherBadEx;
        }

        
        MMBidDetailResponse *response = [[MMBidDetailResponse alloc] init];
        
        response.bidDetail = bidDetail;
        
        return response;
    } @catch (NSException *anyEx) {
        MMRestDeserialisationException *dex = [[MMRestDeserialisationException alloc] initWithReason:@"Could not deserialise bid detail response" userInfo:nil nestedException:anyEx containedError:nil serialisedData:nil];
        
        @throw dex;
    }
}



- (NSData*) serialise:(id <MMObject>) object {
    MMRestNotImplementedException *niEx = [[MMRestNotImplementedException alloc] initWithReason:@"Serialisation of bid detail response not implemented" userInfo:nil];
    
    @throw niEx;
}

- (id) initWithDateHelper:(id<MMSerialisationDateHelper>) dateHelper {
    self = [super init];
    if (self) {
        self.s11nDateHelper = dateHelper;
        return self;
    }
    
    return nil;
}

@end
