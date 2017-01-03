//
//  MMMessageGroup.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 14/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "MMMessageGroup.h"


@interface MMMessageGroup (hidden)
+(NSMutableArray*) getValueOrDefaultArray:(NSDictionary*)maps forKey:(NSString*)key;

+(NSString*) getUsernameFromMessageList:(NSArray*)messageList userId:(NSNumber*)userId;

+(NSDictionary*) creatDictGroupFromMessages:(NSArray*)messages;
@end

@implementation MMMessageGroup

@synthesize messages;
@synthesize subject;
@synthesize username;
@synthesize jobId;
@synthesize userId;


-(id) initWithMessages:(NSArray*) messageArray userId:(NSNumber*)aUserId jobId:(NSNumber*)aJobId {
    self = [super init];
    if (self) {
        self.userId = aUserId;
        self.jobId = aJobId;
        self.username = @"User";
        self.subject = nil;
        self.messages = messageArray;
        
        return self;
    } else return nil;
}


-(NSInteger) getMessageCount{
    if (messages != nil) 
        return [messages count];
    else 
        return 0;
}

+(NSMutableArray*) getValueOrDefaultArray:(NSDictionary*)maps forKey:(NSString*)key {
    id value = [maps valueForKey:key];
    if(value != nil) {
        return value;
    } else {
        return [[NSMutableArray alloc] init];
    }
}

+(NSString*) getUsernameFromMessageList:(NSArray*)messageList userId:(NSNumber*)userId {
    for(MMMessageDetail* detail in messageList) {
        if(detail.userId.intValue == userId.intValue) {
            //TODO: Fix up
            return [detail.userId stringValue];
        }
    }
    return nil;
}

+(NSDictionary*) createDictGroupFromMessages:(NSArray*)messages {

    //Root Message ID => List of messages (Root message first)
    NSMutableDictionary* messageGroups = [[NSMutableDictionary alloc] init];
    for(MMMessageDetail* detail in messages) {
        NSMutableArray* messages = nil;
        //Root message
        if(detail.parentMessageId == nil) {
            messages = [[NSMutableArray alloc] init];
            [messageGroups setObject:messages forKey:detail.messageId];
        } else {
            messages = [messageGroups objectForKey:detail.parentMessageId];
        }
        
        [messages addObject:detail];
    }
    return messageGroups;
}

// Array<MessageGroup> => MessageGroup
+(MMMessageGroup*) filterMessageGroups:(NSArray*)messages jobId:(NSNumber*)jobId userId:(NSNumber*)userId {
    for(MMMessageGroup* group in messages) {
        if(group.userId.intValue == userId.intValue && group.jobId.intValue == jobId.intValue) {
            return group;
        }
    }
    return nil;
}

// (Array<MMMessageDetail>,int) => Array<MMMessageGroup>
+(NSArray*) sortMessagesIntoJobUserGroups:(NSArray*)messages myUserId:(NSNumber*)currentUserId {
    // from a generic list of messages, sort into a list of message groups, keyed on job+user
    // will not return an item for the current user
    // will group messages that don't include the currentUserId, if they're public messages (ie returned from the api)

    // an assumption is that you can only see messages that you are allowed to see.
    // this means that you will only see messages either to or from 'you'
    
    NSDictionary* jobAndUserToMessageList = [self createDictGroupFromMessages:messages];
    
    // re flatten into list of message groups
    NSMutableArray* result = [[NSMutableArray alloc] init];

    for (NSString* key in [jobAndUserToMessageList keyEnumerator]) {
        id array = [jobAndUserToMessageList objectForKey:key];

        [result addObjectsFromArray:array];
    }
 
    return [NSArray arrayWithObject:[[MMMessageGroup alloc] initWithMessages:result userId:currentUserId jobId:[NSNumber numberWithInt:1]]] ;
}


@end
