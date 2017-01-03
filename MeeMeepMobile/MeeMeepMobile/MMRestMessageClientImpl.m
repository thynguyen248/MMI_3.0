//
//  MMMessageClientImpl.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 4/04/13.
//
//

#import "MMRestMessageClientImpl.h"
#import "MMRestHttpAuthorisedTransmissionImpl.h"
#import "MMCreateMessageRequest.h"
#import "MMErrorUtils.h"

@implementation MMRestMessageClientImpl

- (id) initWithTransmission: (id<MMRestHttpTransmission>) tx s11nFactory:(id<MMSerialisationFactory>) factory baseUrl:(NSString *) bUrl andPublicRelativePath:(NSString *) publicRelPath
      andSecureRelativePath:(NSString *) secureRelPath {
    if(self = [super init]) {
        transmission = tx;
        serialisationFactory = factory;
        publicDomainUrl = [bUrl stringByAppendingPathComponent:publicRelPath];
        secureDomainUrl = [bUrl stringByAppendingPathComponent:secureRelPath];
        authorisedHttpTransmission = [[MMRestHttpAuthorisedTransmissionImpl alloc] initWithTransmissionDelegate:transmission];
    }

    return self;
}

- (BOOL) sendMessage:(MMMessageDetail *) message withAccessToken:(MMRestAccessToken *) token {
    NSString *url = [secureDomainUrl stringByAppendingPathComponent:@"create"];
    
    MMCreateMessageRequest *request = [[MMCreateMessageRequest alloc] init];
    request.message = message;
    
    MMCreateMessageRequestSerialization *requestSerialisation = [serialisationFactory getMMCreateMessageRequestSerialization];
    
    NSData *requestBody = [requestSerialisation serialise:request];
    
    NSMutableDictionary *httpRequestHeaders = [[NSMutableDictionary alloc] init];
    [httpRequestHeaders setValue:@"application/json; charset=utf-8" forKey:@"Content-Type"];
    
    MMRestHttpResponse *httpResponse = [authorisedHttpTransmission authorisedMethod:@"POST" toUrl:url withRequestBody:requestBody additionalRequestHeaders:httpRequestHeaders andAccessToken:token];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not create message" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    // no body response
    
    return (httpResponse != nil && httpResponse.responseCode == 201); // created!
}

@end
