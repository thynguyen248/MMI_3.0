//
//  MMJobsSerialisationFactoryImpl.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMSerialisationFactory.h"

@interface MMSerialisationFactoryImpl : NSObject <MMSerialisationFactory> {
@private
    id<MMSerialisationDateHelper> dateSerialisation;
}

@property (strong, nonatomic) id<MMSerialisationDateHelper> dateSerialisation;

- (id) initWithS11nDateHelper:(id<MMSerialisationDateHelper>) dateSerialisationHelper;
- (id) init;

@end
