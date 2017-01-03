//
//  MMJobId.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMJobId : NSObject {
    
@private
    NSString *jobId;
}

@property (strong, nonatomic) NSString *jobId;

@end
