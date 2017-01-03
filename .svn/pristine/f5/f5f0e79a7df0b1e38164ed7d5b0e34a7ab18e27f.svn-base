//
//  JobLocationDelegate.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 18/02/13.
//
//

#import "JobLocationDelegate.h"

@implementation JobLocationDelegate

-(id) initWithViewController:(CreateJobViewController*) initViewController pickup:(BOOL)initPickup {
    if(self = [super init]) {
        viewController = initViewController;
        pickup = initPickup;
    }
    
    return self;
}

-(void) locationSelected:(NSString *) location {
    if(pickup) {
        viewController.pickupLocation = location;
    } else {
        viewController.deliveryLocation = location;
    }
}

@end
