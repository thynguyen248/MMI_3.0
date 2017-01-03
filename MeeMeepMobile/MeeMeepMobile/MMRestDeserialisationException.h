//
//  MMRestDeserialisationException.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 21/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestException.h"

@interface MMRestDeserialisationException : MMRestException {
    NSData *serialisedData;
}

@property (strong, nonatomic) NSData *serialisedData;

- (id) initWithReason:(NSString *)reason userInfo:(NSDictionary *)userInfo nestedException:(NSException *)nested containedError:(NSError *) error serialisedData:(NSData *) data;

@end
