//
//  MMRestException.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 18/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMException.h"

@interface MMRestException : MMException {
    NSException *nestedException;
}

@property (strong, nonatomic) NSException *nestedException;

- (id) initWithReason:(NSString *) reason userInfo:(NSDictionary *) userInfo nestedException:(NSException *) nested containedError:(NSError *) error;
- (id) initWithName:(NSString *) name reason:(NSString *) reason userInfo:(NSDictionary *) userInfo nestedException:(NSException *) nested containedError:(NSError *) error;

@end
