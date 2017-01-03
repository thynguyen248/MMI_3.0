//
//  MMMessageDetailListResponseSerialisation.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMSerialisation.h"
#import "MMSerialisationDateHelper.h"

@interface MMMessageDetailListResponseSerialisation : NSObject<MMSerialisation> {
    id<MMSerialisationDateHelper> s11nDateHelper;
}

@property (strong, nonatomic) id<MMSerialisationDateHelper> s11nDateHelper;

- (id) initWithDateHelper:(id<MMSerialisationDateHelper>) dateHelper;

@end
