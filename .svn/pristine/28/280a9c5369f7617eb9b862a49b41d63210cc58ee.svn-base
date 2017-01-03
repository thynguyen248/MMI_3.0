//
//  MeeMeepAddressStringFromJobAddressLogicUnitTest.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 19/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MeeMeepAddressStringFromJobAddressLogicUnitTest.h"

#import "MMJobAddress.h"
#import "GUICommon.h"

@implementation MeeMeepAddressStringFromJobAddressLogicUnitTest

// All code under test must be linked into the Unit Test bundle
- (void)testGetAddress1 {
    
    MMJobAddress *address = [[MMJobAddress alloc] init];
    
    address.streetNumber = @"5";
    address.streetName = @"Sarah Cl";
    address.suburb = @"Clayton South";
    address.state = @"Victoria";
    address.postCode = @"3169";

    NSString *expected = @"5 Sarah Cl, Clayton South, Victoria, 3169";
    
    NSString *addrString = [GUICommon addressStringForMMJobAddress:address];
    
    DLog(@"Address string: %@", addrString);
    
    STAssertTrue([addrString isEqualToString:expected], @"Job address string not as expected");
}

// All code under test must be linked into the Unit Test bundle
- (void)testGetAddress2 {
    
    MMJobAddress *address = [[MMJobAddress alloc] init];
    address.unitNumber = @"16";
    address.streetNumber = @"5";
    address.streetName = @"Sarah";
    address.streetType = @"Close";
    address.suburb = @"Clayton South";
    address.state = @"Victoria";
    address.postCode = @"3169";
    address.country = @"Australia";
    
    NSString *expected = @"16/5 Sarah Close, Clayton South, Victoria, 3169, Australia";
    
    NSString *addrString = [GUICommon addressStringForMMJobAddress:address];
    
    DLog(@"Address string: %@", addrString);
    
    STAssertTrue([addrString isEqualToString:expected], @"Job address string not as expected");
}

- (void)testGetAddress3 {
    
    MMJobAddress *address = [[MMJobAddress alloc] init];
    address.unitNumber = nil;
    address.streetNumber = @"5";
    address.streetName = @"Sarah";
    address.streetType = nil;
    address.suburb = @"Clayton South";
    address.state = @"Victoria";
    address.postCode = nil;
    address.country = @"Australia";
    
    NSString *expected = @"5 Sarah, Clayton South, Victoria, Australia";
    
    NSString *addrString = [GUICommon addressStringForMMJobAddress:address];
    
    DLog(@"Address string: %@", addrString);
    
    STAssertTrue([addrString isEqualToString:expected], @"Job address string not as expected");
}

- (void) testGetAddress4 {
    
    MMJobAddress *address = [[MMJobAddress alloc] init];
    address.unitNumber = nil;
    address.streetNumber = @"5";
    address.streetName = @"Sarah";
    address.streetType = nil;
    
    NSString *expected = @"5 Sarah";
    
    NSString *addrString = [GUICommon addressStringForMMJobAddress:address];
    
    DLog(@"Address string: %@", addrString);
    
    STAssertTrue([addrString isEqualToString:expected], @"Job address string not as expected");
}


@end
