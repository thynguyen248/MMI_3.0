//
//  MMException.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMException : NSException {
    NSError *containedError;
}

@property (strong, nonatomic) NSError *containedError;

- (id) initWithName:(NSString *)aName reason:(NSString *)aReason userInfo:(NSDictionary *)aUserInfo nestedError:(NSError *) e;
- (id) initWithReason:(NSString *) aReason userInfo:(NSDictionary *) aUserInfo nestedError:(NSError *) error;

@end
