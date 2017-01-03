//
//  UnitTestHelper.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 14/03/13.
//
//

#import "UnitTestHelper.h"
#import "OCMock.h"

@implementation UnitTestHelper

+(NSDate*) currentDateWithoutTime {
    return [UnitTestHelper dateWithoutTime:[NSDate date]];
}

+(NSDate*) dateWithoutTime:(NSDate*)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit ) fromDate:date];
	[components setHour:0];
 	[components setMinute:0];
  	[components setSecond:0];
    return [[calendar dateFromComponents:components] dateByAddingTimeInterval:[[NSTimeZone localTimeZone]secondsFromGMT]];
}

+(NSDictionary *) extractJSON:(NSData *) jsonData {
    NSError* error = nil;
    
    NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    if(error != nil) {
        @throw [[NSException alloc] initWithName:@"Invalid JSON data"
                                          reason:error.localizedDescription userInfo:nil];
    }
    
    return jsonDict;
}

+(id<GUIRestDeligate>) mockGUIRestDelegate {
    return [OCMockObject mockForProtocol:@protocol(GUIRestDeligate)];
}

+(id<MMRestClient>) mockRestClient {
    return [OCMockObject mockForProtocol:@protocol(MMRestClient)];
}

+(id<MMAsyncActivityDelegate>) mockAsynchActivityDelegate {
    return [OCMockObject mockForProtocol:@protocol(MMAsyncActivityDelegate)];
}

+(id<MMRestAuthorisationClient>) mockRestAuthorisationClient {
    return [OCMockObject mockForProtocol:@protocol(MMRestAuthorisationClient)];
}

+(id<MMRestUserClient>) mockRestUserClient {
    return [OCMockObject mockForProtocol:@protocol(MMRestUserClient)];
}

+(id<MMRestJobsClient>) mockRestJobsClient {
    return [OCMockObject mockForProtocol:@protocol(MMRestJobsClient)];
}

+(id<MMAsyncActivityResult>) mockAsynchActivityResult {
    return [OCMockObject mockForProtocol:@protocol(MMAsyncActivityResult)];
}

+(MMAsyncActivity*) mockAsynchActivity {
    return [OCMockObject mockForClass:[MMAsyncActivity class]];    
}

+(MMRestAccessToken *) mockRestAccessToken {
    return [OCMockObject mockForClass:[MMRestAccessToken class]];
}

+(MMUserProfile*) mockUserProfile {
    return [OCMockObject mockForClass:[MMUserProfile class]];
}

+(id<MMRestHttpTransmission>) mockRestHttpTransmission {
    return [OCMockObject mockForProtocol:@protocol(MMRestHttpTransmission)];
}

+(id<MMRestHttpAuthorisedTransmission>) mockHttpAuthTransmission {
    return [OCMockObject mockForProtocol:@protocol(MMRestHttpAuthorisedTransmission)];
}

+(id<MMSerialisationFactory>) mockSerialisationFactory {
    return [OCMockObject mockForProtocol:@protocol(MMSerialisationFactory)];
}

+(MMRestErrorSerialisation*) mockRestErrorSerialisation {
    return [OCMockObject mockForClass:[MMRestErrorSerialisation class]];    
}

+(MMBidCreationRequestSerialisation*) mockBidCreationRequestSerialisation {
    return [OCMockObject mockForClass:[MMBidCreationRequestSerialisation class]];
}

+(NSData *) mockNSData {
    return [OCMockObject mockForClass:[NSData class]];
}

+(MMRestHttpResponse *) mockHttpResponse {
    return [OCMockObject mockForClass:[MMRestHttpResponse class]];    
}

+(void) addSerialiseExpectations:(id) mockSerialiser input:(id<MMObject>) input result:(NSData *) result {
    [[[mockSerialiser expect] andReturn:result] serialise:input];
}

+(void) addDeserialiseExpectations:(id) mockDeserialiser input:(NSData*) input result:(id<MMObject>) result {
    [[[mockDeserialiser expect] andReturn:result] deserialiseData:input];
}

+(void) addGetRestClientExpectations:(id) mock restClient:(id<MMRestClient>) restClient {
    [[[mock expect] andReturn:restClient] getRestClient];
}

+(void) addGetClientExpectations:(id) mock
                      authClient:(id<MMRestAuthorisationClient>) authClient
                      userClient:(id<MMRestUserClient>) userClient
                      jobsClient:(id<MMRestJobsClient>) jobsClient {
    if(authClient != nil) {
        [[[mock expect] andReturn:authClient] getAuthorisationClient];
    }
    if(userClient != nil) {
        [[[mock expect] andReturn:userClient] getUserClient];
    }
    if(jobsClient != nil) {
        [[[mock expect] andReturn:jobsClient] getJobsClient];
    }
}

+(void) addLoginWithEmailExpectations:(id) mock email:(NSString *)email
                             password:(NSString *)password returnToken:(MMRestAccessToken*) token exception:(NSException *) exception {
    if(exception == nil) {
        [[[mock expect] andReturn:token] loginWithEmail:email andPassword:password];
    } else {
        [[[mock expect] andThrow:exception] loginWithEmail:email andPassword:password];
    }
}

+(void) addGetUserProfileForTokenExpectations:(id) mock token:(MMRestAccessToken*) token returnProfile:(MMUserProfile*) userProfile exception:(NSException *)exception {
    if(exception == nil) {
        [[[mock expect] andReturn:userProfile] getUserProfileForToken:token];
    } else {
        [[[mock expect] andThrow:exception] getUserProfileForToken:token];
    }
}

+(void) addOnAsynchActivityCompletionExpectations:(id) mock result:(id<MMAsyncActivityResult>) result {
    [[mock expect] onAsyncActivityCompletion:result];
}

+(void) addOnAsynchActivityFailureExpectations:(id) mock result:(NSError*) error {
    [[mock expect] onAsyncActivityFailure:error];
}

+(void) addTokenExpectations:(id) mock accessToken:(NSString*) accessToken {
    [[[mock expect] andReturn:accessToken] accessToken];
}

+(void) addGetTokenExpectations:(id) mock accessToken:(MMRestAccessToken*) accessToken {
    [[[mock expect] andReturn:accessToken] getAccessToken];
}

+(void) addCreateJobWithDetailExpectations:(id) jobRestClientMock
                                       job:(MMJobDetail*) job
                               accessToken:(MMRestAccessToken *) accessToken
                                    result:(BOOL) result {
    [[[jobRestClientMock expect] andReturnValue:OCMOCK_VALUE(result)] createJobWithDetail:job andAccessToken:accessToken];
}

+(void) addTPCompleteJobExpectations:(id) jobRestClientMock
                               jobId:(NSNumber*) jobId
                         accessToken:(MMRestAccessToken *) accessToken
                              result:(BOOL) result {
    [[[jobRestClientMock expect] andReturnValue:OCMOCK_VALUE(result)] tpCompleteJob:jobId withToken:accessToken];
}

+(void) addCustomerCompleteJobWithRatingExpectations:(id) jobRestClientMock
                                          userRating:(MMUserRating*) userRating
                                         accessToken:(MMRestAccessToken *) accessToken
                                              result:(BOOL) result {
    [[[jobRestClientMock expect] andReturnValue:OCMOCK_VALUE(result)] customerCompleteJobWithRating:userRating withToken:accessToken];
}

+(void) addGetMMRestErrorSerialisation:(id) serialisationFactoryMock
                                result:(MMRestErrorSerialisation*) result {
    [[[serialisationFactoryMock expect] andReturn:result] getMMRestErrorSerialisation];
}

+(void) addGetMMBidCreationRequestSerialisation:(id) serialisationFactoryMock
                                         result:(MMBidCreationRequestSerialisation*) result {
    [[[serialisationFactoryMock expect] andReturn:result] getMMBidCreationRequestSerialisation];
}

+(void) addAuthorisedMethodExpectations:(id) httpAuthTransmissionMock method:(NSString *)method url:(NSString *) url body:(NSData *) body additionalRequestHeaders:(id)additionalRequestHeaders accessToken:(id)accessToken result:(MMRestHttpResponse*) result {
    [[[httpAuthTransmissionMock expect] andReturn:result] authorisedMethod:method toUrl:url withRequestBody:body additionalRequestHeaders:additionalRequestHeaders andAccessToken:accessToken];
}

+(void) addIsRemoteErrorExpectations:(id) mockHttpResponse result:(BOOL)result {
    [[[mockHttpResponse expect] andReturnValue:OCMOCK_VALUE(result)] isRemoteRestError];
}

+(void) addLocalErrorExpectations:(id) mockHttpResponse result:(NSError*)result {
    [[[mockHttpResponse expect] andReturnValue:OCMOCK_VALUE(result)] localError];
}

+(void) addResponseCodeExpectations:(id) mockHttpResponse result:(NSInteger)result {
    [[[mockHttpResponse expect] andReturnValue:OCMOCK_VALUE(result)] responseCode];
}


@end
