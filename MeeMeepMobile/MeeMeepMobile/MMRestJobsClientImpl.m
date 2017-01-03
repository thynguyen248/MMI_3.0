//
//  MMRestJobsClientImpl.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestJobsClientImpl.h"
#import "MMRecentSummaryJobsResponse.h"
#import "MMJobDetailResponse.h"
#import "MMBidSummaryResponseSerialisation.h"
#import "MMBidSummaryResponse.h"
#import "MMRestHttpResponse.h"
#import "MMRestHttpAuthorisedTransmissionImpl.h"
#import "MMJobCreationRequest.h"
#import "MMJobCreationRequestSerialisation.h"
#import "MMRestHttpRemoteException.h"
#import "MMRestError.h"
#import "MMRestException.h"
#import "MMErrorUtils.h"
#import "MMBidCreationRequest.h"
#import "MMRestJobsClientHelper.h"
#import "MMRestJobsSearchParams.h"
#import "MMMyMovingJobsResponseSerialisation.h"
#import "MMMyMovingJobsResponse.h"

#import "MMMessageDetailListResponseSerialisation.h"
#import "MMMessageDetailListResponse.h"
#import "MMMessageDetail.h"
#import "MMCreateMessageRequest.h"
#import "MMSerialisationDateHelperImpl.h"
#import "MMCompleteJobRequest.h"

@interface MMRestJobsClientImpl (hidden)
- (NSData *) getRawDataFromUrl:(NSString*)url;
@end

@implementation MMRestJobsClientImpl

@synthesize serialisationFactory, transmission, publicDomainUrl, secureDomainUrl;
@synthesize authorisedHttpTransmission;

- (id) initWithTransmission: (id<MMRestHttpTransmission>) tx s11nFactory:(id<MMSerialisationFactory>) factory baseUrl:(NSString *) bUrl andPublicRelativePath:(NSString *) publicRelPath
      andSecureRelativePath:(NSString *) secureRelPath {
    
    self = [super init];
    if (self) {
        self.transmission = tx;
        self.serialisationFactory = factory;
        self.publicDomainUrl = [bUrl stringByAppendingPathComponent:publicRelPath];
        self.secureDomainUrl = [bUrl stringByAppendingPathComponent:secureRelPath];
        self.authorisedHttpTransmission = [[MMRestHttpAuthorisedTransmissionImpl alloc] initWithTransmissionDelegate:self.transmission];
        
        return self;
    }
    
    return nil;
}

-(NSArray *) getRecentlyPostedSummaryJobsWithAccessToken:(MMRestAccessToken *)token {
    // no request body serialization
    
    NSString* url = [self.publicDomainUrl stringByAppendingPathComponent:@"list"];
    
    MMRestHttpResponse *httpResponse;
    if (token) {
        httpResponse = [authorisedHttpTransmission authorisedMethod:@"GET" toUrl:url withRequestBody:nil additionalRequestHeaders:nil andAccessToken:token];
    } else {
        httpResponse = [transmission httpGET:url withBody:nil withHeaderParams:nil];
    }
    
    // throw an exception if an error occurred on the response
    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not retrieve recent jobs" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];

    MMRecentJobSummaryResponseSerialisation *responseSerialisation = [serialisationFactory getMMRecentJobSummaryResponseSerialisation];

    MMRecentSummaryJobsResponse *response = [responseSerialisation deserialiseData:httpResponse.responseBody];

    NSArray *jobSummaryList = response.jobs;
    
    return jobSummaryList;
}

- (MMJobDetail *) getJobDetailForJobId:(NSNumber *) jobId withToken:(MMRestAccessToken *)token {
    // construct the job detail URL
    
    NSString *jobDetailURL = [self.publicDomainUrl stringByAppendingPathComponent:[jobId stringValue]];
    
    DLog(@"Requesting job detail for id [%@] using URL [%@]", jobId, jobDetailURL);
    
    MMRestHttpResponse *httpResponse = nil;
    if (token) {
        httpResponse = [authorisedHttpTransmission authorisedMethod:@"GET" toUrl:jobDetailURL withRequestBody:nil additionalRequestHeaders:nil andAccessToken:token];
    } else {
        httpResponse = [transmission httpGET:jobDetailURL
                       withBody:nil withHeaderParams:nil];
    }
    
    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not get details for job" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    MMJobDetailResponseSerialisation *responseSerialisation = [serialisationFactory getMMJobDetailResponseSerialisation];
    
    MMJobDetailResponse *response = [responseSerialisation deserialiseData:httpResponse.responseBody];
    
    return response.jobDetail;
}

- (BOOL) customerCompleteJobWithRating:(MMUserRating*)userRating withToken:(MMRestAccessToken *) token {
    if (userRating == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"User Rating was nil" userInfo:nil];
    if (token == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Access token to accept bid was nil" userInfo:nil];
    
    NSString *jobDetailUrl = [self.secureDomainUrl stringByAppendingPathComponent:[userRating.jobId stringValue]];
    NSString *customerCompleteUrl = [jobDetailUrl stringByAppendingPathComponent:@"ownerComplete"];
    
    MMCompleteJobRequestSerialisation *serialisation = [serialisationFactory getMMCompleteJobRequestSerialisation];
    
    MMCompleteJobRequest *request = [[MMCompleteJobRequest alloc] init];
    request.userRating = userRating;
    
    NSData* body = [serialisation serialise:request];
    
    MMRestHttpResponse *httpResponse = [self.authorisedHttpTransmission authorisedMethod:@"POST" toUrl:customerCompleteUrl withRequestBody:body additionalRequestHeaders:nil andAccessToken:token];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not withdraw bid" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    if (httpResponse.responseCode == 200) {
        return YES;
    }
    return NO;
}

- (BOOL) tpCompleteJob:(NSNumber *)jobId withToken:(MMRestAccessToken *) token {
    if (jobId == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"User Rating was nil" userInfo:nil];
    if (token == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Access token to accept bid was nil" userInfo:nil];
    
    NSString *jobDetailUrl = [self.secureDomainUrl stringByAppendingPathComponent:[jobId stringValue]];
    NSString *tpCompleteUrl = [jobDetailUrl stringByAppendingPathComponent:@"tpComplete"];
    
    MMRestHttpResponse *httpResponse = [self.authorisedHttpTransmission authorisedMethod:@"POST" toUrl:tpCompleteUrl withRequestBody:nil additionalRequestHeaders:nil andAccessToken:token];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not withdraw bid" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    if (httpResponse.responseCode == 200) {
        return YES;
    }
    return NO;
}

- (NSArray *) getBidSummaryListForJobId:(NSNumber *) jobId andAccessToken:(MMRestAccessToken *) token {
    
    NSString *jobDetailUrl = [self.secureDomainUrl stringByAppendingPathComponent:[jobId stringValue]];
    
    // hack!
    NSString *bidListForJobUrl = [jobDetailUrl stringByAppendingPathComponent:@"bids"];
    
    MMRestHttpResponse *httpResponse = [authorisedHttpTransmission authorisedMethod:@"GET" toUrl:bidListForJobUrl withRequestBody:nil additionalRequestHeaders:nil andAccessToken:token];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not retrieve bids for job" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
     
    MMBidSummaryResponseSerialisation *responseSerialisation = [serialisationFactory getMMBidSummaryResponseSerialisation];
    
    MMBidSummaryResponse *bidSummaryResponse = [responseSerialisation deserialiseData:httpResponse.responseBody];
    
    return bidSummaryResponse.bids;
}

- (BOOL) createJobWithDetail:(MMJobDetail *) jobDetail andAccessToken:(MMRestAccessToken *) token {

    
    
    // we are POST-ing this object to the domain URL
    //NSString *jobCreationURL = [self.domainUrl stringByAppendingString:@"/"];
    // use this when http redirect handling is cool
    NSMutableString *jobCreationURL = [NSMutableString stringWithString:self.secureDomainUrl];
    [jobCreationURL appendString:@"/save"];
    
    MMJobCreationRequest *request = [[MMJobCreationRequest alloc] init];
    request.jobDetail = jobDetail;
    
    MMJobCreationRequestSerialisation *requestSerialisation = [serialisationFactory getMMJobCreationRequestSerialisation];
    
    NSData *requestBody = [requestSerialisation serialise:request];
    
    NSMutableDictionary *httpRequestHeaders = [[NSMutableDictionary alloc] init];
    [httpRequestHeaders setValue:@"application/json; charset=utf-8" forKey:@"Content-Type"];
    
    MMRestHttpResponse *httpResponse = [authorisedHttpTransmission authorisedMethod:@"POST" toUrl:jobCreationURL withRequestBody:requestBody additionalRequestHeaders:httpRequestHeaders andAccessToken:token];

    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not create job" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    return (httpResponse != nil && httpResponse.responseCode == 201);
}

- (BOOL) createBidWithDetail:(MMBidDetail *) bidDetail forJobWithId:(NSInteger) jobId withAccessToken:(MMRestAccessToken *) token {
    NSString *jobIdString = [NSString stringWithFormat:@"%d", jobId];
    NSString *jobURL = [self.secureDomainUrl stringByAppendingPathComponent:jobIdString];
    NSString *bidCreationUrl = [jobURL stringByAppendingPathComponent:@"bids"];
    
    MMBidCreationRequest *request = [[MMBidCreationRequest alloc] init];
    request.bidDetail = bidDetail;
    
    MMBidCreationRequestSerialisation *requestSerialisation = [serialisationFactory getMMBidCreationRequestSerialisation];
    
    NSData *requestBody = [requestSerialisation serialise:request];
    
    NSMutableDictionary *httpRequestHeaders = [[NSMutableDictionary alloc] init];
    [httpRequestHeaders setValue:@"application/json; charset=utf-8" forKey:@"Content-Type"];
    
    MMRestHttpResponse *httpResponse = [authorisedHttpTransmission authorisedMethod:@"POST" toUrl:bidCreationUrl withRequestBody:requestBody additionalRequestHeaders:httpRequestHeaders andAccessToken:token];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not create bid" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    // no body response
    
    return (httpResponse != nil && httpResponse.responseCode == 201); // created!
}

- (NSArray *) searchJobsWithParameters:(NSDictionary *)searchParameters andToken:(MMRestAccessToken *) token {
    if (searchParameters == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Search parameters were nil" userInfo:nil];

    NSString *searchURL = [self.publicDomainUrl stringByAppendingString:@"?"];
    NSString *queryString = [MMRestJobsClientHelper queryStringFromSearchParameters:searchParameters];
    // compose a search URL based on the parameters
    NSString *finalSearchURL = [searchURL stringByAppendingString:queryString];
    DLog(@"Searching for jobs with URL:[%@]", finalSearchURL);

    // an unauthorized search request
    MMRestHttpResponse *httpResponse = nil;
    
    if (token) {
        httpResponse = [authorisedHttpTransmission authorisedMethod:@"GET" toUrl:finalSearchURL withRequestBody:nil additionalRequestHeaders:nil andAccessToken:token];
    } else {
        httpResponse = [transmission httpGET:finalSearchURL withBody:nil withHeaderParams:nil];
    }
    
    // throw an exception if an error occurred on the response
    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not retrieve jobs" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];    
    
    MMRecentJobSummaryResponseSerialisation *responseSerialisation = [serialisationFactory getMMRecentJobSummaryResponseSerialisation];
    
    MMRecentSummaryJobsResponse *response = [responseSerialisation deserialiseData:httpResponse.responseBody];
    
    NSArray *jobSummaryList = response.jobs;
    
    return jobSummaryList;
}

- (NSArray *) getMessagesForJobWithId:(NSNumber *) jobId withToken:(MMRestAccessToken *) token {
    if (jobId == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Job Id was nil" userInfo:nil];
    if (token == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"User token was nil" userInfo:nil];
    
    NSString *jobDetailUrl = [self.secureDomainUrl stringByAppendingPathComponent:[jobId stringValue]];
    NSString *commsUrl = [jobDetailUrl stringByAppendingPathComponent:@"messages"];
    
    MMRestHttpResponse *response = [authorisedHttpTransmission authorisedMethod:@"GET" toUrl:commsUrl withRequestBody:nil additionalRequestHeaders:nil andAccessToken:token];
    
    [MMErrorUtils throwMMExceptionForResponseOnError:response withReason:@"Could not retrieve messages for job" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
    
    MMMessageDetailListResponseSerialisation *s11n = [serialisationFactory getMMMessageDetailListResponseSerialisation];
    
    MMMessageDetailListResponse *msgResponse = [s11n deserialiseData:response.responseBody];
    
    return msgResponse.messageList;
}

- (NSData *) getRawDataFromUrl:(NSString*)url {
    if (url == nil) return nil;
    
    MMRestHttpResponse *response = [transmission httpGET:url withBody:nil withHeaderParams:nil];
    DLog(@"Response code: %d", response.responseCode);
    if(response.responseCode != 200) {
        DLog(@"Could not find image at url: %@", url);
        return nil;
    }
    DLog(@"Found image at url: %@", url);
    return response.responseBody;
}


@end
