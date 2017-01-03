//
//  MMRestJobsClientHelperLogicUnitTests.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 9/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestJobsClientHelperLogicUnitTests.h"
#import "MMRestJobsClientHelper.h"

@implementation MMRestJobsClientHelperLogicUnitTests

// All code under test must be linked into the Unit Test bundle
- (void)testQueryStringWithThreeParams {
    
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    
    [queryParams setObject:@"1" forKey:@"x"];
    [queryParams setObject:@"2" forKey:@"y"];
    [queryParams setObject:@"3" forKey:@"z"];
    
    NSString *queryString = [MMRestJobsClientHelper queryStringFromSearchParameters:queryParams];
    
    STAssertTrue([queryString isEqualToString:@"x=1&y=2&z=3"], @"Query string was incorrect");
}

- (void)testQueryStringWithOneParam {
    
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    
    [queryParams setObject:@"1" forKey:@"x"];
    
    NSString *queryString = [MMRestJobsClientHelper queryStringFromSearchParameters:queryParams];
    
    STAssertTrue([queryString isEqualToString:@"x=1"], @"Query string was incorrect");
}

- (void) testQueryStringWithNilParams {
    @try {
        [MMRestJobsClientHelper queryStringFromSearchParameters:nil];
        STFail(@"Should not have got here!");
    } @catch (NSException *anyEx) {
        STAssertNotNil(anyEx, @"Exception was nil");
    }
}

- (void)testQueryStringWithEmptyParams {
    
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    
    NSString *queryString = [MMRestJobsClientHelper queryStringFromSearchParameters:queryParams];
    
    STAssertTrue([queryString isEqualToString:@""], @"Query string was incorrect");
}


@end
