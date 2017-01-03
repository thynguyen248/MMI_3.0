//
//  MMRestHttpTimeoutException.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestHttpTimeoutException.h"

@implementation MMRestHttpTimeoutException

@synthesize requestTimeout;

- (id) initWithReason:(NSString *)reason userInfo:(NSDictionary *)userInfo nestedException:(NSException *)nested containedError:(NSError *)error forUrl:(NSString *)url usingMethod:(NSString *)method withHeaders:(NSDictionary *)headers withTimeout:(NSUInteger) timeout {
    
    self = [super initWithReason:reason userInfo:userInfo nestedException:nested containedError:error forUrl:url usingMethod:method withHeaders:headers];
    
    if (self) {
        self.requestTimeout = timeout;
        return self;
    }
    
    return nil;
}

@end
