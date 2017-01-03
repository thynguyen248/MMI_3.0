//
//  MMMessageDetailListResponseSerialisationLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 13/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMMessageDetailListResponseSerialisationLogicUnitTest.h"
#import "MMMessageDetailListResponse.h"
#import "MMMessageDetailListResponseSerialisation.h"
#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"
#import "MMMessageDetail.h"


@implementation MMMessageDetailListResponseSerialisationLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testDeserialiseListResponseSuccess {
    @try {
        NSString *commsListString = @"{\"success\": true, \"messages\": [ { \"subMessages\": [ {\"subMessages\": [], \"rootMessageId\": 171, \"content\": \"How big is your trunk?\", \"jobId\": 154, \"userId\": 46, \"id\": 173 } ],\"userId\": 53, \"jobId\": 154, \"content\": \"Will this fit in my trunk?\", \"rootMessageId\": null, \"id\": 171}, {\"userId\": 55, \"jobId\": 154, \"content\": \"Where did you buy this?\",\"subMessages\": [], \"rootMessageId\": null, \"id\": 178 } ] }";
    
        NSData *commsListResponseData = [commsListString dataUsingEncoding:NSUTF8StringEncoding];
    
        id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
        MMMessageDetailListResponseSerialisation *s11n = [factory getMMMessageDetailListResponseSerialisation];
    
        MMMessageDetailListResponse *response = [s11n deserialiseData:commsListResponseData];
    
        //There should be 5 messages
        STAssertTrue([response.messageList count] == 3, @"Incorrect number of messages");
        
        MMMessageDetail *firstMessage = [response.messageList objectAtIndex:0];
        STAssertNotNil(firstMessage, @"First message was nil");
        STAssertEqualObjects(firstMessage.content, @"Will this fit in my trunk?",
                    @"Content incorrect for first message");
        STAssertNil(firstMessage.parentMessageId, @"Parent message ID for first message should be nil");
        MMMessageDetail *secondMessage = [response.messageList objectAtIndex:1];
        STAssertNotNil(secondMessage, @"Second message was nil");
        STAssertEqualObjects(secondMessage.content, @"How big is your trunk?",
                             @"Content incorrect for second message");
        STAssertEqualObjects(secondMessage.parentMessageId, firstMessage.messageId, @"Parent message ID for second message should match first message");
        
        MMMessageDetail *thirdMessage = [response.messageList objectAtIndex:2];
        STAssertNotNil(thirdMessage, @"Third message was nil");
        STAssertEqualObjects(thirdMessage.content, @"Where did you buy this?",
                             @"Content incorrect for third message");
        STAssertNil(thirdMessage.parentMessageId, @"Parent message ID for third message should be nil");
    } @catch (NSException* ex) {
        STFail(@"Unexpected exception");
    }
}

- (void) testDeserialiseListResponseNilData {

    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    MMMessageDetailListResponseSerialisation *s11n = [factory getMMMessageDetailListResponseSerialisation];

    @try {
        [s11n deserialiseData:nil];
        STFail(@"Should never have reached this point");
    } @catch (NSException *anyEx) {
        STAssertNotNil(anyEx, @"Exception was nil");
    }

}

- (void) testDeserialiseListResponseBadData {
    
    NSString *commsListString = @"Something bogus";
    
    NSData *commsListResponseData = [commsListString dataUsingEncoding:NSUTF8StringEncoding];
    
    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    MMMessageDetailListResponseSerialisation *s11n = [factory getMMMessageDetailListResponseSerialisation];
    
    @try {
        [s11n deserialiseData:commsListResponseData];
        STFail(@"Should never have reached this point");
    } @catch (NSException *anyEx) {
        STAssertNotNil(anyEx, @"Exception was nil");
    }
}

@end
