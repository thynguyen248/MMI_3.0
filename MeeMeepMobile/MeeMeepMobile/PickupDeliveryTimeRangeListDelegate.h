//
//  PickupDeliveryTimeRange.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 5/02/13.
//
//

#import <Foundation/Foundation.h>

#import "ListSelectorViewController.h"

@class FixedTransportView;

@interface PickupDeliveryTimeRangeListDelegate : NSObject<ListSelectorDelegate> {
    FixedTransportView* controller;
    NSMutableArray* items;
    BOOL pickup;
}

-(id) initWithController:(FixedTransportView*) initController pickup:(BOOL)initPickup data:(NSArray *) data;
-(ListSelectorItem*) getDefaultTimeRange;

@end
