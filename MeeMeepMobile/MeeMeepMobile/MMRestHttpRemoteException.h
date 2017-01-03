//
//  MMRestHttpRemoteException.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
 
#import "MMRestError.h"

@interface MMRestHttpRemoteException : NSException {
    MMRestError *remoteError;
}

@property (strong, nonatomic) MMRestError *remoteError;

- (id) initWithReason:(NSString *)reason userInfo:(NSDictionary *)userInfo forRemoteError:(MMRestError *) error;;

@end
