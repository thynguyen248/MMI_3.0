//
//  MMBidAcceptRequest.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 8/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMObject.h"
#import "MMJobAddress.h"
#import "MMJobIndemnity.h"

@interface MMBidAcceptRequest : NSObject<MMObject>

@property (strong, nonatomic) NSNumber* bidId;
@property (strong, nonatomic) NSString* fromAddress;
@property (strong, nonatomic) NSString* toAddress;
@property (strong, nonatomic) NSString* mobileNumber;
@property (strong, nonatomic) MMJobIndemnity* indemnity;
@property (strong, nonatomic) NSString* cvc;

-(NSDictionary*) getAsDictionary;

@end
