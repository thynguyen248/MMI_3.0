//
//  MMUserProfileResponseS11nLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 5/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMUserProfileResponseS11nLogicUnitTest.h"
#import "MMUserProfileResponseSerialisation.h"
#import "MMUserProfileResponse.h"
#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"
#import "MMException.h"

@implementation MMUserProfileResponseS11nLogicUnitTest

- (void)setUp
{
    [super setUp];
    dataUtils = [[MMLogicUnitTestSupportingDataUtils alloc] init];
    
    [dataUtils putResponseString:@"{ \"success\":true, \"user\":{ \"transportProvider\":true, \"hasCreditCardDetails\":true, \"hasBankDetails\":true,  \"displayName\":\"Test U\", \"id\":5 } }" forKey:@"UserProfileResponseStringSuccess"];
    
    [dataUtils putResponseString:@"{\"Links\":null,\"HasRegisteredCreditCard:true,\"UserId\":363}" forKey:@"UserProfileResponseBadJSON"];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


// All code under test must be linked into the Unit Test bundle
- (void)testUserProfileResponseDeserialisationSuccess {
    
    NSString *userProfileResponseString = [dataUtils getResponseStringForKey:@"UserProfileResponseStringSuccess"];
    
    NSData *data = [userProfileResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    
    @try {
        MMUserProfileResponseSerialisation *s11n = [factory getMMUserProfileResponseSerialisation];
        
        MMUserProfileResponse *resp = [s11n deserialiseData:data];
        
        MMUserProfile *profile = resp.userProfile;
        
        STAssertNotNil(profile, @"Profile was nil");
        
//        STAssertTrue([profile.hasRegisteredCreditCard boolValue], @"Credit card was not registered");
        
    } @catch (NSException *ex) {
        STFail(@"Should not have thrown an exception: %@", ex);
    }
}

- (void) testUserProfileResponseDeserialisationBadJSON {
    NSString *userProfileResponseString = [dataUtils getResponseStringForKey:@"UserProfileResponseBadJSON"];
    
    NSData *data = [userProfileResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    
    @try {
        MMUserProfileResponseSerialisation *s11n = [factory getMMUserProfileResponseSerialisation];
        
        [s11n deserialiseData:data];
        
    } @catch (NSException *ex) {
        STAssertTrue([ex isKindOfClass:[MMException class]], @"Exception was not correct type");
    }

}

- (void) testUserProfileResponseDeserialisationNilInput {
    
    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    
    @try {
        MMUserProfileResponseSerialisation *s11n = [factory getMMUserProfileResponseSerialisation];
        
        [s11n deserialiseData:nil];
        
    } @catch (NSException *ex) {
        STAssertTrue([ex isKindOfClass:[MMException class]], @"Exception was not correct type");
    }
}


@end
