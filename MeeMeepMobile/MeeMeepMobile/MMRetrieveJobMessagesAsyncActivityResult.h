//
//  MMRetrieveJobMessagesActivityResult.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 26/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMAsyncActivityResult.h"

@interface MMRetrieveJobMessagesAsyncActivityResult : NSObject <MMAsyncActivityResult> {
    NSArray *messages;
}

@property (strong, nonatomic) NSArray *messages;

@end
