//
//  MMException.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMException.h"

@implementation MMException

@synthesize containedError;

- (id) initWithName:(NSString *)aName reason:(NSString *)aReason userInfo:(NSDictionary *)aUserInfo nestedError:(NSError *) e {
    self = [super initWithName:aName reason:aReason userInfo:aUserInfo];
    if (self) {
        self.containedError = e;
        
        return self;
    }
    
    return nil;
}

- (id) initWithReason:(NSString *)aReason userInfo:(NSDictionary *)aUserInfo nestedError:(NSError *)error {
    self = [self initWithName:@"MMException" reason:aReason userInfo:aUserInfo nestedError:error];
    if (self) {
        return self;
    }
    
    return nil;
}

@end
