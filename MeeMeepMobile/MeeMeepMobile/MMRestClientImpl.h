//
//  MMRestClientDefaultImpl.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestClient.h"
#import "MMRestHttpTransmission.h"
#import "MMSerialisationFactory.h"

@interface MMRestClientImpl : NSObject <MMRestClient> {

@protected
    id<MMRestHttpTransmission> httpTransmission;
    id<MMSerialisationFactory> serialisationFactory;
    NSString *baseUrl;
    BOOL initialised;
    NSMutableDictionary *domainUrlMapping;
}

@property (strong, nonatomic) id<MMRestHttpTransmission> httpTransmission;
@property (strong, nonatomic) id<MMSerialisationFactory> serialisationFactory;
@property (strong, nonatomic) NSMutableDictionary *domainUrlMapping;
@property (strong, nonatomic) NSString *baseUrl;

- (id) initWithTransmission:(id<MMRestHttpTransmission>) transmission 
                s11nFactory:(id<MMSerialisationFactory>) factory 
                 andBaseUrl:(NSString *) url;

/*
 * initialises the API with the backend system
 */
- (void) initialise;

@end
