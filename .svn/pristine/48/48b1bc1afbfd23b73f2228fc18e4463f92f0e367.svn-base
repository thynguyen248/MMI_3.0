//
//  MMErrorUtils.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMErrorUtils.h"
#import "MMException.h"
#import "MMRestErrorSerialisation.h"
#import "MMRestError.h"

NSString *MMApplicationDomain = @"MMApplicationDomain";
NSInteger DEFAULT_MM_ERROR_CODE = 999;

@implementation MMErrorUtils

+ (NSError *) errorForException:(NSException *) exception withDomain:(NSString *) domain andCode:(NSNumber *) code {
    
    NSInteger errorCode = (code) ? [code intValue] : DEFAULT_MM_ERROR_CODE;
    
    if (exception == nil) {
        return nil;
    }
    
    NSString *domainToUse = (domain) ? domain : MMApplicationDomain;
    
    if ([exception isKindOfClass:[MMException class]]) {
        MMException *mmex = (MMException *) exception;
        return mmex.containedError;
    } 
    
    // we have to compose an error from the info in the exception;
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:exception.userInfo];
    
    [userInfo setValue:exception.description forKey:NSLocalizedDescriptionKey];
    [userInfo setValue:exception.reason forKey:NSLocalizedFailureReasonErrorKey];
    
    NSError *error = [[NSError alloc] initWithDomain:domainToUse code:errorCode userInfo:userInfo];
    
    return error;
}

+ (void) throwMMExceptionForResponseOnError:(MMRestHttpResponse *) response withReason:(NSString *) reason deserialisedWith:(MMRestErrorSerialisation *) errorS11n {
    if (response == nil) {
        MMException *ex = [[MMException alloc] initWithName:NSInvalidArgumentException reason:@"Response object was nil" userInfo:nil nestedError:nil];
        
        @throw ex;
    }

    
    BOOL throwEx = NO;
    NSError *error = nil;
    
    if (response.isRemoteRestError) {
        MMRestError *restError = [errorS11n deserialiseData:response.responseBody];
        if(restError.statusCode == nil) {
            restError.statusCode = [NSNumber numberWithInteger:response.responseCode];
        }
        error = [restError error];
        throwEx = YES;
    } else if (response.localError) {
        error = response.localError;
        throwEx = YES;
    } else {
        throwEx = NO;
    }
    
    if (throwEx) {
        MMException *ex = [[MMException alloc] initWithReason:reason userInfo:nil nestedError:error];
        
        @throw ex;
    }
}

@end
