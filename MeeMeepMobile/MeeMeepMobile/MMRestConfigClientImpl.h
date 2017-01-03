//
//  MMRestConfigClientImpl.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 20/02/13.
//
//

#import <UIKit/UIKit.h>

#import "MMRestConfigClient.h"
#import "MMRestHttpTransmission.h"
#import "MMSerialisationFactory.h"
#import "MMRestHttpAuthorisedTransmission.h"

@interface MMRestConfigClientImpl : NSObject<MMRestConfigClient> {
    id<MMRestHttpTransmission> httpTransmission;
    id<MMSerialisationFactory> serialisationFactory;
    NSString *domainUrl;
}

- (id) initWithTransmission: (id<MMRestHttpTransmission>) tx s11nFactory:(id<MMSerialisationFactory>) factory baseUrl:(NSString *) bUrl andRelativePath:(NSString *) relPath;

@end
