//
//  UnitTestHelper.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 14/03/13.
//
//

#import <Foundation/Foundation.h>
#import "GUIRestDeligate.h"
#import "MMAsyncActivityDelegate.h"
#import "MMRestClient.h"
#import "MMRestAuthorisationClient.h"
#import "MMRestAccessToken.h"
#import "MMUserProfile.h"
#import "MMAsyncActivity.h"
#import "MMAsyncActivityResult.h"
#import "MMRestJobsClient.h"
#import "MMRestHttpTransmission.h"
#import "MMSerialisationFactory.h"
#import "MMBidCreationRequestSerialisation.h"
#import "MMRestHttpResponse.h"
#import "MMRestHttpAuthorisedTransmission.h"
#import "MMRestErrorSerialisation.h"

@interface UnitTestHelper : NSObject

+(NSDate*) currentDateWithoutTime;
+(NSDate*) dateWithoutTime:(NSDate*)date;

+(NSDictionary *) extractJSON:(NSData *) jsonData;

+(id<GUIRestDeligate>) mockGUIRestDelegate;
+(id<MMAsyncActivityDelegate>) mockAsynchActivityDelegate;
+(id<MMRestClient>) mockRestClient;
+(id<MMRestAuthorisationClient>) mockRestAuthorisationClient;
+(id<MMRestUserClient>) mockRestUserClient;
+(id<MMRestJobsClient>) mockRestJobsClient;
+(id<MMAsyncActivityResult>) mockAsynchActivityResult;
+(id<MMRestHttpTransmission>) mockRestHttpTransmission;
+(id<MMRestHttpAuthorisedTransmission>) mockHttpAuthTransmission;
+(id<MMSerialisationFactory>) mockSerialisationFactory;
+(MMRestErrorSerialisation*) mockRestErrorSerialisation;
+(MMBidCreationRequestSerialisation*) mockBidCreationRequestSerialisation;
+(MMAsyncActivity*) mockAsynchActivity;
+(MMRestAccessToken *) mockRestAccessToken;
+(MMUserProfile*) mockUserProfile;
+(NSData *) mockNSData;
+(MMRestHttpResponse *) mockHttpResponse;

+(void) addSerialiseExpectations:(id) mockSerialiser input:(id<MMObject>) input result:(NSData *) result;
+(void) addDeserialiseExpectations:(id) mockDeserialiser input:(NSData*) input result:(id<MMObject>) result;

+(void) addGetRestClientExpectations:(id) mock restClient:(id<MMRestClient>) restClient;

+(void) addGetClientExpectations:(id) mock
                      authClient:(id<MMRestAuthorisationClient>) authClient
                      userClient:(id<MMRestUserClient>) userClient
                      jobsClient:(id<MMRestJobsClient>) jobsClient;

+(void) addLoginWithEmailExpectations:(id) mock email:(NSString *)email
                             password:(NSString *)password returnToken:(MMRestAccessToken*) token exception:(NSException *) exception;

+(void) addGetUserProfileForTokenExpectations:(id) mock token:(MMRestAccessToken*) token returnProfile:(MMUserProfile*) userProfile exception:(NSException *)exception;
+(void) addOnAsynchActivityCompletionExpectations:(id) mock result:(id<MMAsyncActivityResult>) result;
+(void) addOnAsynchActivityFailureExpectations:(id) mock result:(NSError*) error;
+(void) addTokenExpectations:(id) mock accessToken:(NSString*) accessToken;
+(void) addGetTokenExpectations:(id) mock accessToken:(MMRestAccessToken*) accessToken;

+(void) addCreateJobWithDetailExpectations:(id) jobRestClientMock
                                       job:(MMJobDetail*) job
                               accessToken:(MMRestAccessToken *) accessToken
                                    result:(BOOL) result;
+(void) addTPCompleteJobExpectations:(id) jobRestClientMock
                                 jobId:(NSNumber*) jobId
                         accessToken:(MMRestAccessToken *) accessToken
                                    result:(BOOL) result;
+(void) addCustomerCompleteJobWithRatingExpectations:(id) jobRestClientMock
                                          userRating:(MMUserRating*) userRating
                                         accessToken:(MMRestAccessToken *) accessToken
                                              result:(BOOL) result;

+(void) addGetMMRestErrorSerialisation:(id) serialisationFactoryMock
                                result:(MMRestErrorSerialisation*) result;
+(void) addGetMMBidCreationRequestSerialisation:(id) serialisationFactoryMock
                                         result:(MMBidCreationRequestSerialisation*) result;

+(void) addAuthorisedMethodExpectations:(id) httpTransmissionMock method:(NSString *)method url:(NSString *) url body:(NSData *) body additionalRequestHeaders:(id)additionalRequestHeaders accessToken:(id)accessToken result:(MMRestHttpResponse*) result;

+(void) addIsRemoteErrorExpectations:(id) mockHttpResponse result:(BOOL)result;
+(void) addLocalErrorExpectations:(id) mockHttpResponse result:(NSError*)result;
+(void) addResponseCodeExpectations:(id) mockHttpResponse result:(NSInteger)result;

@end
