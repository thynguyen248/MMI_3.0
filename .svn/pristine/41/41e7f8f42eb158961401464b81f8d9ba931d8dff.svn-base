//
//  SuburbSearchViewController.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 31/01/13.
//
//

#import <UIKit/UIKit.h>
#import "MMAsyncActivity.h"
#import "MMAsyncActivityManagement.h"

@protocol LocationSearchDelegate

-(void) locationSelected:(NSString *) location;

@end

@interface LocationSearchViewController : UIViewController<UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate, MMAsyncActivityDelegate> {
    BOOL searchCanResign;
    BOOL searching;
    BOOL showFirst;
    NSTimer* searchRefresher;
    UILabel* lblNoResults;
    
    NSArray* searchResults;
    id<MMAsyncActivityManagement> activityManagement;
    
    NSMutableDictionary* stateMappings;    
}

-(id) initWithSuburb:(NSString *) suburb;

@property (nonatomic, strong) IBOutlet UISearchBar* searchBar;
@property (nonatomic, strong) IBOutlet UISearchDisplayController* searchDisplayController;
@property (nonatomic, strong) id<LocationSearchDelegate> delegate;

@end
