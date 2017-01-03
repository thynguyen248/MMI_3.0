//
//  MMRestError.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 30/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestError.h"
#import "MMSerialisationUtils.h"
#import "MMErrorUtils.h"

@implementation MMRestError

@synthesize detail;
@synthesize reason;
@synthesize statusCode;

- (id) initWithDetail:(NSString *) det reason:(NSString *) rsn statusCode:(NSNumber *) code {
    self = [super init];
    if (self) {
        self.detail = det;
        self.reason = rsn;
        self.statusCode = code;
        return self;
    }
    
    return nil;
}

+ (MMRestError *) errorFromDictionary:(NSDictionary *) dict {
    DLog(@"error from dictionary");
    if (dict == nil) return nil;
    
    id errorList = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"errors"]];
    
    if(errorList == nil)
    {
        // single error
        MMRestError *error = [[MMRestError alloc] init];
        error.detail = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"error"]];
        error.reason = [MMSerialisationUtils nilIfNSNull:[dict objectForKey:@"error"]];
        
        return error;
    }
    
    DLog(@"checking selector");
    if([errorList respondsToSelector:NSSelectorFromString(@"count")])
    {
        DLog(@"conforms to selector");
        // multiple errors
        if ([errorList count] > 0) {
            // TODO: perhaps implement to handle multiple errors
            // get the first one
            NSDictionary *first = (NSDictionary*)[errorList objectAtIndex:0];
            
            MMRestError *error = [[MMRestError alloc] init];
            error.detail = [MMSerialisationUtils nilIfNSNull:[first objectForKey:@"message"]];
            error.reason = [MMSerialisationUtils nilIfNSNull:[first objectForKey:@"message"]];
            
            return error;
        }
    }
    else
    {
        // This is unexpected, but we don't want to error because of it
        DLog(@"doesn't conform, just to-string it");
        NSString* message = [NSString stringWithFormat:@"%@", errorList];
        
        DLog(@"message: %@", message);
        MMRestError *error = [[MMRestError alloc] init];
        error.detail = message;
        error.reason = message;
        
        return error;
    }
    return nil;
}

- (NSError *) error {
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setValue:self.detail forKey:NSLocalizedDescriptionKey];
    [userInfo setValue:self.reason forKey:NSLocalizedFailureReasonErrorKey];
    NSError *newError = [[NSError alloc] initWithDomain:MMApplicationDomain code:[self.statusCode integerValue] userInfo:userInfo];
    return newError;
}

@end
