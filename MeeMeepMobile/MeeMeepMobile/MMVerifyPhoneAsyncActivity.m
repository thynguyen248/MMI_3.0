//
//  MMVerifyPhoneAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Julian Raff on 6/02/13.
//
//

#import "MMVerifyPhoneAsyncActivity.h"
#import "MMVerifyPhoneAsyncActivityResult.h"

@implementation MMVerifyPhoneAsyncActivity

@synthesize phoneNumber;

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>)restD phoneNumber:(NSString *)number {
    self = [super initWithActivityDelegate:d restDelegate:restD];
    if (self) {
        self.phoneNumber = number;
        return self;
    }
    
    return nil;
}

- (id<MMAsyncActivityResult>) performAction {
    if (self.phoneNumber == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"User to register was nil" userInfo:nil];
    
    id<MMRestClient> restClient = [self.restDelegate getRestClient];
    
    id<MMRestUserClient> userClient = [restClient getUserClient];
    
    MMVerifyPhoneAsyncActivityResult* result = [[MMVerifyPhoneAsyncActivityResult alloc] init];
    result.success = [userClient sendVerifySMS:self.phoneNumber];
    
    if(result.success) {
        return result;
    } else {
        DLog(@"Send Verify SMS failed");
        @throw [NSException exceptionWithName:NSGenericException reason:@"Send Verify SMS failed" userInfo:nil];
    }
}

@end
