//
//  MMRestJobsClientImpl.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestJobsClient.h"
#import "MMSerialisationFactory.h"
#import "MMRestHttpTransmission.h"
#import "MMRestHttpAuthorisedTransmission.h"

@interface MMRestJobsClientImpl : NSObject<MMRestJobsClient> {
    id <MMSerialisationFactory> serialisationFactory;
    id <MMRestHttpTransmission> transmission;
    id <MMRestHttpAuthorisedTransmission> authorisedHttpTransmission;
    NSString *secureDomainUrl;
    NSString *publicDomainUrl;
}

@property (retain, nonatomic) id<MMSerialisationFactory> serialisationFactory;
@property (retain, nonatomic) id<MMRestHttpTransmission> transmission;
@property (strong, nonatomic) NSString *publicDomainUrl;
@property (strong, nonatomic) NSString *secureDomainUrl;
@property (strong, nonatomic) id<MMRestHttpAuthorisedTransmission> authorisedHttpTransmission;

- (id) initWithTransmission: (id<MMRestHttpTransmission>) tx s11nFactory:(id<MMSerialisationFactory>) factory baseUrl:(NSString *) bUrl andPublicRelativePath:(NSString *) publicRelPath
      andSecureRelativePath:(NSString *) secureRelPath;

@end
