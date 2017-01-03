//
//  MMMessageDetail.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMMessageDetail.h"
#import "MMSerialisationUtils.h"

@implementation MMMessageDetail

@synthesize messageId;
@synthesize jobId;
@synthesize userId;
@synthesize username;
@synthesize parentMessageId;
@synthesize content;

/*
 {
 "success": true,
 "messages": [(2)
 {
 "subMessages": [(2)
 {
 "subMessages": [(0)],
 "rootMessageId": 171,
 "content": "How big is your trunk?",
 "jobId": 154,
 "userId": 46,
 "id": 173
 },
 {
 "subMessages": [(0)],
 "userId": 53,
 "rootMessageId": 171,
 "jobId": 154,
 "content": "Its pretty big",
 "id": 176
 }
 ],
 "userId": 53,
 "jobId": 154,
 "content": "Will this fit in my trunk?",
 "rootMessageId": null,
 "id": 171
 },
 {
 "userId": 55,
 "jobId": 154,
 "content": "Where did you buy this?",
 "subMessages": [(1)
 {
 "subMessages": [(0)],
 "jobId": 154,
 "content": "From greysonline",
 "rootMessageId": 178,
 "userId": 46,
 "id": 180
 }
 ],
 "rootMessageId": null,
 "id": 178
 }
 ]
 }
*/

+ (NSDictionary *) dictionaryFromMessageDetail:(MMMessageDetail *) message {
    if (message == nil) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Message to covert to dictionary was nil" userInfo:nil];
    }
    
    NSMutableDictionary *objDict = [[NSMutableDictionary alloc] init];
    
    [objDict setValue:[MMSerialisationUtils nsNullForNil:message.jobId] forKey:@"jobId"];
    
    //Root message
    if(message.parentMessageId == nil) {
        [objDict setValue:[MMSerialisationUtils nsNullForNil:message.content] forKey:@"newRootMessage"];
    } else {
        [objDict setValue:[MMSerialisationUtils nsNullForNil:message.content] forKey:@"replyMessage"];
        [objDict setValue:[MMSerialisationUtils nsNullForNil:message.parentMessageId] forKey:@"replyRootMessage"];
    }

    return objDict;
    
}

+ (MMMessageDetail *) messageDetailFromDictionary:(NSDictionary *) dictionary {
    if (dictionary == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Dictionary to convert to message was nil" userInfo:nil];
    
    MMMessageDetail *messageDetail = [[MMMessageDetail alloc] init];
    
    messageDetail.content = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"content"]];
    messageDetail.messageId = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"id"]];
    messageDetail.jobId = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"jobId"]];
    messageDetail.parentMessageId = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"rootMessageId"]];
    messageDetail.userId = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"userId"]];
    messageDetail.username = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"username"]];
    
    return messageDetail;
}

@end
