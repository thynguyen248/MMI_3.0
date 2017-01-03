//
//  MMInitialResponse.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMObject.h"

@interface MMInitialResponse : NSObject <MMObject> {
    NSDictionary *domainLinks;
}

@property (strong, nonatomic) NSDictionary *domainLinks;

@end
