//
//  MMMessageGroup.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 14/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMMessageDetail.h"

@interface MMMessageGroup : NSObject{
    NSArray* messages;
    NSString* username;
    NSString* subject;
    NSNumber* userId;
    NSNumber* jobId;
}

@property (nonatomic,strong) NSArray* messages;

@property (nonatomic,strong) NSString* username;

@property (nonatomic,strong) NSString* subject;

@property (nonatomic,strong) NSNumber* userId;

@property (nonatomic,strong) NSNumber* jobId;

-(NSInteger) getMessageCount;

// (Array<MMMessageDetail>,int) => Array<MMMessageGroup>
+(NSArray*) sortMessagesIntoJobUserGroups:(NSArray*)messages myUserId:(NSNumber*)currentUserId;

// Array<MessageGroup> => MessageGroup
+(MMMessageGroup*) filterMessageGroups:(NSArray*)messages jobId:(NSNumber*)jobId userId:(NSNumber*)userId;


@end
