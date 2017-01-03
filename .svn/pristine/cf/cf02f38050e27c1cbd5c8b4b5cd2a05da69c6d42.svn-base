//
//  MMLoginActivityResult.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 22/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMAsyncActivityResult.h"
#import "MMRestAccessToken.h"
#import "MMUserProfile.h"

@interface MMLoginActivityResult : NSObject<MMAsyncActivityResult> {
    MMRestAccessToken *loginResultAccessToken;
    MMUserProfile* loginResultUserProfile;
}

@property (strong, nonatomic) MMRestAccessToken *loginResultAccessToken;
@property (strong, nonatomic) MMUserProfile* loginResultUserProfile;

- (id) initWithAccessToken:(MMRestAccessToken *) token andUserProfile:(MMUserProfile*) userProfile;

@end
