//
//  MMJobSummaryResponseSerialisation.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMSerialisation.h"
#import "MMJobSummary.h"
#import "MMSerialisationDateHelper.h"


@interface MMRecentJobSummaryResponseSerialisation : NSObject<MMSerialisation> {
    id<MMSerialisationDateHelper> dateSerialisation;
}

@property (strong, nonatomic) id<MMSerialisationDateHelper> dateSerialisation;

- (id) initWithDateHelper:(id<MMSerialisationDateHelper>) dateS11nHelper;

@end
