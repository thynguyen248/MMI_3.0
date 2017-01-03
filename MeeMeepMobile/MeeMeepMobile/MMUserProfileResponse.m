//
//  MMUserProfileResponse.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 5/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMUserProfileResponse.h"

@implementation MMUserProfileResponse

@synthesize userProfile;

- (id) initWithUserProfile:(MMUserProfile *) up {
    self = [super init];
    if (self) {
        self.userProfile = up;
        return self;
    }
    
    return nil;
}

@end
