//
//  MMCreateMessageRequestSerialization.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 4/04/13.
//
//

#import "MMCreateMessageRequestSerialization.h"
#import "MMRestSerialisationException.h"
#import "MMCreateMessageRequest.h"
#import "MMMessageDetail.h"
#import "MMSerialisationUtils.h"

@implementation MMCreateMessageRequestSerialization

-(id) init {
    if(self = [super init]) {
        
    }
    
    return self;
}

- (id<MMObject>) deserialiseData:(NSData *)data {
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Not implemented" userInfo:nil];
}

- (NSData *) serialise:(id<MMObject>)object {
    @try {
        if (object == nil) {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Object to serialise was nil" userInfo:nil];
        }

        MMCreateMessageRequest *request = (MMCreateMessageRequest*) object;
            
        // create a dictionary out of the request
        NSDictionary *dict = [MMMessageDetail dictionaryFromMessageDetail:request.message];
            
        return [MMSerialisationUtils serialiseData:dict originalObject:object];
    } @catch (NSException *exception) {
        MMRestSerialisationException *s11nEx = [[MMRestSerialisationException alloc] initWithReason:@"Could not serialise create message request" userInfo:nil nestedException:exception containedError:nil unserialisedObject:nil];
        
        @throw s11nEx;
    }
}


@end
