//
//  MMRestHttpException.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestHttpException.h"
#import "MMRestNotImplementedException.h"

@implementation MMRestHttpException

@synthesize requestURL;
@synthesize requestMethod;
@synthesize requestHeaders;

- (id) initWithReason:(NSString *)reason 
             userInfo:(NSDictionary *)userInfo 
      nestedException:(NSException *)nested 
       containedError:(NSError *) error 
               forUrl:(NSString *) url 
          usingMethod:(NSString *) method 
          withHeaders:(NSDictionary *) headers {
    self = [super initWithName:@"MMRestHttpException" reason:reason userInfo:userInfo nestedException:nested containedError:error];
    if (self) {
        self.requestURL = url;
        self.requestMethod = method;
        self.requestHeaders = headers;
        
        return self;
    } 
    
    return nil;
}

@end
