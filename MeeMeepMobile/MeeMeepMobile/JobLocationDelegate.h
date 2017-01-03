//
//  JobLocationDelegate.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 18/02/13.
//
//

#import <Foundation/Foundation.h>

#import "CreateJobViewController.h"
#import "LocationSearchViewController.h"

@interface JobLocationDelegate : NSObject<LocationSearchDelegate> {
    CreateJobViewController* viewController;
    BOOL pickup;
}

-(id) initWithViewController:(CreateJobViewController*) initViewController pickup:(BOOL)initPickup;

@end
