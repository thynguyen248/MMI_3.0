//
//  MMRestSerialisationException.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 18/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestException.h"
#import "MMObject.h"

@interface MMRestSerialisationException : MMRestException {
    id<MMObject> unserialisedObject;
}

@property (strong, nonatomic) id<MMObject> unserialisedObject;

- (id) initWithReason:(NSString *)reason userInfo:(NSDictionary *)userInfo nestedException:(NSException *)nested containedError:(NSError *) error unserialisedObject:(id<MMObject>) object;

@end
