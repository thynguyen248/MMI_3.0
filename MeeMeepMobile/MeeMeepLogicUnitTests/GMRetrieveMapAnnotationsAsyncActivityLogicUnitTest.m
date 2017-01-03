//
//  GMRetrieveMapAnnotationsAsyncActivityLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by User on 6/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GMRetrieveMapAnnotationsAsyncActivityLogicUnitTest.h"

#import "MMMockAsyncActivityDelegate.h"
#import "MMAsyncActivityManagementImpl.h"
#import "GMRetrieveMapAnnotationsAsyncActivity.h"
#import "GMRetrieveMapAnnotationsAsyncActivityResult.h"
#import "GMMapAnnotationsClientImpl.h"


@implementation GMRetrieveMapAnnotationsAsyncActivityLogicUnitTest


// All code under test must be linked into the Unit Test bundle
- (void)testRetrieveMapAnnotationsActivitySuccess {
    
    MMMockAsyncActivityDelegate *mockDel = [[MMMockAsyncActivityDelegate alloc] init];
    
    id<GMMapAnnotationsClient> mapClient = [[GMMapAnnotationsClientImpl alloc] init];
    
    id<MMAsyncActivityManagement> activityManagement = [[MMAsyncActivityManagementImpl alloc] init];
    
    NSString* query = @"7 Gavan St Kilmore East";
    
    GMRetrieveMapAnnotationsAsyncActivity* retrieveAnnotationsActivity = [[GMRetrieveMapAnnotationsAsyncActivity alloc] initWithActivityDelegate:mockDel forQuery:query mapClient:mapClient];
    
    [activityManagement dispatchMMAsyncActivity:retrieveAnnotationsActivity];
    
    [retrieveAnnotationsActivity waitUntilFinished];
    
    id<MMAsyncActivityResult> result = mockDel.activityResult;
    STAssertNotNil(result, @"Activity result was not delivered");
    
    if ([result isKindOfClass:[GMRetrieveMapAnnotationsAsyncActivityResult class]]) {
        GMRetrieveMapAnnotationsAsyncActivityResult* searchActivityResult = (GMRetrieveMapAnnotationsAsyncActivityResult*) result;
        NSArray* searchResults = searchActivityResult.retrievedMapAnnotations;
        
        if ([searchResults count]<1) STFail(@"Failed to find address(es) for", query);
        
    } else {
        STFail(@"Search query failed to execute");
    }
}


@end
