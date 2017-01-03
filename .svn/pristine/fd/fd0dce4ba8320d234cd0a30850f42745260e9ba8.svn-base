//
//  MMRestUserClientImpl.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 5/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestUserClientImpl.h"
#import "MMRecentJobSummaryResponseSerialisation.h"
#import "MMRecentSummaryJobsResponse.h"
#import "MMRestHttpResponse.h"
#import "MMRestHttpAuthorisedTransmissionImpl.h"
#import "MMErrorUtils.h"
#import "MMUserProfileResponse.h"
#import "MMCompleteJobRequestSerialisation.h"
#import "MMCompleteJobRequest.h"
#import "MMRegistrationRequestSerialisation.h"
#import "MMRegistrationRequest.h"
#import "MMMessageDetailListResponseSerialisation.h"
#import "MMMessageDetailListResponse.h"
#import "MMSerialisationUtils.h"
#import "MMMyMovingJobsResponse.h"
#import "MMCanOfferIndemnityResponse.h"

@implementation MMRestUserClientImpl

@synthesize httpTransmission;
@synthesize serialisationFactory;
@synthesize publicDomainUrl;
@synthesize secureDomainUrl;
@synthesize authorisedTransmission;

- (id) initWithTransmission: (id<MMRestHttpTransmission>) tx s11nFactory:(id<MMSerialisationFactory>) factory baseUrl:(NSString *) bUrl publicRelativePath:(NSString*) pubRelPath andSecureRelativePath:(NSString *) secRelPath {
    self = [super init];
    if (self) {
        self.httpTransmission = tx;
        self.serialisationFactory = factory;
        self.publicDomainUrl = [bUrl stringByAppendingPathComponent:pubRelPath];
        self.secureDomainUrl = [bUrl stringByAppendingPathComponent:secRelPath];
        self.authorisedTransmission = [[MMRestHttpAuthorisedTransmissionImpl alloc] initWithTransmissionDelegate:self.httpTransmission];
        return self;
    }
    
    return nil;
}

- (MMUserProfile *) getUserProfileForToken:(MMRestAccessToken *)token {
    if (token == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Token was nil" userInfo:nil];
    
    NSString *userDetailUrl = self.secureDomainUrl;
    
    MMRestHttpResponse *userProfileResponse = [self.authorisedTransmission authorisedMethod:@"GET" toUrl:userDetailUrl withRequestBody:nil additionalRequestHeaders:nil andAccessToken:token];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:userProfileResponse withReason:@"Could not retrieve user profile" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    MMUserProfileResponseSerialisation *upS11n = [serialisationFactory getMMUserProfileResponseSerialisation];
    
    MMUserProfileResponse *profileResponse = [upS11n deserialiseData:userProfileResponse.responseBody];
    
    return profileResponse.userProfile;
}

- (NSArray *) getJobsForUserWithToken:(MMRestAccessToken *) token {
    if (token == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Token was nil" userInfo:nil];
    
    // use the username in the request to compose a jobs uri for the resource
    NSString *userJobsSummaryUrl = [[secureDomainUrl stringByAppendingPathComponent:[token.userId stringValue]] stringByAppendingPathComponent:@"jobs"];
    
    // should use token here!
    MMRestHttpResponse *httpResponse = [self.authorisedTransmission authorisedMethod:@"GET" toUrl:userJobsSummaryUrl withRequestBody:nil additionalRequestHeaders:nil andAccessToken:token];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not retrieve jobs for user" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    MMRecentJobSummaryResponseSerialisation *serialisation
        = [serialisationFactory getMMRecentJobSummaryResponseSerialisation];
    
    MMRecentSummaryJobsResponse *response
        = [serialisation deserialiseData:httpResponse.responseBody];
    
    return response.jobs;
}

- (NSArray *) getMatchingJobsForUserWithToken:(MMRestAccessToken *) token {
    if (token == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Token was nil" userInfo:nil];
    
    // use the username in the request to compose a jobs uri for the resource
    NSString *userJobsSummaryUrl = [secureDomainUrl stringByAppendingPathComponent:@"matchedJobs"];
    
    // should use token here!
    MMRestHttpResponse *httpResponse = [self.authorisedTransmission authorisedMethod:@"GET" toUrl:userJobsSummaryUrl withRequestBody:nil additionalRequestHeaders:nil andAccessToken:token];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not retrieve matching jobs for user" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    MMRecentJobSummaryResponseSerialisation *serialisation = [serialisationFactory getMMRecentJobSummaryResponseSerialisation];
    
    MMRecentSummaryJobsResponse *response = [serialisation deserialiseData:httpResponse.responseBody];
    
    return response.jobs;
}

- (BOOL) registerUserProfile:(MMNewUser *)userProfile {
    if (userProfile == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"User profile to register was nil" userInfo:nil];
    
    // serialise request
    MMRegistrationRequestSerialisation *requestSerialisation = [serialisationFactory getMMRegistrationRequestSerialisation];
    
    MMRegistrationRequest *request = [[MMRegistrationRequest alloc] init];
    request.userProfile = userProfile;
    
    NSData *requestData = [requestSerialisation serialise:request];
    
    NSMutableDictionary *httpRequestHeaders = [[NSMutableDictionary alloc] init];
    [httpRequestHeaders setValue:@"application/json" forKey:@"Content-Type"];
    [httpRequestHeaders setValue:@"text/json" forKey:@"Accept"];
    
    NSString* registerUrl = publicDomainUrl;
    
    DLog(@"About to POST to %@ with body %@ and header %@", registerUrl, requestData, httpRequestHeaders);
    
    MMRestHttpResponse *registerResponse = [self.httpTransmission httpPOST:registerUrl withBody:requestData withHeaderParams:httpRequestHeaders];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:registerResponse withReason:@"Could not submit user registration" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    return (registerResponse && registerResponse.responseCode == 201);
}

- (NSArray *) getMessagesForUserWithToken:(MMRestAccessToken *) token {
    if (token == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Token was invalid" userInfo:nil];
    
    NSString *userUrl = [self.secureDomainUrl stringByAppendingPathComponent:[[token userId] stringValue]];
    NSString *commsUrl = [userUrl stringByAppendingPathComponent:@"comms"];
    
    MMRestHttpResponse *response = [authorisedTransmission authorisedMethod:@"GET" toUrl:commsUrl withRequestBody:nil additionalRequestHeaders:nil andAccessToken:token];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:response withReason:@"Could not retrieve users messages" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    MMMessageDetailListResponseSerialisation *s11n = [serialisationFactory getMMMessageDetailListResponseSerialisation];
    
    MMMessageDetailListResponse *listResponse = [s11n deserialiseData:response.responseBody];
    
    return listResponse.messageList;
}

- (BOOL) sendVerifySMS:(NSString*)mobileNumber {
    DLog(@"Sending Verification SMS to: %@", mobileNumber );
    
    if (mobileNumber == nil || [mobileNumber length] == 0) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Mobile Number was invalid" userInfo:nil];
    
    NSMutableDictionary* dictionary = [NSMutableDictionary dictionaryWithObject:mobileNumber forKey:@"mobileNumber"];
    NSData* data = [MMSerialisationUtils serialiseData:dictionary originalObject:nil];
    
    NSString* url = [publicDomainUrl stringByAppendingPathComponent:@"sendVerifySMS"];
    
    NSMutableDictionary *httpRequestHeaders = [[NSMutableDictionary alloc] init];
    [httpRequestHeaders setValue:@"application/json" forKey:@"Content-Type"];
    [httpRequestHeaders setValue:@"text/json" forKey:@"Accept"];
    
    MMRestHttpResponse *response = [self.httpTransmission httpPOST:url withBody:data withHeaderParams:httpRequestHeaders];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:response withReason:@"Could not send verification SMS" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    return (response && response.responseCode == 200);
}

- (BOOL) canOfferIndemnity:(NSNumber*) userId token:(MMRestAccessToken *) token {
    NSString* url = [secureDomainUrl stringByAppendingPathComponent:[userId stringValue]];
    url = [url stringByAppendingPathComponent:@"canOfferIndemnity"];
    
    NSMutableDictionary *httpRequestHeaders = [[NSMutableDictionary alloc] init];
    [httpRequestHeaders setValue:@"application/json" forKey:@"Content-Type"];
    [httpRequestHeaders setValue:@"text/json" forKey:@"Accept"];
    
    MMRestHttpResponse *response = [self.authorisedTransmission authorisedMethod:@"POST" toUrl:url withRequestBody:nil additionalRequestHeaders:httpRequestHeaders andAccessToken:token];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:response withReason:@"Could not determine if indemnification can be offered" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    MMCanOfferIndemnityResponseSerialisation *s11n = [serialisationFactory getMMCanOfferIndemnityResponseSerialisation];
    MMCanOfferIndemnityResponse* responseObj = [s11n deserialiseData:response.responseBody];
    
    return responseObj.canOffer;
}

-(NSArray *) getMyPostedJobsWithAccessToken:(MMRestAccessToken *)token {
    if(!token) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"No Authentication Token" userInfo:nil];
    }
    
    NSString* url = [secureDomainUrl stringByAppendingPathComponent:@"createdJobsList"];
    
    MMRestHttpResponse *httpResponse = [authorisedTransmission authorisedMethod:@"GET" toUrl:url withRequestBody:nil additionalRequestHeaders:nil andAccessToken:token];
    
    // throw an exception if an error occurred on the response
    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not retrieve my posted jobs" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    MMRecentJobSummaryResponseSerialisation *responseSerialisation = [serialisationFactory getMMRecentJobSummaryResponseSerialisation];
    
    MMRecentSummaryJobsResponse *response = [responseSerialisation deserialiseData:httpResponse.responseBody];
    
    return response.jobs;
}

-(NSDictionary *) getMyMovingJobsWithAccessToken:(MMRestAccessToken *)token {
    if(!token) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"No Authentication Token" userInfo:nil];
    }
    
    NSString* url = [secureDomainUrl stringByAppendingPathComponent:@"bidJobsList"];
    
    MMRestHttpResponse *httpResponse = [authorisedTransmission authorisedMethod:@"GET" toUrl:url withRequestBody:nil additionalRequestHeaders:nil andAccessToken:token];
    
    // throw an exception if an error occurred on the response
    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not retrieve my posted jobs" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    MMMyMovingJobsResponseSerialisation *responseSerialisation = [serialisationFactory getMMMyMovingJobResponseSerialisation];
    
    MMMyMovingJobsResponse *response = [responseSerialisation deserialiseData:httpResponse.responseBody];
    
    return response.jobs;
}

@end
