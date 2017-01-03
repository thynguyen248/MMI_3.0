//
//  MMMessageDetail.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMObject.h"
#import "MMSerialisationDateHelper.h"
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

@interface MMMessageDetail : NSObject<MMObject> {
    NSNumber* messageId;
    NSNumber* jobId;
    NSNumber* parentMessageId;
    NSNumber* userId;
    NSString* username;
    NSString* content;
}

@property (strong, nonatomic) NSNumber *messageId;
@property (strong, nonatomic) NSNumber *jobId;
@property (strong, nonatomic) NSNumber *parentMessageId;
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *content;

+ (NSDictionary *) dictionaryFromMessageDetail:(MMMessageDetail *) message;
+ (MMMessageDetail *) messageDetailFromDictionary:(NSDictionary *) dictionary;

@end
