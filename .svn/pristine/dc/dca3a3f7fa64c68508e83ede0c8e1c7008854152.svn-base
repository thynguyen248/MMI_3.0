//
//  MMLogicUnitTestSupportingDataUtils.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 7/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMLogicUnitTestSupportingDataUtils.h"

@implementation MMLogicUnitTestSupportingDataUtils

@synthesize dataSetDictionary;

- (id) init {
    self = [super init];
    if (self) {
        self.dataSetDictionary = [[NSMutableDictionary alloc] init];
                
        return self;
    }
    
    return nil;
}

- (NSString *) getResponseStringForKey:(NSString *) key {
    return [dataSetDictionary valueForKey:key];
}

- (void) putResponseString:(NSString *) responseString forKey:(NSString *) key {
    [dataSetDictionary setValue:responseString forKey:key];
}

- (void) addLoginCookie:(NSString *) domain path:(NSString *)path {
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    NSMutableDictionary* cookieProperties = [[NSMutableDictionary alloc] init];
    [cookieProperties setObject:@"JSESSIONID" forKey:NSHTTPCookieName];
    [cookieProperties setObject:@"SomeValue" forKey:NSHTTPCookieValue];
    [cookieProperties setObject:domain forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:domain forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:path forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    
    [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
    
    NSHTTPCookie* cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
}

@end
