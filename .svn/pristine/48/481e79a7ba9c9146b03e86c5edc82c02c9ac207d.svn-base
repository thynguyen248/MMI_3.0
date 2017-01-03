//
//  MMRestException.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 18/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestException.h"

@implementation MMRestException

@synthesize nestedException;

- (id) initWithReason:(NSString *) reason userInfo:(NSDictionary *) userInfo nestedException:(NSException *) nested containedError:(NSError *)error {
    self = [self initWithName:@"MMRestException" reason:reason userInfo:userInfo nestedError:error];
    return (self) ? self : nil;
}

- (id) initWithName:(NSString *) name reason:(NSString *) reason userInfo:(NSDictionary *) userInfo nestedException:(NSException *) nested containedError:(NSError *) error {
    self = [super initWithName:name reason:reason userInfo:userInfo nestedError:error];
    if (self) {
        self.nestedException = nested;
        return self;
    }
    
    return nil;
}

@end
