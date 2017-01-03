//
//  MMJobCreationRequest.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 15/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMObject.h"
#import "MMJobDetail.h"

@interface MMJobCreationRequest : NSObject<MMObject> {
    MMJobDetail *jobDetail;
}

@property (strong, nonatomic) MMJobDetail *jobDetail;

@end
