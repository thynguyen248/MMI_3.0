//
//  MMMockRestHttpTransmissionImpl.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 4/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestHttpTransmission.h"
#import "MMMockHttpTransmissionResponseMatcher.h"

@interface MMMockRestHttpTransmissionImpl : NSObject<MMRestHttpTransmission> {
    id<MMMockHttpTransmissionResponseMatcher> getResponseMatcher;
    id<MMMockHttpTransmissionResponseMatcher> putResponseMatcher;
    id<MMMockHttpTransmissionResponseMatcher> postResponseMatcher;
}

@property (strong, nonatomic) id<MMMockHttpTransmissionResponseMatcher> getResponseMatcher;
@property (strong, nonatomic) id<MMMockHttpTransmissionResponseMatcher> putResponseMatcher;
@property (strong, nonatomic) id<MMMockHttpTransmissionResponseMatcher> postResponseMatcher;

- (id) initWithResponseMatchers:(id<MMMockHttpTransmissionResponseMatcher>) getMatcher put:(id<MMMockHttpTransmissionResponseMatcher>) putMatcher post:(id<MMMockHttpTransmissionResponseMatcher>) postMatcher;

@end
