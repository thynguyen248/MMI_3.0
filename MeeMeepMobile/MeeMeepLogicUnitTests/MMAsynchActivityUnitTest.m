//
//  MMAsynchActivityUnitTest.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 17/04/13.
//
//

#import "MMAsynchActivityUnitTest.h"
#import "MMAsyncActivityDelegate.h"
#import "UnitTestHelper.h"
#import "OCMock.h"
#import "MMException.h"
#import "MMErrorUtils.h"

@implementation MMAsynchActivityUnitTest

-(void) testSuccess {
    id asynchDelegate = [UnitTestHelper mockAsynchActivityDelegate];
    id asynchResult = [UnitTestHelper mockAsynchActivityResult];
    
    [UnitTestHelper addOnAsynchActivityCompletionExpectations:asynchDelegate result:asynchResult];
        
    MMAsyncActivity* underTest = [[TestableMMAsynchActivity alloc] initWithActivityDelegate:asynchDelegate andResult:asynchResult andException:nil];
    
    [underTest main];
    
    [asynchDelegate verify];
    [asynchResult verify];    
}

-(void) testMMException {
    id asynchDelegate = [UnitTestHelper mockAsynchActivityDelegate];
    NSError* error = [NSError errorWithDomain:@"Domain" code:123 userInfo:nil];
    MMException* exception = [[MMException alloc] initWithName:@"Error" reason:@"Reason" userInfo:nil nestedError:error];
    
    
    [UnitTestHelper addOnAsynchActivityFailureExpectations:asynchDelegate result:error];
    
    MMAsyncActivity* underTest = [[TestableMMAsynchActivity alloc] initWithActivityDelegate:asynchDelegate andResult:nil andException:exception];
    
    [underTest main];
    
    [asynchDelegate verify];
}

-(void) testOtherException {
    id asynchDelegate = [UnitTestHelper mockAsynchActivityDelegate];

    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
    [userInfo setValue:@"Reason" forKey:NSLocalizedDescriptionKey];
    [userInfo setValue:@"Reason" forKey:NSLocalizedFailureReasonErrorKey];
    
    NSError* error = [NSError errorWithDomain:MMApplicationDomain code:DEFAULT_MM_ERROR_CODE userInfo:userInfo];
    
    NSException* exception = [NSException exceptionWithName:@"Error" reason:@"Reason" userInfo:nil];
    
    [UnitTestHelper addOnAsynchActivityFailureExpectations:asynchDelegate result:error];
    
    MMAsyncActivity* underTest = [[TestableMMAsynchActivity alloc] initWithActivityDelegate:asynchDelegate andResult:nil andException:exception];
    
    [underTest main];
    
    [asynchDelegate verify];
}

@end


@implementation TestableMMAsynchActivity

-(id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>) initDelegate andResult:(id<MMAsyncActivityResult>) initResult andException:(NSException *) initException {
    if(self = [super initWithActivityDelegate:initDelegate]) {
        result = initResult;
        exception = initException;
    }
    
    return self;
}

- (id<MMAsyncActivityResult>) doWork {
    if(exception == nil) {
        return result;
    } else {
        @throw exception;
    }

}

@end