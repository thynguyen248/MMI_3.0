//
//  MMMockHttpTransmissionGetMatcherImpl.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 4/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMMockHttpTransmissionResponseMatcher.h"

@interface MMMockHttpTransmissionGetMatcherImpl : NSObject<MMMockHttpTransmissionResponseMatcher> {
    NSMutableArray *responses;
}

@property (strong, nonatomic) NSMutableArray *responses;

- (id) init;
- (void) addResponse:(MMRestHttpResponse *) response forUrl:(NSString *) url andRequestParams:(NSDictionary *) params;

- (void) clearAllResponses;

- (BOOL) configuredHeaders:(NSDictionary *) configuredHeaders containedInRequestedHeaders:(NSDictionary *) requestedHeaders;
- (void) logResponses;

@end
