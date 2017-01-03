//
//  AffiliateCategoryListDelegate.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 29/01/13.
//
//

#import <Foundation/Foundation.h>

#import "ListSelectorViewController.h"

@class CreateJobViewController;

@interface SpecialConditionListItem : ListSelectorItem {
    NSString* identifier;
}

-(id) initWithDataAndIdentifier:(NSInteger) initIndex description:(NSString *)initDescription
                     identifier:(NSString *)initIdentifier;

@property (nonatomic) NSString* identifier;

@end

@interface SpecialConditionsListDelegate : NSObject<ListSelectorDelegate> {
    CreateJobViewController* viewController;
    NSMutableArray* items;
}

-(id) initWithController:(CreateJobViewController*) initViewController data:(NSArray *)data;

@end


