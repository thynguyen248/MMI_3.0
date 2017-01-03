//
//  MMReAuthenticatingActivity.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMAsyncActivity.h"
#import "CredentialsManagement.h"
#import "GUIRestDeligate.h"
#import "MMRestClient.h"

@interface MMReAuthenticatingActivity : MMAsyncActivity {
    id<GUIRestDeligate> restDelegate;
}

@property (strong, nonatomic) id<GUIRestDeligate> restDelegate;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD;

- (id<MMAsyncActivityResult>) performAction;

@end
