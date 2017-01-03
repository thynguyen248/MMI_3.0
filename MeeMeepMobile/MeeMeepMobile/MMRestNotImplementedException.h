//
//  MMRestSerialisationNotImplementedException.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 18/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestException.h"

@interface MMRestNotImplementedException : MMRestException

- (id) initWithReason:(NSString *)reason userInfo:(NSDictionary *)userInfo;

@end
