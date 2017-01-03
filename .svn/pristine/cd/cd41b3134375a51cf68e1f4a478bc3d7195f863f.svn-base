//
//  MMRestBidClientImpl.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 5/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestBidClientImpl.h"

#import "MMBidDetail.h"
#import "MMBidDetailResponse.h"
#import "MMBidDetailResponseSerialisation.h"
#import "MMRestHttpResponse.h"
#import "MMRestHttpAuthorisedTransmissionImpl.h"
#import "MMBidAcceptRequest.h"
#import "MMBidCreationRequest.h"

#import "MMErrorUtils.h"

@implementation MMRestBidClientImpl

@synthesize httpTransmission;
@synthesize serialisationFactory;
@synthesize secureDomainUrl;
@synthesize publicDomainUrl;
@synthesize authorisedTransmission;

- (id) initWithTransmission: (id<MMRestHttpTransmission>) tx s11nFactory:(id<MMSerialisationFactory>) factory baseUrl:(NSString *) bUrl andPublicRelativePath:(NSString *) publicRelPath
      andSecureRelativePath:(NSString *) secureRelPath {
    
    return [self initWithTransmission:tx authTrans:[[MMRestHttpAuthorisedTransmissionImpl alloc] initWithTransmissionDelegate:tx] s11nFactory:factory baseUrl:bUrl andPublicRelativePath:publicRelPath andSecureRelativePath:secureRelPath];
}

- (id) initWithTransmission: (id<MMRestHttpTransmission>) tx authTrans:(id<MMRestHttpAuthorisedTransmission>) authTrans s11nFactory:(id<MMSerialisationFactory>) factory baseUrl:(NSString *) bUrl andPublicRelativePath:(NSString *) publicRelPath
      andSecureRelativePath:(NSString *) secureRelPath {
    if (self = [super init]) {
        self.httpTransmission = tx;
        self.serialisationFactory = factory;
        self.publicDomainUrl = [bUrl stringByAppendingPathComponent:publicRelPath];
        self.secureDomainUrl = [bUrl stringByAppendingPathComponent:secureRelPath];
        self.authorisedTransmission = authTrans;
    }
    
    return self;
}

- (MMBidDetail *) getBidDetailWithId:(NSNumber *) bidId andAccessToken:(MMRestAccessToken *) token {
    
    NSString *bidDetailUrl = [self.secureDomainUrl stringByAppendingPathComponent:[bidId stringValue]];
    
    // make the request for the resource which is the baseurl + the bid id
    // insert the access token creds into the http header param
    
    MMRestHttpResponse *httpResponse = [self.authorisedTransmission authorisedMethod:@"GET" toUrl:bidDetailUrl withRequestBody:nil additionalRequestHeaders:nil andAccessToken:token];

    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not retrieve bid details" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    MMBidDetailResponseSerialisation *serialisation = [self.serialisationFactory getMMBidDetailResponseSerialisation];
    
    MMBidDetailResponse *response = [serialisation deserialiseData:httpResponse.responseBody];
    
    return response.bidDetail;
}

- (BOOL) createBidWithDetail:(MMBidDetail *) bidDetail forJobWithId:(NSInteger) jobId withAccessToken:(MMRestAccessToken *) token {
    
    NSString *bidDetailUrl = [NSString stringWithFormat:@"%@/save", self.secureDomainUrl];
    
    MMBidCreationRequestSerialisation *serialisation = [self.serialisationFactory getMMBidCreationRequestSerialisation];
    
    MMBidCreationRequest* request = [[MMBidCreationRequest alloc] init];
    request.bidDetail = bidDetail;
    
    NSData* body = [serialisation serialise:request];
    
    NSMutableDictionary *httpRequestHeaders = [[NSMutableDictionary alloc] init];
    [httpRequestHeaders setValue:@"application/json; charset=utf-8" forKey:@"Content-Type"];
    
    MMRestHttpResponse *httpResponse = [self.authorisedTransmission authorisedMethod:@"POST" toUrl:bidDetailUrl withRequestBody:body additionalRequestHeaders:httpRequestHeaders andAccessToken:token];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not create bid" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    return (httpResponse != nil && httpResponse.responseCode == 201);
}

- (BOOL) acceptBid:(MMBidAcceptRequest *) acceptBid andAccessToken:(MMRestAccessToken *) token {
    if (acceptBid == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Bid to accept was nil" userInfo:nil];
    if (token == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Access token to accept bid was nil" userInfo:nil];
    
    NSString *bidAcceptUrl = [self.secureDomainUrl stringByAppendingPathComponent:@"acceptBid"];
    
    MMBidAcceptRequestSerialisation *serialisation = [self.serialisationFactory getMMBidAcceptRequestSerialisation];
    
    NSData* body = [serialisation serialise:acceptBid];
    
    MMRestHttpResponse *httpResponse = [self.authorisedTransmission authorisedMethod:@"POST" toUrl:bidAcceptUrl withRequestBody:body additionalRequestHeaders:nil andAccessToken:token];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not accept bid" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    if (httpResponse.responseCode == 201) {
        return YES;
    }
    return NO;
}

- (BOOL) withdrawBidWithId:(NSNumber *) bidId andAccessToken:(MMRestAccessToken *) token {
    
    NSString *bidDetailUrl = [[self.secureDomainUrl stringByAppendingPathComponent:[bidId stringValue]] stringByAppendingPathComponent:@"withdraw"];
    
    MMRestHttpResponse *httpResponse = [self.authorisedTransmission authorisedMethod:@"POST" toUrl:bidDetailUrl withRequestBody:nil additionalRequestHeaders:nil andAccessToken:token];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not withdraw bid" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    if (httpResponse.responseCode == 200) {
        return YES;
    }
    return NO;
}


@end
