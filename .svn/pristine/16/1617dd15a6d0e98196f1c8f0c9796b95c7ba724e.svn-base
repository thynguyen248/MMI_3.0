//
//  PickupDeliveryTimeRange.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 5/02/13.
//
//

#import "PickupDeliveryTimeRangeListDelegate.h"
#import "FixedTransportView.h"

@implementation PickupDeliveryTimeRangeListDelegate

-(id) initWithController:(FixedTransportView*) initController pickup:(BOOL)initPickup data:(NSArray *) data {
    if(self = [super init]) {
        controller = initController;
        pickup = initPickup;
        
        items = [[NSMutableArray alloc] initWithCapacity:[data count]];
        
        NSInteger index = 0;
        for(NSString* entry in data) {
            [items addObject:[[ListSelectorItem alloc] initWithData:index description:entry]];
            ++index;
        }
    }
    
    return self;
}

-(ListSelectorItem*) getDefaultTimeRange {
    if(items == nil || [items count] == 0) {
        return nil;
    }
    
    return [items objectAtIndex:0];
}

-(NSString *) getTitle {
    if(pickup) {
        return @"Pickup time";
    } else {
        return @"Delivery time";
    }
}

-(NSArray *) getItems {
    return items;
}

-(BOOL) areMultipleSelectionsAllowed {
    return FALSE;
}

-(void) itemsSelected:(NSSet*) selectedItems {
    controller.time = [selectedItems anyObject];
}

@end
