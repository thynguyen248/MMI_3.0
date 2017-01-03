//
//  MMRetrieveJobsSummaryListActivityResult.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 23/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMAsyncActivityResult.h"

@interface MMRetrieveJobsSummaryListActivityResult : NSObject<MMAsyncActivityResult> {
    NSArray *jobSummaryList;
}

@property (strong, nonatomic) NSArray *jobSummaryList;

@end
