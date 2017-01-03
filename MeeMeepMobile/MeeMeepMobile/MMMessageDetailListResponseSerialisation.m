//
//  MMMessageDetailListResponseSerialisation.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMMessageDetailListResponseSerialisation.h"
#import "MMRestDeserialisationException.h"
#import "MMMessageDetail.h"
#import "MMMessageDetailListResponse.h"
#import "MMRestSerialisationException.h"
#import "MMCreateMessageRequest.h"
#import "MMSerialisationUtils.h"

@implementation MMMessageDetailListResponseSerialisation

@synthesize s11nDateHelper;

- (id) initWithDateHelper:(id<MMSerialisationDateHelper>) dateHelper {
    self = [super init];
    if (self) {
        self.s11nDateHelper = dateHelper;
        return self;
    }
    
    return nil;
}

- (id<MMObject>) deserialiseData:(NSData *)data {
    @try {
        NSDictionary *result = [MMSerialisationUtils deserialiseData:data];
        NSArray* data = [result objectForKey:@"messages"];
        
        NSMutableArray *receivedMessageList = [[NSMutableArray alloc] init];
        
        for (NSDictionary *msgDict in data) {
            MMMessageDetail *msgDetail = [MMMessageDetail messageDetailFromDictionary:msgDict];

            [receivedMessageList addObject:msgDetail];
            
            //Root area
            if(msgDetail.parentMessageId == nil) {
                NSArray* subMessages = [msgDict objectForKey:@"subMessages"];
                
                for(NSDictionary* subDict in subMessages) {
                    msgDetail = [MMMessageDetail messageDetailFromDictionary:subDict];
                
                    [receivedMessageList addObject:msgDetail];
                }
            }
        }
        
        MMMessageDetailListResponse *response = [[MMMessageDetailListResponse alloc] init];
        response.messageList = receivedMessageList;
        
        return response;
    } @catch (NSException *ex) {
        MMRestDeserialisationException *ds11nEx = [[MMRestDeserialisationException alloc] initWithReason:@"Could not deserialise job detail response data" userInfo:nil nestedException:ex containedError:nil serialisedData:nil];
        
        @throw ds11nEx;
    }
    
    
}

- (NSData *) serialise:(id<MMObject>)object {
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Not implemented" userInfo:nil];
}

@end
