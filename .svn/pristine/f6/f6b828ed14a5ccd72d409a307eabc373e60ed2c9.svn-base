//
//  MMCreateMessageAsyncActivity.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMReAuthenticatingActivity.h"
#import "MMRestClient.h"

@interface MMCreateMessageAsyncActivity : MMReAuthenticatingActivity {
    MMMessageDetail *messageToCreate;
}

@property (strong, nonatomic) MMMessageDetail *messageToCreate;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>)restD messageToCreate:(MMMessageDetail*)message;

@end
