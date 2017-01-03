//
//  MMAsynchActivityUnitTest.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 17/04/13.
//
//

#import <SenTestingKit/SenTestingKit.h>

#import "MMAsyncActivity.h"
#import "MMAsyncActivityResult.h"

@interface TestableMMAsynchActivity : MMAsyncActivity {
    id<MMAsyncActivityResult> result;
    NSException* exception;
}

-(id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>) delegate andResult:(id<MMAsyncActivityResult>) result andException:(NSException *) exception;

@end

@interface MMAsynchActivityUnitTest : SenTestCase

@end
