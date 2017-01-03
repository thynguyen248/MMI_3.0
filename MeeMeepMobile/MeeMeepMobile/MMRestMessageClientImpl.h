//
//  MMMessageClientImpl.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 4/04/13.
//
//

#import <Foundation/Foundation.h>

#import "MMRestMessageClient.h"
#import "MMSerialisationFactory.h"
#import "MMRestHttpTransmission.h"
#import "MMRestHttpAuthorisedTransmission.h"

@interface MMRestMessageClientImpl : NSObject<MMRestMessageClient> {
    id <MMSerialisationFactory> serialisationFactory;
    id <MMRestHttpTransmission> transmission;
    id <MMRestHttpAuthorisedTransmission> authorisedHttpTransmission;
    NSString *secureDomainUrl;
    NSString *publicDomainUrl;
}

- (id) initWithTransmission: (id<MMRestHttpTransmission>) tx s11nFactory:(id<MMSerialisationFactory>) factory baseUrl:(NSString *) bUrl andPublicRelativePath:(NSString *) publicRelPath
      andSecureRelativePath:(NSString *) secureRelPath;

@end
