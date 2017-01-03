//
//  MMRetrieveJobDetailActivityResult.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 24/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMAsyncActivityResult.h"
#import "MMJobDetail.h"

@interface MMRetrieveJobDetailActivityResult : NSObject<MMAsyncActivityResult> {
    MMJobDetail *retrievedDetail;
}

@property (strong, nonatomic) MMJobDetail *retrievedDetail;

@end
