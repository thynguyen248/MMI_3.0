//
//  ListSelectorViewController.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 24/01/13.
//
//

#import "ListSelectorViewController.h"

@interface ListSelectorViewController (Private)
-(void) selectItem:(NSInteger) index;
-(void) deselectItem:(NSInteger) index;
-(void) deselectAllItems;
@end

@implementation ListSelectorViewController

@synthesize tableView;
@synthesize navTitleItem;
@synthesize selectedItems;
@synthesize cache;

-(id) initWithDelegate:(id<ListSelectorDelegate>)initDelegate {
    if(self = [super init]) {
        delegate = initDelegate;
        
        NSInteger itemCount = [[delegate getItems] count];
        
        cache = [[NSMutableArray alloc] initWithCapacity:itemCount];
        selectedItems = [[NSMutableSet alloc] initWithCapacity:itemCount];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navTitleItem.title = [delegate getTitle];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
}

-(void) initialiseSelectedItems:(NSSet *)newSelectedItems {
    [self.selectedItems removeAllObjects];
    
    for(ListSelectorItem* item in newSelectedItems) {
        [self.selectedItems addObject:item];
    }
}

-(void) initialiseSelectedItem:(ListSelectorItem *)newSelectedItem {
    [self initialiseSelectedItems:[NSSet setWithObject:newSelectedItem]];
}

-(void) setSelectedItem:(ListSelectorItem *)newSelectedItem {
    [self setSelectedItems:[NSSet setWithObject:newSelectedItem]];
}

#pragma mark - Table view

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[delegate getItems] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
	if(indexPath.row < cache.count) {
		cell = [cache objectAtIndex:indexPath.row];
	} else {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.accessoryType = UITableViewCellAccessoryNone;
    
        ListSelectorItem* item = [[delegate getItems] objectAtIndex:indexPath.row];
        cell.textLabel.text = item.description;
        cell.backgroundColor = [UIColor clearColor];
    
        [cache addObject:cell];
    }
    
    ListSelectorItem* item = [[delegate getItems] objectAtIndex:indexPath.row];
    if([selectedItems containsObject:item]) {
        [self selectItem:indexPath.row];
    } else if(![delegate areMultipleSelectionsAllowed] && [selectedItems count] == 0) {
        //Ensure that for a single selection list that something's always selected
        [self selectItem:indexPath.row];
        [selectedItems addObject:item];
    }
    
    return cell;
    
}

-(void) tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ListSelectorItem* item = [[delegate getItems] objectAtIndex:indexPath.row];
    
    //Already selected
    if([self.selectedItems containsObject:item]) {
        //If multiple selections are allowed then deselect, otherwise do nothing
        if([delegate areMultipleSelectionsAllowed]) {
            [self.selectedItems removeObject:item];
            [self deselectItem:indexPath.row];
        }
    //Multiple selections are allowed, so select this one as well
    } else {
        if([delegate areMultipleSelectionsAllowed]) {
            [self.selectedItems addObject:item];
            [self selectItem:indexPath.row];
        } else {
            //Multiples are not allowed and this is not selected, so selected this
            //one and deselect any other selected items
            [self deselectAllItems];
            [selectedItems removeAllObjects];
            
            [self selectItem:indexPath.row];
            [selectedItems addObject:item];
        }
    }
    
    [tv deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) selectItem:(NSInteger) index {
    UITableViewCell* cellView = [self.cache objectAtIndex:index];
    UIImage* image = [UIImage imageNamed:@"ListSelector-selected.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    button.frame = frame;   // match the button's size with the image size
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
    
    cellView.accessoryView = button;
}

-(void) deselectAllItems {
    for(ListSelectorItem* item in selectedItems) {
        [self deselectItem:item.index];
    }
}

-(void) deselectItem:(NSInteger) index {
    UITableViewCell* cellView = [self.cache objectAtIndex:index];
    cellView.accessoryView = nil;
}

-(IBAction)btnDoneClick:(id)sender{
    [delegate itemsSelected:selectedItems];
    
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)btnBackClick:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

@end

@implementation ListSelectorItem

@synthesize index;
@synthesize description;

-(id) initWithData:(NSInteger) initIndex description:(NSString *)initDescription {
    if(self = [super init]) {
        self.index = initIndex;
        self.description = initDescription;
    }
    
    return self;
}

-(BOOL) isEqual:(id)other {
    if (other == self) {
        return YES;
    }

    if (!other || ![other isKindOfClass:[self class]]) {
        return NO;
    }

    return [self isEqualToListSelectorItem:other];
}

-(BOOL) isEqualToListSelectorItem:(ListSelectorItem*)other {
    return self.index == other.index;    
}

-(NSUInteger)hash {
    return self.index;
}

@end

