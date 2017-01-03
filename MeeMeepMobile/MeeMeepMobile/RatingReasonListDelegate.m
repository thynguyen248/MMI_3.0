//
//  AffiliateCategoryListDelegate.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 29/01/13.
//
//

#import "RatingReasonListDelegate.h"
#import "MMPair.h"
#import "CompleteJobViewController.h"

@implementation RatingReasonListItem

@synthesize identifier;

-(id) initWithDataAndIdentifier:(NSInteger) initIndex description:(NSString *)initDescription
                     identifier:(NSString *)initIdentifier {
    if(self = [super initWithData:initIndex description:initDescription]) {
        self.identifier = initIdentifier;
    }
    
    return self;
}

@end

@implementation RatingReasonListDelegate

-(id) initWithController:(CompleteJobViewController*) initViewController data:(NSArray *)data {
    if(self = [super init]) {
        viewController = initViewController;
        
        items = [[NSMutableArray alloc] initWithCapacity:[data count]];
        
        NSInteger index = 0;
        for(MMPair* pair in data) {
            [items addObject:[[RatingReasonListItem alloc] initWithDataAndIdentifier:index description:pair.second identifier:pair.first]];
            ++index;
        }
    }
    
    return self;
}

-(NSString *) getTitle {
    return @"Rating Reason";
}

-(NSArray *) getItems {
    return items;
}

-(BOOL) areMultipleSelectionsAllowed {
    return TRUE;
}

-(void) itemsSelected:(NSSet*) selectedItems {
    viewController.reasonsSet = selectedItems;
}

@end
