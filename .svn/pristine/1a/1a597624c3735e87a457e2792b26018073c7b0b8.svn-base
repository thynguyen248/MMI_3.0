//
//  MMRestSerialisationException.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 18/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestSerialisationException.h"

NSString *MMRestSerialisationExceptionName = @"MMRestSerialisationException";

@implementation MMRestSerialisationException

@synthesize unserialisedObject;

- (id) initWithReason:(NSString *)reason userInfo:(NSDictionary *)userInfo nestedException:(NSException *)nested containedError:(NSError *) error unserialisedObject:(id<MMObject>)object {
    self = [super initWithName:MMRestSerialisationExceptionName reason:reason userInfo:userInfo nestedException:nested containedError:error];
    if (self) {
        self.unserialisedObject = object;
        return self;
    }
    
    return nil;
}


@end
