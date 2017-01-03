//
//  ListSelectorViewController.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 24/01/13.
//
//

#import <UIKit/UIKit.h>

@class ListSelectorItem;

@protocol ListSelectorDelegate

-(NSString *) getTitle;
-(NSArray *) getItems;
-(BOOL) areMultipleSelectionsAllowed;
-(void) itemsSelected:(NSSet*) selectedItems;

@end

@interface ListSelectorViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
    BOOL multipleSelectionsAllowed;
    id<ListSelectorDelegate> delegate;    
}

-(id) initWithDelegate:(id<ListSelectorDelegate>)initDelegate;
-(void) initialiseSelectedItems:(NSSet *)newSelectedItems;
-(void) initialiseSelectedItem:(ListSelectorItem *)newSelectedItem;

@property (nonatomic, strong) NSMutableArray* cache;
@property (nonatomic, strong) NSMutableSet* selectedItems;
@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic,strong) IBOutlet UINavigationItem* navTitleItem;

@end

@interface ListSelectorItem : NSObject {
    
}

-(id) initWithData:(NSInteger) initIndex description:(NSString *)initDescription;
-(BOOL) isEqualToListSelectorItem:(ListSelectorItem*)other;

@property (nonatomic) NSInteger index;
@property (nonatomic, strong) NSString* description;

@end
