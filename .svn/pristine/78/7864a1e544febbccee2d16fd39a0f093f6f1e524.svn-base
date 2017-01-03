//
//  MMMockQueuedHttpResponseMatcher.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMMockHttpTransmissionResponseMatcher.h"

@interface MMMockQueuedHttpResponseMatcher : NSObject<MMMockHttpTransmissionResponseMatcher> {
    NSMutableDictionary *urlDictionary;
}

- (void) addResponse:(MMRestHttpResponse *) response forUrl:(NSString *) url;

@end
