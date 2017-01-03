//
//  MMMockHttpTransmissionGetMatcherLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 4/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMMockHttpTransmissionGetMatcherLogicUnitTest.h"

#import "MMMockHttpTransmissionResponseMatcher.h"
#import "MMMockHttpTransmissionGetMatcherImpl.h"


@implementation MMMockHttpTransmissionGetMatcherLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testGetMatcherResponseMatchingUrlNoHeaders {
    
    MMMockHttpTransmissionGetMatcherImpl *matcher
        = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    NSString *url1 = @"http://abc.com.au";
    NSString *responseString1 = @"Hello ABC!";
    NSData *responseData1 = [responseString1 dataUsingEncoding:NSUTF8StringEncoding];
    MMRestHttpResponse *response1 = [[MMRestHttpResponse alloc] initWithBody:responseData1 responseCode:200 headers:nil params:nil orLocalError:nil];
    
    NSString *url2 = @"http://www.google.com";
    NSString *responseString2 = @"Hello Google";
    NSData *responseData2 = [responseString2 dataUsingEncoding:NSUTF8StringEncoding];
    MMRestHttpResponse *response2 = [[MMRestHttpResponse alloc] initWithBody:responseData2 responseCode:200 headers:nil params:nil orLocalError:nil];

    [matcher addResponse:response1 forUrl:url1 andRequestParams:nil];
    [matcher addResponse:response2 forUrl:url2 andRequestParams:nil];
    
    MMRestHttpResponse *retrievedResponse1 = [matcher responseMatchingUrl:url1 andParams:nil];
    
    STAssertNotNil(retrievedResponse1, @"Retrieved response for %@ was nil", url1);
    
    NSString *retrieveResponseString1 = [[NSString alloc] initWithData:retrievedResponse1.responseBody encoding:NSUTF8StringEncoding];

    STAssertTrue([retrieveResponseString1 isEqualToString:responseString1], @"Retrieved response %@ was not same as expected %@", retrieveResponseString1, responseString1);
    
    MMRestHttpResponse *retrievedResponse2 = [matcher responseMatchingUrl:url2 andParams:nil];
    
    STAssertNotNil(retrievedResponse2, @"Retrieved response for %@ was nil", url2);
    
    NSString *retrieveResponseString2 = [[NSString alloc] initWithData:retrievedResponse2.responseBody encoding:NSUTF8StringEncoding];
    
    STAssertTrue([retrieveResponseString2 isEqualToString:responseString2], @"Retrieved response %@ was not same as expected %@", retrieveResponseString2, responseString2);

}

- (void) testGetMatcherResponseMatchingUrlWithHeadersNotConfigured {
    MMMockHttpTransmissionGetMatcherImpl *matcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    NSString *url1 = @"http://abc.com.au";
    NSString *responseString1 = @"Hello ABC!";
    NSData *responseData1 = [responseString1 dataUsingEncoding:NSUTF8StringEncoding];
    
    MMRestHttpResponse *response1 = [[MMRestHttpResponse alloc] initWithBody:responseData1 responseCode:200 headers:nil params:nil orLocalError:nil];
    
    NSMutableDictionary *headerDictionary1 
    = [[NSMutableDictionary alloc] init];
    [headerDictionary1 setValue:@"A" forKey:@"key1"];
    [headerDictionary1 setValue:@"B" forKey:@"key2"];
    
    NSString *url2 = @"http://www.google.com";
    NSString *responseString2 = @"Hello Google";
    NSData *responseData2 = [responseString2 dataUsingEncoding:NSUTF8StringEncoding];
    
    MMRestHttpResponse *response2 = [[MMRestHttpResponse alloc] initWithBody:responseData2 responseCode:200 headers:nil params:nil orLocalError:nil];
    
    [matcher addResponse:response1 forUrl:url1 andRequestParams:nil];
    
    [matcher addResponse:response2 forUrl:url2 andRequestParams:nil];
    
    MMRestHttpResponse *retrievedResponse1 = [matcher responseMatchingUrl:url1 andParams:headerDictionary1];
    
    STAssertNotNil(retrievedResponse1, @"Retrieved response was not found for %@", url1);
    
    NSString *retrieveResponseString1 = [[NSString alloc] initWithData:retrievedResponse1.responseBody encoding:NSUTF8StringEncoding];
    
    STAssertTrue([retrieveResponseString1 isEqualToString:responseString1], @"Retrieved response %@ was not same as expected %@", retrieveResponseString1, responseString1);
}

- (void) testGetMatcherResponseMatchingUrlWithHeadersContained {
    MMMockHttpTransmissionGetMatcherImpl *matcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    NSString *url1 = @"http://abc.com.au";
    NSString *responseString1 = @"Hello ABC!";
    NSData *responseData1 = [responseString1 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *headerDictionary1 
    = [[NSMutableDictionary alloc] init];
    [headerDictionary1 setValue:@"A" forKey:@"key1"];
    [headerDictionary1 setValue:@"B" forKey:@"key2"];
    
    MMRestHttpResponse *response1 = [[MMRestHttpResponse alloc] initWithBody:responseData1 responseCode:200 headers:nil params:nil orLocalError:nil];
    
    NSDictionary *headerCopyDictionary = [[NSDictionary alloc] initWithDictionary:headerDictionary1 copyItems:YES];
    
    NSString *url2 = @"http://www.google.com";
    NSString *responseString2 = @"Hello Google";
    NSData *responseData2 = [responseString2 dataUsingEncoding:NSUTF8StringEncoding];
    
    MMRestHttpResponse *response2 = [[MMRestHttpResponse alloc] initWithBody:responseData2 responseCode:200 headers:nil params:nil orLocalError:nil];
    
    [matcher addResponse:response1 forUrl:url1 andRequestParams:headerCopyDictionary];
    
    [matcher addResponse:response2 forUrl:url2 andRequestParams:nil];
    
    MMRestHttpResponse *retrievedResponse1 = [matcher responseMatchingUrl:url1 andParams:headerDictionary1];
    
    STAssertNotNil(retrievedResponse1, @"Retrieved response was not found for %@", url1);
    
    NSString *retrieveResponseString1 = [[NSString alloc] initWithData:retrievedResponse1.responseBody encoding:NSUTF8StringEncoding];
    
    STAssertTrue([retrieveResponseString1 isEqualToString:responseString1], @"Retrieved response %@ was not same as expected %@", retrieveResponseString1, responseString1);
}

- (void) testGetMatcherResponseMatchingUrlWithHeadersNotContained {
    MMMockHttpTransmissionGetMatcherImpl *matcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    NSString *url1 = @"http://abc.com.au";
    NSString *responseString1 = @"Hello ABC!";
    NSData *responseData1 = [responseString1 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *headerDictionary1 
    = [[NSMutableDictionary alloc] init];
    [headerDictionary1 setValue:@"A" forKey:@"key1"];
    [headerDictionary1 setValue:@"B" forKey:@"key2"];
    
    MMRestHttpResponse *response1 = [[MMRestHttpResponse alloc] initWithBody:responseData1 responseCode:200 headers:nil params:nil orLocalError:nil];
    
    NSMutableDictionary *headerCopyDictionary = [[NSMutableDictionary alloc] initWithDictionary:headerDictionary1 copyItems:YES];
    [headerCopyDictionary setValue:@"C" forKey:@"key3"];
    
    // at this point the are more configured headers than there are requested.
    // the matcher should fail to find the url response, because there
    // would be a key in the configured headers which could not be matched
    // to any in the requested headers
    
    NSString *url2 = @"http://www.google.com";
    NSString *responseString2 = @"Hello Google";
    NSData *responseData2 = [responseString2 dataUsingEncoding:NSUTF8StringEncoding];
    
    MMRestHttpResponse *response2 = [[MMRestHttpResponse alloc] initWithBody:responseData2 responseCode:200 headers:nil params:nil orLocalError:nil];
    
    [matcher addResponse:response1 forUrl:url1 andRequestParams:headerCopyDictionary];
    
    [matcher addResponse:response2 forUrl:url2 andRequestParams:nil];
    
    MMRestHttpResponse *retrievedResponse1 = [matcher responseMatchingUrl:url1 andParams:headerDictionary1];
    
    STAssertNil(retrievedResponse1.responseBody, @"Retrieved response was found for %@", url1);
    
}

- (void) testPopulatingHeadersAndParamsInMatchingResponse {
    MMMockHttpTransmissionGetMatcherImpl *matcher
    = [[MMMockHttpTransmissionGetMatcherImpl alloc] init];
    
    NSString *url1 = @"http://abc.com.au";
    NSString *responseString1 = @"Hello ABC!";
    NSData *responseData1 = [responseString1 dataUsingEncoding:NSUTF8StringEncoding];
    
    MMRestHttpResponse *response1 = [[MMRestHttpResponse alloc] initWithBody:responseData1 responseCode:200 headers:nil params:nil orLocalError:nil];
    
    NSString *url2 = @"http://www.google.com";
    NSString *responseString2 = @"Hello Google";
    NSData *responseData2 = [responseString2 dataUsingEncoding:NSUTF8StringEncoding];
    
    MMRestHttpResponse *response2 = [[MMRestHttpResponse alloc] initWithBody:responseData2 responseCode:200 headers:nil params:nil orLocalError:nil];
    
    NSMutableDictionary *response1Headers = [[NSMutableDictionary alloc] init];
    [response1Headers setValue:@"Value1" forKey:@"Key1"];
    [response1Headers setValue:@"Value2" forKey:@"Key2"];
    [response1Headers setValue:@"Value3" forKey:@"Key3"];
    
    response1.responseHeaders = response1Headers;
    
    [matcher addResponse:response1 forUrl:url1 andRequestParams:nil];
    [matcher addResponse:response2 forUrl:url2 andRequestParams:nil];
    
    MMRestHttpResponse *retrievedResponse1 = [matcher responseMatchingUrl:url1 andParams:nil];
    
    STAssertNotNil(retrievedResponse1, @"Retrieved response for %@ was nil", url1);
    
    // now check that the receive headers are the same as the response headers
    NSDictionary *response1ReceivedHeaders = retrievedResponse1.responseHeaders;

    STAssertNotNil(response1ReceivedHeaders, @"Received headers was nil");
    
    STAssertTrue([response1ReceivedHeaders count], @"Received headers not at expected count!");
    
    STAssertTrue([[response1ReceivedHeaders objectForKey:@"Key1"] isEqualToString:@"Value1"], @"Received headers did not match");
    
}

@end
