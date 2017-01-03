//
//  MMBidCreationRequestSerialistion.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMSerialisation.h"
#import "MMSerialisationDateHelper.h"

@interface MMBidCreationRequestSerialisation : NSObject<MMSerialisation> {
     id<MMSerialisationDateHelper> dateSerialisation;
}

- (id) initWithDateS11nHelper:(id<MMSerialisationDateHelper>) dateS11nHelper;

@property (strong, nonatomic) id<MMSerialisationDateHelper> dateSerialisation;

@end
