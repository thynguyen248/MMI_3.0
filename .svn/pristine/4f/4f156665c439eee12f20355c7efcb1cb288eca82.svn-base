//
//  MMRegistrationAsyncActivity.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMReAuthenticatingActivity.h"
#import "MMRestClient.h"
#import "MMNewUser.h"

@interface MMRegistrationAsyncActivity : MMReAuthenticatingActivity

@property (strong, nonatomic) MMNewUser *userProfile;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>)restD userProfile:(MMNewUser *)profile;

@end
