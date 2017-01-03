//
//  MMBidAcceptRequest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 8/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMBidAcceptRequest.h"
#import "GUICommon.h"

@implementation MMBidAcceptRequest

-(NSDictionary*) getAsDictionary
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithCapacity:5];
    [dict setValue:_bidId forKey:@"id"];
    [dict setValue:_fromAddress forKey:@"pickupAddress"];
    [dict setValue:_toAddress forKey:@"deliveryAddress"];
    [dict setValue:_mobileNumber forKey:@"mobileNumber"];
    [dict setValue:_cvc forKey:@"cvn"];
    if(_indemnity && ![_indemnity isNone])
    {
        [dict setValue:@"true" forKey:@"hasIndemnity"];
        [dict setValue:_indemnity.indemnityId forKey:@"indemnitySelector"];
    }
    return dict;
}

@end
