//
//  MMLoginActivityResult.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 22/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMLoginActivityResult.h"

@implementation MMLoginActivityResult

@synthesize loginResultAccessToken;
@synthesize loginResultUserProfile;

- (id) initWithAccessToken:(MMRestAccessToken *) token andUserProfile:(MMUserProfile*) userProfile {
    self = [super init];
    
    if (self) {
        self.loginResultAccessToken = token;
        self.loginResultUserProfile = userProfile;
        return self;
    }
    
    return nil;
}

@end
