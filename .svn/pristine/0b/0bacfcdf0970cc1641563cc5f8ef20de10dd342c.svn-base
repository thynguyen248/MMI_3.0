//
//  MMRestBidClientImpl.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 5/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestBidClient.h"
#import "MMRestHttpTransmission.h"
#import "MMSerialisationFactory.h"
#import "MMRestHttpAuthorisedTransmission.h"

@interface MMRestBidClientImpl : NSObject<MMRestBidClient> {
    id<MMRestHttpTransmission> httpTransmission;
    id<MMSerialisationFactory> serialisationFactory;
    id<MMRestHttpAuthorisedTransmission> authorisedTransmission;
    NSString *secureDomainUrl;
    NSString *publicDomainUrl;
}

@property (retain, nonatomic) id<MMRestHttpTransmission> httpTransmission;
@property (retain, nonatomic) id<MMSerialisationFactory> serialisationFactory;
@property (strong, nonatomic) id<MMRestHttpAuthorisedTransmission> authorisedTransmission;
@property (strong, nonatomic) NSString *secureDomainUrl;
@property (strong, nonatomic) NSString *publicDomainUrl;

- (id) initWithTransmission: (id<MMRestHttpTransmission>) tx s11nFactory:(id<MMSerialisationFactory>) factory baseUrl:(NSString *) bUrl andPublicRelativePath:(NSString *) publicRelPath
      andSecureRelativePath:(NSString *) secureRelPath;

- (id) initWithTransmission: (id<MMRestHttpTransmission>) tx authTrans:(id<MMRestHttpAuthorisedTransmission>) authTrans s11nFactory:(id<MMSerialisationFactory>) factory baseUrl:(NSString *) bUrl andPublicRelativePath:(NSString *) publicRelPath
      andSecureRelativePath:(NSString *) secureRelPath;

@end
