//
//  MMJobDetailResponseSerialisation.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMJobAddress.h"
#import "MMJobDetail.h"
#import "MMSerialisation.h"
#import "MMSerialisationDateHelper.h"

@interface MMJobDetailResponseSerialisation : NSObject<MMSerialisation> {
    
@private
    id<MMSerialisationDateHelper> dateSerialisation;
}

@property (strong, nonatomic) id<MMSerialisationDateHelper> dateSerialisation;

- (id) initWithDateHelper:(id<MMSerialisationDateHelper>) dateHelper;

@end
