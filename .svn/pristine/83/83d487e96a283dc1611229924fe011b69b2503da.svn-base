//
//  MeeMeepMessageDetailListResponseSerialisationLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MeeMeepCreateMessageRequestS11nLogicUnitTest.h"

#import "MMMessageDetail.h"
#import "MMCreateMessageRequest.h"
#import "MMMessageDetailListResponseSerialisation.h"
#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"
#import "MMRestSerialisationException.h"
#import "UnitTestHelper.h"

@implementation MeeMeepCreateMessageRequestS11nLogicUnitTest

- (void)testSerialiseCreateMessageReplyRequest {
    
    MMMessageDetail *messageDetail = [[MMMessageDetail alloc] init];
    messageDetail.jobId = [NSNumber numberWithInt:156];
    messageDetail.parentMessageId = [NSNumber numberWithInt:353];
    messageDetail.content = @"The message body";
    
    MMCreateMessageRequest *createMessageRequest = [[MMCreateMessageRequest alloc] init];
    createMessageRequest.message = messageDetail;
    
    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    
    MMCreateMessageRequestSerialization *requestSerialisation = [factory getMMCreateMessageRequestSerialization];
    
    NSData *messageRequestData = [requestSerialisation serialise:createMessageRequest];
    
    STAssertNotNil(messageRequestData, @"Serialised message data was nil!");

    NSDictionary* jsonDict = [UnitTestHelper extractJSON:messageRequestData];
    
    STAssertEqualObjects([jsonDict objectForKey:@"jobId"],
                         messageDetail.jobId, @"Job id incorrect");
    STAssertEqualObjects([jsonDict objectForKey:@"replyRootMessage"],
                         messageDetail.parentMessageId, @"Parent message id incorrect");
    STAssertEqualObjects([jsonDict objectForKey:@"replyMessage"],
                         messageDetail.content, @"Content incorrect");
}

- (void)testSerialiseCreateMessageNewRootMessageRequest {
    
    MMMessageDetail *messageDetail = [[MMMessageDetail alloc] init];
    messageDetail.jobId = [NSNumber numberWithInt:156];
    messageDetail.parentMessageId = nil;
    messageDetail.content = @"The message body";
    
    MMCreateMessageRequest *createMessageRequest = [[MMCreateMessageRequest alloc] init];
    createMessageRequest.message = messageDetail;
    
    id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
    
    MMCreateMessageRequestSerialization *requestSerialisation = [factory getMMCreateMessageRequestSerialization];
    
    NSData *messageRequestData = [requestSerialisation serialise:createMessageRequest];
    
    STAssertNotNil(messageRequestData, @"Serialised message data was nil!");
    
    NSDictionary* jsonDict = [UnitTestHelper extractJSON:messageRequestData];
    
    STAssertEqualObjects([jsonDict objectForKey:@"jobId"],
                         messageDetail.jobId, @"Job id incorrect");
    STAssertEqualObjects([jsonDict objectForKey:@"newRootMessage"],
                         messageDetail.content, @"Content incorrect");
}

- (void) testCreateMessageRequestS11nBadInputData {
    @try {
        id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
        
        MMCreateMessageRequestSerialization *requestSerialisation = [factory getMMCreateMessageRequestSerialization];
        
        MMJobAddress *anyType = [[MMJobAddress alloc] init];
        
        [requestSerialisation serialise:anyType];
        STFail(@"Should not have reached this point!");
        
    } @catch (NSException *anyEx) {
        STAssertTrue([anyEx isKindOfClass:[MMRestSerialisationException class]], @"Exception was not expected type");
    }
}

- (void) testCreateMessageRequestS11nNilInputData {
    @try {
        id<MMSerialisationFactory> factory = [[MMSerialisationFactoryImpl alloc] init];
        
        MMCreateMessageRequestSerialization *requestSerialisation = [factory getMMCreateMessageRequestSerialization];
        
        [requestSerialisation serialise:nil];
        STFail(@"Should not have reached this point!");
        
    } @catch (NSException *anyEx) {
        STAssertTrue([anyEx isKindOfClass:[MMRestSerialisationException class]], @"Exception was not expected type");
    }
}
@end
