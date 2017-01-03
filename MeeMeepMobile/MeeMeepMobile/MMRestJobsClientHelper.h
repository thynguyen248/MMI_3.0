//
//  MMRestJobsClientHelper.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 9/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMRestJobsClientHelper : NSObject

+ (NSString *) queryStringFromSearchParameters:(NSDictionary *) searchParameters;

@end
