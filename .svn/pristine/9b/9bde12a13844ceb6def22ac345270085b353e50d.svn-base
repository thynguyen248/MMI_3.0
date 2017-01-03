//
//  MMRestClientDefaultImpl.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestClientImpl.h"
#import "MMRestClient.h"
#import "MMRestJobsClient.h"
#import "MMRestJobsClientImpl.h"
#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"
#import "MMInitialResponse.h"
#import "MMRestHttpResponse.h"
#import "MMRestMessageClient.h"
#import "MMRestMessageClientImpl.h"
#import "MMRestBidClient.h"
#import "MMRestBidClientImpl.h"
#import "MMRestAuthorisationClient.h"
#import "MMRestAuthorisationClientImpl.h"
#import "MMRestUserClient.h"
#import "MMRestUserClientImpl.h"
#import "MMRestConfigClient.h"
#import "MMRestConfigClientImpl.h"

#import "MMErrorUtils.h"

static NSString* const MMUserPublicDomain = @"meemeep-user-public";
static NSString* const MMUserSecureDomain = @"meemeep-user-secure";

static NSString* const MMAuthenticationLoginDomain = @"meemeep-authentication-login";
static NSString* const MMAuthenticationLogoutDomain = @"meemeep-authentication-logout";

static NSString* const MMBidPublicDomain = @"meemeep-bid-public";
static NSString* const MMBidSecureDomain = @"meemeep-bid-secure";

static NSString* const MMJobPublicDomain = @"meemeep-job-public";
static NSString* const MMJobSecureDomain = @"meemeep-job-secure";

static NSString* const MMMessageSecureDomain = @"meemeep-message-secure";

static NSString* const MMConfigurationDomain = @"meemeep-configuration";

@implementation MMRestClientImpl

@synthesize httpTransmission, serialisationFactory, baseUrl, domainUrlMapping;

- (id) initWithTransmission:(id<MMRestHttpTransmission>) transmission 
                s11nFactory:(id<MMSerialisationFactory>) factory 
                 andBaseUrl:(NSString *) url {
    
    self = [super init];
    
    if (self) {
        self.httpTransmission = transmission;
        self.serialisationFactory = factory;
        self.baseUrl = url;
        self.domainUrlMapping = [[NSMutableDictionary alloc] init];
        return self;
    }
    
    return nil;
}

- (void) initialise {
    
    NSMutableDictionary *responseLinksDictionary = [[NSMutableDictionary alloc] init];
    
    [responseLinksDictionary setValue:@"public/api/v3/user" forKey:MMUserPublicDomain];
    [responseLinksDictionary setValue:@"secure/api/v3/user" forKey:MMUserSecureDomain];
    
    [responseLinksDictionary setValue:@"j_spring_security_check" forKey:MMAuthenticationLoginDomain];
    [responseLinksDictionary setValue:@"public/logout/ajaxLogout" forKey:MMAuthenticationLogoutDomain];

    [responseLinksDictionary setValue:@"public/api/v3/bid" forKey:MMBidPublicDomain];
    [responseLinksDictionary setValue:@"secure/api/v3/bid" forKey:MMBidSecureDomain];
    
    [responseLinksDictionary setValue:@"public/api/v3/job" forKey:MMJobPublicDomain];
    [responseLinksDictionary setValue:@"secure/api/v3/job" forKey:MMJobSecureDomain];

    [responseLinksDictionary setValue:@"secure/api/v3/message" forKey:MMMessageSecureDomain];    
    
    [responseLinksDictionary setValue:@"public/api/v3/home/getConfig" forKey:MMConfigurationDomain];    
    
    
    [self.domainUrlMapping removeAllObjects];
    [self.domainUrlMapping addEntriesFromDictionary:responseLinksDictionary];
    
    initialised = YES;
    
    // TODO: When the API exposes the initial response, uncomment and adjust the following
//    MMRestHttpResponse *httpResponse = [httpTransmission httpGET:self.baseUrl withBody:nil withHeaderParams:nil];
//    
//    [MMErrorUtils throwMMExceptionForResponseOnError:httpResponse withReason:@"Could not initialise MeeMeep API" deserialisedWith:[serialisationFactory getMMRestErrorSerialisation]];
//    
//    if (httpResponse != nil) {
//    
//        MMInitialResponse *initialResponse 
//            = [[serialisationFactory getMMInitialResponseSerialisation] deserialiseData:httpResponse.responseBody];
//
//        [self.domainUrlMapping removeAllObjects];
//        
//        [self.domainUrlMapping addEntriesFromDictionary:initialResponse.domainLinks];
//        
//        if (initialResponse != nil)
//            initialised = YES;
//    } else {
//        initialised = NO;
//    }
}

- (id<MMRestUserClient>) getUserClient {
    if (!initialised) {
        [self initialise];
    }
    
//    for (NSString *domainKey in self.domainUrlMapping) {
//        DLog(@"Domain [%@], relpath [%@]", domainKey, [self.domainUrlMapping objectForKey:domainKey]);
//    }
    
    MMRestUserClientImpl *userClient = [[MMRestUserClientImpl alloc] initWithTransmission:self.httpTransmission s11nFactory:self.serialisationFactory baseUrl:self.baseUrl publicRelativePath:[domainUrlMapping objectForKey:MMUserPublicDomain] andSecureRelativePath:[domainUrlMapping objectForKey:MMUserSecureDomain]];
    
    return userClient;
}

- (id<MMRestAuthorisationClient>) getAuthorisationClient {
    if (!initialised) {
        [self initialise];
    }
    
//    for (NSString *domainKey in self.domainUrlMapping) {
//        DLog(@"Domain [%@], relpath [%@]", domainKey, [self.domainUrlMapping objectForKey:domainKey]);
//    }
    
    MMRestAuthorisationClientImpl *authClient
    = [[MMRestAuthorisationClientImpl alloc] initWithTransmission:self.httpTransmission s11nFactory:self.serialisationFactory withBaseUrl:self.baseUrl relativeLoginPath:[domainUrlMapping objectForKey:MMAuthenticationLoginDomain] andRelativeLogoutPath:[domainUrlMapping objectForKey:MMAuthenticationLogoutDomain]];
    return authClient;
}
    

- (id<MMRestBidClient>) getBidClient {
    if (!initialised) {
        [self initialise];
    }
    
//    for (NSString *domainKey in self.domainUrlMapping) {
//        DLog(@"Domain [%@], relpath [%@]", domainKey, [self.domainUrlMapping objectForKey:domainKey]);
//    }

    MMRestBidClientImpl *bidClient
    = [[MMRestBidClientImpl alloc] initWithTransmission:self.httpTransmission s11nFactory:self.serialisationFactory baseUrl:self.baseUrl andPublicRelativePath:[domainUrlMapping objectForKey:MMBidPublicDomain] andSecureRelativePath:[domainUrlMapping objectForKey:MMBidSecureDomain]];
    
    return bidClient;
    
}

- (id<MMRestJobsClient>) getJobsClient {
    
    if (!initialised) {
        [self initialise];
    }
    
//    for (NSString *domainKey in self.domainUrlMapping) {
//        DLog(@"Domain [%@], relpath [%@]", domainKey, [self.domainUrlMapping objectForKey:domainKey]);
//    }
    
    MMRestJobsClientImpl *jobsClient = [[MMRestJobsClientImpl alloc] 
                                        initWithTransmission:self.httpTransmission s11nFactory:self.serialisationFactory baseUrl:self.baseUrl andPublicRelativePath:[self.domainUrlMapping objectForKey:MMJobPublicDomain] andSecureRelativePath:[self.domainUrlMapping objectForKey:MMJobSecureDomain]];
    
    return jobsClient;
}

- (id<MMRestMessageClient>) getMessageClient {
    
    if (!initialised) {
        [self initialise];
    }
    
    return[[MMRestMessageClientImpl alloc]
                                        initWithTransmission:self.httpTransmission s11nFactory:self.serialisationFactory baseUrl:self.baseUrl andPublicRelativePath:nil andSecureRelativePath:[self.domainUrlMapping objectForKey:MMMessageSecureDomain]];
}

- (id<MMRestConfigClient>) getConfigClient {
    if(!initialised) {
        [self initialise];
    }
    
    return [[MMRestConfigClientImpl alloc] initWithTransmission:self.httpTransmission s11nFactory:self.serialisationFactory baseUrl:self.baseUrl andRelativePath:[self.domainUrlMapping objectForKey:MMConfigurationDomain]];
}

-(NSString*) getBaseUrl
{
    return baseUrl;
}

@end
