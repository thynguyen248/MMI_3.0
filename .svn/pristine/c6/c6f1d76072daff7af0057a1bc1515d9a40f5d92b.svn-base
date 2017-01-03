//
//  MMRestUserClientImpl.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 5/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestUserClient.h"
#import "MMRestHttpTransmission.h"
#import "MMSerialisationFactoryImpl.h"
#import "MMRestHttpAuthorisedTransmission.h"

@interface MMRestUserClientImpl : NSObject <MMRestUserClient> {
    id<MMRestHttpTransmission> httpTransmission;
    id<MMSerialisationFactory> serialisationFactory;
    id<MMRestHttpAuthorisedTransmission> authorisedTransmission;
    NSString *publicDomainUrl;
    NSString *secureDomainUrl;
}

@property (strong, nonatomic) id<MMRestHttpAuthorisedTransmission> authorisedTransmission;
@property (strong, nonatomic) id<MMRestHttpTransmission> httpTransmission;
@property (strong, nonatomic) id<MMSerialisationFactory> serialisationFactory;
@property (copy, nonatomic) NSString *publicDomainUrl;
@property (copy, nonatomic) NSString *secureDomainUrl;

- (id) initWithTransmission: (id<MMRestHttpTransmission>) tx s11nFactory:(id<MMSerialisationFactory>) factory baseUrl:(NSString *) bUrl publicRelativePath:(NSString*) pubRelPath andSecureRelativePath:(NSString *) secRelPath;

@end
