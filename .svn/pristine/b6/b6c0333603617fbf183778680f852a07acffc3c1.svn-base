//
//  MMCanOfferIndemnityAsynchActivity.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 22/04/13.
//
//

#import "MMCanOfferIndemnityAsynchActivity.h"
#import "MMCanOfferIndemnityAsynchActivityResult.h"
#import "MMRestClient.h"

@implementation MMCanOfferIndemnityAsynchActivity

- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d restDelegate:(id<GUIRestDeligate>) restD
                         userID:(NSNumber *) initUserID {
    if(self = [super initWithActivityDelegate:d restDelegate:restD]) {
        userID = initUserID;
    }
    
    return self;
}

- (id<MMAsyncActivityResult>) performAction {
    id<MMRestClient> restClient = [restDelegate getRestClient];
    
    MMCanOfferIndemnityAsynchActivityResult *result = [[MMCanOfferIndemnityAsynchActivityResult alloc] init];
    
    id<MMRestUserClient> userClient = [restClient getUserClient];
    BOOL canOffer = [userClient canOfferIndemnity:userID token:[restDelegate getAccessToken]];
    
    result.canOffer = canOffer;
    
    return result;
}

@end
