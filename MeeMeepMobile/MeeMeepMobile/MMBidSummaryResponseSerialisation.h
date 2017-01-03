//
//  MMBidSummaryResponseSerialisation.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 1/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMSerialisation.h"
#import "MMSerialisationDateHelper.h"
#import "MMBidSummary.h"

@interface MMBidSummaryResponseSerialisation : NSObject<MMSerialisation> {
    
    id<MMSerialisationDateHelper> dateS11nHelper;
}

@property (strong, nonatomic) id<MMSerialisationDateHelper> dateS11nHelper;

- (id) initWithDateS11nHelper:(id<MMSerialisationDateHelper>) dateS11nHelper;
- (MMBidSummary *) getBidSummaryForDictionary:(NSDictionary *) dict; 

@end
