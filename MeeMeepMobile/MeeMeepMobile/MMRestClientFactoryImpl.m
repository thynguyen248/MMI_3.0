//
//  MMRestDefaultClientFactory.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestClientFactoryImpl.h"
#import "MMRestClientImpl.h"
#import "MMRestHttpTransmission.h"
#import "MMRestHttpTransmissionImpl.h"
#import "MMSerialisationFactoryImpl.h"

@implementation MMRestClientFactoryImpl

@synthesize transmission;
@synthesize serialisationFactory;
@synthesize meemeepUrl;

- (id<MMRestClient>) createRestClient:(BOOL) initialising {
    
    // operation should attempt to fetch the first level domain
    
    MMRestClientImpl *impl = [[MMRestClientImpl alloc] initWithTransmission:self.transmission s11nFactory:self.serialisationFactory andBaseUrl:self.meemeepUrl];
    
    if (initialising) {
        [impl initialise];
    }
    
    return impl;
}

- (id) initWithUrl:(NSString *) url {
    self = [super init];
    
    if (self) {
        self.transmission = [[MMRestHttpTransmissionImpl alloc] init];
        self.serialisationFactory = [[MMSerialisationFactoryImpl alloc] init];
        self.meemeepUrl = url;
        return self;
    }
    
    return nil;
}

- (id) initWithTransmission:(id<MMRestHttpTransmission>) tx s11nFactory:(id<MMSerialisationFactory>) factory meemeepUrl:(NSString *)url {
            
    self = [super init];
    if (self) {
        self.transmission = tx;
        self.serialisationFactory = factory;
        self.meemeepUrl = url;
        return self;
    }
    
    return nil;
}

@end
