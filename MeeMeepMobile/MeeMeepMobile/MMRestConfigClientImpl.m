//
//  MMRestConfigClientImpl.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 20/02/13.
//
//

#import "MMRestConfigClientImpl.h"
#import "MMErrorUtils.h"
#import "MMConfigResponseSerialisation.h"
#import "MMConfig.h"

@implementation MMRestConfigClientImpl

- (id) initWithTransmission: (id<MMRestHttpTransmission>) tx s11nFactory:(id<MMSerialisationFactory>) factory baseUrl:(NSString *) bUrl andRelativePath:(NSString *) relPath {
    if (self = [super init]) {
        httpTransmission = tx;
        serialisationFactory = factory;
        domainUrl = [bUrl stringByAppendingPathComponent:relPath];
    }
    
    return self;    
}

-(MMConfig *) getConfiguration:(NSInteger) currentConfigHash {
    NSString *configURL = [domainUrl stringByAppendingFormat:@"/%d", currentConfigHash];
    
    MMRestHttpResponse* configResponse = [httpTransmission httpGET:configURL
                                                         withBody:nil
                                                 withHeaderParams:nil];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:configResponse withReason:@"Could not retrieve configuration" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    MMConfigResponseSerialisation *s11n = [serialisationFactory getMMConfigResponseSerialisation];
    
    MMConfig *profileResponse = [s11n deserialiseData:configResponse.responseBody];
    
    return profileResponse;
}

@end
