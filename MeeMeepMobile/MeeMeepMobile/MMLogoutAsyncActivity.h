//
//  MMLogoutAsyncActivity.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 2/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMAsyncActivity.h"
#import "MMRestClient.h"
#import "GUIRestDeligate.h"

@interface MMLogoutAsyncActivity : MMAsyncActivity {
    id<GUIRestDeligate> restDelegate;
}

@property (strong, nonatomic) id<GUIRestDeligate> restDelegate;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD;

@end
