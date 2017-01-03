//
//  AffiliateCategoryListDelegate.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 29/01/13.
//
//

#import <Foundation/Foundation.h>

#import "ListSelectorViewController.h"

@interface AffiliateCategoryListItem : ListSelectorItem {
    NSString* identifier;
}

-(id) initWithDataAndIdentifier:(NSInteger) initIndex description:(NSString *)initDescription
                     identifier:(NSString* )initIdentifier;

@property (nonatomic) NSString* identifier;

@end


@class AffiliateCategoryListDelegate;
@class CreateJobViewController;

@interface AffiliateCategoryListDelegate : NSObject<ListSelectorDelegate> {
    CreateJobViewController* viewController;
    NSMutableArray* items;
}

-(id) initWithController:(CreateJobViewController*) initViewController data:(NSArray *)data;

-(AffiliateCategoryListItem *) getNoneCategory;

@end


