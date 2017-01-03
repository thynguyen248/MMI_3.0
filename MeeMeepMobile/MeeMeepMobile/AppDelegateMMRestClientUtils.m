//
//  AppDelegateMMRestClientUtils.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegateMMRestClientUtils.h"

@implementation AppDelegateMMRestClientUtils

- (id) init {
    self = [super init];
    return (self) ? self : nil;
} 

+ (NSDictionary *) getMMRestConfiguration {
    NSBundle *thisClassBundle = [NSBundle bundleForClass:[self class]];
    NSString *pathToMMRestConf = [thisClassBundle pathForResource:@"mm-rest-conf" ofType:@"plist"];
    if (pathToMMRestConf) {
        NSDictionary *restConf = [NSDictionary dictionaryWithContentsOfFile:pathToMMRestConf];
        return restConf; 
    } else {
        return nil;
    }
}

@end
