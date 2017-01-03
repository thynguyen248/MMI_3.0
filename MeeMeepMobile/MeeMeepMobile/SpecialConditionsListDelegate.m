//
//  AffiliateCategoryListDelegate.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 29/01/13.
//
//

#import "SpecialConditionsListDelegate.h"
#import "CreateJobViewController.h"
#import "MMPair.h"

@implementation SpecialConditionListItem

@synthesize identifier;

-(id) initWithDataAndIdentifier:(NSInteger) initIndex description:(NSString *)initDescription
                     identifier:(NSString *)initIdentifier {
    if(self = [super initWithData:initIndex description:initDescription]) {
        self.identifier = initIdentifier;
    }
    
    return self;
}

@end

@implementation SpecialConditionsListDelegate

-(id) initWithController:(CreateJobViewController*) initViewController data:(NSArray *)data {
    if(self = [super init]) {
        viewController = initViewController;
        
        items = [[NSMutableArray alloc] initWithCapacity:[data count]];
        
        NSInteger index = 0;
        for(MMPair* pair in data) {
            [items addObject:[[SpecialConditionListItem alloc] initWithDataAndIdentifier:index description:pair.second identifier:pair.first]];
            ++index;
        }
    }
    
    return self;
}

-(NSString *) getTitle {
    return @"Special Conditions";
}

-(NSArray *) getItems {
    return items;
}

-(BOOL) areMultipleSelectionsAllowed {
    return TRUE;
}

-(void) itemsSelected:(NSSet*) selectedItems {
    viewController.specialConditions = selectedItems;
}

@end
