//
//  MMInitialResponseSerialisation.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMInitialResponseSerialisation.h"
#import "MMInitialResponse.h"
#import "MMSerialisationUtils.h"
#import "MMRestDeserialisationException.h"
#import "MMRestNotImplementedException.h"

@implementation MMInitialResponseSerialisation

- (id<MMObject>) deserialiseData:(NSData*) data {
    
    @try {
        NSDictionary *rootResponseDictionary = [MMSerialisationUtils deserialiseData:data];
        
        NSArray *linksList = [MMSerialisationUtils nilIfNSNull:[rootResponseDictionary objectForKey:@"Links"]];
        
        MMInitialResponse *response = [[MMInitialResponse alloc] init];
        
        NSMutableDictionary *responseLinksDictionary = [[NSMutableDictionary alloc] init];
        
        for (NSDictionary *linkDict in linksList) {
            NSString *relPath   = [MMSerialisationUtils nilIfNSNull:[linkDict objectForKey:@"Href"]];
            NSString *domain    = [MMSerialisationUtils nilIfNSNull:[linkDict objectForKey:@"Rel"]];
            
            [responseLinksDictionary setValue:relPath forKey:domain];
        }
        
        response.domainLinks = responseLinksDictionary;
        
        return response;
        
    } @catch (NSException *ex) {
        MMRestDeserialisationException *s11nEx = [[MMRestDeserialisationException alloc] initWithReason:@"Serialisation Failed" userInfo:nil nestedException:ex containedError:nil serialisedData:nil];
        
        @throw s11nEx;
    }
}

- (NSData*) serialise:(id <MMObject>) object {
    MMRestNotImplementedException *ex = [[MMRestNotImplementedException alloc] initWithReason:@"Not implemented!" userInfo:nil];
    
    @throw ex;
}

@end
