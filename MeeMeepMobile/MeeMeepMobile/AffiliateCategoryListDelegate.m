//
//  AffiliateCategoryListDelegate.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 29/01/13.
//
//

#import "AffiliateCategoryListDelegate.h"
#import "CreateJobViewController.h"
#import "MMPair.h"

@implementation AffiliateCategoryListItem

@synthesize identifier;

-(id) initWithDataAndIdentifier:(NSInteger) initIndex description:(NSString *)initDescription
                     identifier:(NSString *)initIdentifier {
    if(self = [super initWithData:initIndex description:initDescription]) {
        self.identifier = initIdentifier;
    }
    
    return self;
}

@end

@implementation AffiliateCategoryListDelegate

-(id) initWithController:(CreateJobViewController*) initViewController data:(NSArray *)data {
    if(self = [super init]) {
        viewController = initViewController;
        
        items = [[NSMutableArray alloc] initWithCapacity:[data count]];
        
        NSInteger index = 0;
        for(MMPair* pair in data) {
            [items addObject:[[AffiliateCategoryListItem alloc] initWithDataAndIdentifier:index description:pair.second identifier:pair.first]];
            ++index;
        }
    }
    
    return self;
}

-(AffiliateCategoryListItem *) getNoneCategory {
    if(items == nil || [items count] == 0) {
        return nil;
    }
    
    return [items objectAtIndex:0];
}

-(NSString *) getTitle {
    return @"Affiliate Category";
}

-(NSArray *) getItems {
    return items;
}

-(BOOL) areMultipleSelectionsAllowed {
    return FALSE;
}

-(void) itemsSelected:(NSSet*) selectedItems {
    viewController.affiliateCategory = [selectedItems anyObject];
}

@end
