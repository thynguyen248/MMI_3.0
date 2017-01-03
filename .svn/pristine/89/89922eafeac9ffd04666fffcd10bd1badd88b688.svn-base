//
//  MMRestHttpTimeoutException.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestHttpException.h"

@interface MMRestHttpTimeoutException : MMRestHttpException {
    NSUInteger requestTimeout;
}

@property (assign, nonatomic) NSUInteger requestTimeout;

- (id) initWithReason:(NSString *)reason userInfo:(NSDictionary *)userInfo nestedException:(NSException *)nested containedError:(NSError *)error forUrl:(NSString *)url usingMethod:(NSString *)method withHeaders:(NSDictionary *)headers withTimeout:(NSUInteger) timeout;

@end
