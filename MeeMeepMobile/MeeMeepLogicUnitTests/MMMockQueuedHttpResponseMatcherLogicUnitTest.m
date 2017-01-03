//
//  MMMockQueuedHttpResponseMatcherLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMMockQueuedHttpResponseMatcherLogicUnitTest.h"
#import "MMMockQueuedHttpResponseMatcher.h"
#import "MMRestHttpResponse.h"

@implementation MMMockQueuedHttpResponseMatcherLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testAddResponsesSingleUrl {
    MMMockQueuedHttpResponseMatcher *responseMatcher = [[MMMockQueuedHttpResponseMatcher alloc] init];
    
    NSString *url1 = @"url1";
    
    NSString *response1ForUrl1String = @"Hello1";
    NSData *response1ForUrl1Data = [response1ForUrl1String dataUsingEncoding:NSUTF8StringEncoding];
    MMRestHttpResponse *response1ForUrl1 = [[MMRestHttpResponse alloc] initWithBody:response1ForUrl1Data responseCode:200 headers:nil params:nil orLocalError:nil];
    
    [responseMatcher addResponse:response1ForUrl1 forUrl:url1];
    
    NSString *response2ForUrl1String = @"Hello2";
    NSData *response2ForUrl1Data = [response2ForUrl1String dataUsingEncoding:NSUTF8StringEncoding];
    MMRestHttpResponse *response2ForUrl1 = [[MMRestHttpResponse alloc] initWithBody:response2ForUrl1Data responseCode:200 headers:nil params:nil orLocalError:nil];
    
    [responseMatcher addResponse:response2ForUrl1 forUrl:url1];
    
    // as a first in first out per url, the first match against url1 should provide hello1
    
    MMRestHttpResponse *response1 = [responseMatcher responseMatchingUrl:url1 andParams:nil];
    NSString *response1String = [[NSString alloc] initWithData:response1.responseBody encoding:NSUTF8StringEncoding];
    STAssertTrue([response1String isEqualToString:response1ForUrl1String], @"First responses was not correct");
    
    MMRestHttpResponse *response2 = [responseMatcher responseMatchingUrl:url1 andParams:nil];
    NSString *response2String = [[NSString alloc] initWithData:response2.responseBody encoding:NSUTF8StringEncoding];
    STAssertTrue([response2String isEqualToString:response2ForUrl1String], @"Second response as not correct");
}

- (void) testAddResponsesTwoUrls {
    MMMockQueuedHttpResponseMatcher *responseMatcher = [[MMMockQueuedHttpResponseMatcher alloc] init];
    
    NSString *url1 = @"url1";
    
    NSString *response1ForUrl1String = @"Hello1";
    NSData *response1ForUrl1Data = [response1ForUrl1String dataUsingEncoding:NSUTF8StringEncoding];
    MMRestHttpResponse *response1ForUrl1 = [[MMRestHttpResponse alloc] initWithBody:response1ForUrl1Data responseCode:200 headers:nil params:nil orLocalError:nil];
    
    [responseMatcher addResponse:response1ForUrl1 forUrl:url1];
    
    NSString *url2 = @"url2";
    
    NSString *response1ForUrl2String = @"Hello2";
    NSData *response1ForUrl2Data = [response1ForUrl2String dataUsingEncoding:NSUTF8StringEncoding];
    MMRestHttpResponse *response1ForUrl2 = [[MMRestHttpResponse alloc] initWithBody:response1ForUrl2Data responseCode:200 headers:nil params:nil orLocalError:nil];
    
    [responseMatcher addResponse:response1ForUrl2 forUrl:url2];
    
    // as a first in first out per url, the first match against url1 should provide hello1
    
    MMRestHttpResponse *response1 = [responseMatcher responseMatchingUrl:url1 andParams:nil];
    NSString *response1String = [[NSString alloc] initWithData:response1.responseBody encoding:NSUTF8StringEncoding];
    STAssertTrue([response1String isEqualToString:response1ForUrl1String], @"First responses was not correct");
    
    MMRestHttpResponse *response2 = [responseMatcher responseMatchingUrl:url2 andParams:nil];
    NSString *response2String = [[NSString alloc] initWithData:response2.responseBody encoding:NSUTF8StringEncoding];
    STAssertTrue([response2String isEqualToString:response1ForUrl2String], @"Second response as not correct");
}

- (void) testNoResponsesForURL {
    MMMockQueuedHttpResponseMatcher *responseMatcher = [[MMMockQueuedHttpResponseMatcher alloc] init];

    @try {
        [responseMatcher responseMatchingUrl:@"anyurl" andParams:nil];
        STFail(@"Should not have got to this point!");
    } @catch (NSException *anyEx) {
        STAssertNotNil(anyEx, @"Exception was nil");
    }
}

@end
