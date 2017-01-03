//
//  MMRestHttpRemoteException.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestHttpRemoteException.h"

@implementation MMRestHttpRemoteException

@synthesize remoteError = _remoteError;

- (id) initWithReason:(NSString *)reason userInfo:(NSDictionary *)userInfo forRemoteError:(MMRestError *)error {
    self = [super initWithName:@"MMRestHttpRemoteException" reason:reason userInfo:userInfo];
    if (self) {
        _remoteError = error;
        return self;
    }
    
    return nil;
}


@end
