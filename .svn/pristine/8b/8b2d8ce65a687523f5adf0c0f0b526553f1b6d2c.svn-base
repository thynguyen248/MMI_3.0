//
//  MMRestDefaultClientFactory.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestClientFactory.h"
#import "MMRestHttpTransmission.h"
#import "MMSerialisationFactory.h"

@interface MMRestClientFactoryImpl : NSObject <MMRestClientFactory> {

@protected
    id<MMSerialisationFactory> serialisationFactory;
    id<MMRestHttpTransmission> transmission;
    NSString *meemeepUrl;
}

@property (retain, nonatomic) id<MMSerialisationFactory> serialisationFactory;
@property (retain, nonatomic) id<MMRestHttpTransmission> transmission;
@property (strong, nonatomic) NSString *meemeepUrl;

- (id) initWithTransmission:(id<MMRestHttpTransmission>) tx s11nFactory:(id<MMSerialisationFactory>) factory meemeepUrl:(NSString *) url;

// alternate signature for URL
- (id) initWithUrl:(NSString *) url;

@end
