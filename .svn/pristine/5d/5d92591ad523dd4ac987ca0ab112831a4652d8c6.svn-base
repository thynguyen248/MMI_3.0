//
//  MMLoginResponseSerialisation.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 6/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMLoginResponseSerialisation.h"
#import "MMSerialisationUtils.h"
#import "MMRestDeserialisationException.h"
#import "MMRestNotImplementedException.h"
#import "MMLoginResponse.h"

@implementation MMLoginResponseSerialisation

- (id<MMObject>) deserialiseData:(NSData*) data {
    @try {
        NSDictionary *loginResponseDict = [MMSerialisationUtils deserialiseData:data];
        
        MMLoginResponse* response = [[MMLoginResponse alloc] init];
        
        id success = [loginResponseDict objectForKey:@"success"];
        
        if (success == nil || [success boolValue] == false)
        {
            DLog(@"Login error");
            NSString *errorString = [MMSerialisationUtils nilIfNSNull:[loginResponseDict objectForKey:@"error"]];
            
            if (errorString == nil)
            {
                errorString = @"Unknown error occured";
            }
            response.errorMessage = errorString;
        }
        else
        {
            DLog(@"Login success");
            response.userName = [MMSerialisationUtils nilIfNSNull:[loginResponseDict objectForKey:@"username"]];
            
            id userId = [MMSerialisationUtils nilIfNSNull:[loginResponseDict objectForKey:@"id"]];
            if(userId != nil)
            {
                response.userId = [NSNumber numberWithInteger:[userId integerValue]];
            }
        }
        return response;
        
    } @catch (NSException *anyEx) {
        MMRestDeserialisationException *s11nEx = [[MMRestDeserialisationException alloc] initWithReason:@"Could not de-serialise login response" userInfo:nil nestedException:anyEx containedError:nil serialisedData:nil];
        @throw s11nEx;
    }
}

- (NSData*) serialise:(id <MMObject>) object {
    @throw [[MMRestNotImplementedException alloc] initWithReason:@"Not implemented for login response" userInfo:nil];
}

@end
