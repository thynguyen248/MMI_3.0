//
//  MMRestHttpAuthorisedTransmissionImpl.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 8/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestHttpAuthorisedTransmission.h"
#import "MMRestHttpTransmission.h"

@interface MMRestHttpAuthorisedTransmissionImpl : NSObject<MMRestHttpAuthorisedTransmission> {
    id<MMRestHttpTransmission> httpTransmissionDelegate;
}

@property (strong, nonatomic) id<MMRestHttpTransmission> httpTransmissionDelegate;

- (id) initWithTransmissionDelegate:(id<MMRestHttpTransmission>) delegate;


@end
