//
//  MMLogicUnitTestSupportingDataUtils.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 7/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMLogicUnitTestSupportingDataUtils : NSObject {
    NSMutableDictionary *dataSetDictionary;
}

@property (strong, nonatomic) NSMutableDictionary *dataSetDictionary;

- (NSString *) getResponseStringForKey:(NSString *) key;
- (void) putResponseString:(NSString *) responseString forKey:(NSString *) key;
- (void) addLoginCookie:(NSString *) domain path:(NSString *)path;

@end
