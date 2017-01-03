//
//  SuburbSearchViewController.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 31/01/13.
//
//

#import "LocationSearchViewController.h"
#import "GUICommon.h"
#import "GPRetrieveAsyncActivity.h"
#import "GPRetrieveAsynActivityResult.h"
#import "GPClient.h"
#import "GPAutocompleteResult.h"
#import "MMAsyncActivityManagementImpl.h"
#import "AusPostUtil.h"
@interface LocationSearchViewController (Privates)

-(void) findNoResultsLabel;
-(void) updateTableString;
-(void) search:(NSString*) text;
-(void) updateResults;
-(void) timerSearchRefresh;
-(NSArray *) filterAutocompleteResults:(NSArray*) results;
-(NSString *) convertAutocompleteResult:(GPAutocompleteResult*) result;

@end

@implementation LocationSearchViewController

@synthesize searchDisplayController;
@synthesize searchBar;
@synthesize delegate;

-(id) initWithSuburb:(NSString *) suburb {
    if(self = [super init]) {
        activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
        stateMappings = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"VIC", @"VICTORIA",
                         @"NSW", @"NEW SOUTH WALES",
                         @"TAS", @"TASMANIA",
                         @"NT", @"NORTHERN TERRITORY",
                         @"WA", @"WESTERN AUSTRALIA",
                         @"ACT", @"AUSTRALIAN CAPITAL TERRITORY",
                         @"QLD", @"QUEENSLAND",
                         @"SA", @"SOUTH AUSTRALIA",
                         nil];
    }
    
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    
    searching = FALSE;

    [self.searchDisplayController.searchResultsTableView reloadData];
    [self findNoResultsLabel];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.searchBar becomeFirstResponder];
}

//This seems very very bogus, and has much potential to be broken in
//new SDK updates.
-(void) findNoResultsLabel {
    lblNoResults = nil;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.001);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        for (UIView* v in self.searchDisplayController.searchResultsTableView.subviews) {
            if ([v isKindOfClass: [UILabel class]]){
                lblNoResults = (UILabel*)v;
                [self updateTableString];
                break;
            }
        }
    });
}

-(void) updateTableString {
    if (lblNoResults != nil){
        if (searching) {
            [lblNoResults setText:@"Searching..."];
        } else {
            [lblNoResults setText:@"No Results Found"];
        }
        
        [self.searchDisplayController.searchResultsTableView reloadInputViews];
    }
}


-(IBAction)btnDoneClick:(id)sender{
    [self.searchDisplayController setActive:NO]; //Dismiss search display
    
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)btnBackClick:(id)sender{
    [self.searchDisplayController setActive:NO]; //Dismiss search display
    
    [self dismissModalViewControllerAnimated:YES];
}

-(void) timerSearchRefresh {
    searchResults = nil;
    [self.searchDisplayController.searchResultsTableView reloadData];
    [self search:self.searchBar.text];
    
    [searchRefresher invalidate];
    searchRefresher = nil;
}

-(void) search:(NSString*) text {
    @synchronized(self) {
        if(!searching) {
            searching = TRUE;
            GPClient* client = [[GPClient alloc] init];
            GPRetrieveAsyncActivity* activity = [[GPRetrieveAsyncActivity alloc] initWithActivityDelegate:self location:text client:client];
            [activityManagement dispatchMMAsyncActivity:activity];
            [self updateTableString];
        }
    }
}

/**
 * The results that come back from the Google API always contain 'Australia' as the last element
 * so we'll strip this off. Will also conver the state to a three letter abbreviation.
 */
-(NSString *) convertAutocompleteResult:(GPAutocompleteResult*) result {
    NSMutableString* string = [[NSMutableString alloc] init];
    
    //It's possible for only one term to be returned (If you search for Australia for example). In
    //this case just return this term.
    if([result.terms count] == 1) {
        return [result.terms objectAtIndex:0];
    }
    
    for(NSInteger i = 0; i < [result.terms count] - 1; ++i) {
        //State
        if(i == [result.terms count] - 2) {
            NSString* verboseState = [result.terms objectAtIndex:i];
            NSString* state = [stateMappings objectForKey:[verboseState uppercaseString]];
            //No mapping, just use the unmapped version
            if(state == nil) {
                state = verboseState;
            }
            
            [string appendString:state];
        } else {
            [string appendString:[result.terms objectAtIndex:i]];
        }
        
        if(i < [result.terms count] - 2) {
            [string appendString:@", "];
        }
    }
 
    return string;
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [GUICommon getMyTableViewCell:tableView];
    
    GPAutocompleteResult* details = [searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = [self convertAutocompleteResult:details];
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GPAutocompleteResult* result = [searchResults objectAtIndex:indexPath.row];
    NSString* completedNS = [self convertAutocompleteResult:result];
    [self.delegate locationSelected:completedNS];
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - UISearchDisplayDelegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self search:self.searchBar.text];
}


-(BOOL) searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return TRUE;
}


-(BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self.searchDisplayController.searchResultsTableView setHidden:FALSE];
    return YES;
}


- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range
  replacementText:(NSString *)text {
    //User has resumed typing, kill autorefresh timer
    if (searchRefresher != nil){
        [searchRefresher invalidate];
        searchRefresher = nil;
    }
    
    NSMutableString* currentText = [NSMutableString stringWithString:self.searchBar.text];
    [currentText replaceCharactersInRange:range withString:text];

    if (currentText.length>0){
        NSInteger waitInterval = 1.0; //Seconds until autoupdate will be triggered
        searchRefresher = [NSTimer scheduledTimerWithTimeInterval:waitInterval target:self selector:@selector(timerSearchRefresh) userInfo:nil repeats:TRUE];
    }
    
    return YES;
}

-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchCanResign = false;
}

-(void) searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    //[self.searchDisplayController.searchResultsTableView setHidden:TRUE];
}


-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchCanResign = true;
}

-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller{
    searchCanResign = true;
}

-(void) updateResults {
    [self updateTableString];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

- (void) onAsyncActivityCompletion:(id<MMAsyncActivityResult>) result {    
    searchResults = [self filterAutocompleteResults:((GPRetrieveAsynActivityResult*)result).results];
    searching = FALSE;
    [self performSelectorOnMainThread:@selector(updateResults) withObject:nil waitUntilDone:FALSE];
}

- (void) showAlertOnFailure {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"Failed to contact Google places API. Please check your connection settings, or try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
        
    [self.searchDisplayController.searchResultsTableView setHidden:YES];
    
    searching = FALSE;
}

- (void) onAsyncActivityFailure:(NSError *)error {
    searching = FALSE;
    [self updateTableString];
    [self performSelectorOnMainThread:@selector(showAlertOnFailure) withObject:nil waitUntilDone:NO];
}

-(NSArray *) filterAutocompleteResults:(NSArray*) results {
    NSMutableArray* filteredResults = [[NSMutableArray alloc] init];
    
    for(GPAutocompleteResult* result in results) {
        if([result isLocality]) {
            [filteredResults addObject:result];
        }
    }
    
    return filteredResults;
}

@end
