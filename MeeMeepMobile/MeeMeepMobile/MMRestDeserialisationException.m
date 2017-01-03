//
//  MMRestDeserialisationException.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 21/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestDeserialisationException.h"

static NSString *MMRestDeserialisationExceptionName = @"MMRestDeserialisationException";

@implementation MMRestDeserialisationException

@synthesize serialisedData;

- (id) initWithReason:(NSString *)reason userInfo:(NSDictionary *)userInfo nestedException:(NSException *)nested containedError:(NSError *) error serialisedData:(NSData *)data {
    self = [super initWithName:MMRestDeserialisationExceptionName reason:reason userInfo:userInfo nestedException:nested containedError:error];
    if (self) {
        self.serialisedData = data;
        return self;
    }
    
    return nil;
}


@end
