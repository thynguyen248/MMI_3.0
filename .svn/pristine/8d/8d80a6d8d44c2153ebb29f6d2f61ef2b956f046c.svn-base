//
//  MMRestHttpException.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRestException.h"

@interface MMRestHttpException : MMRestException {
    NSString *requestURL;
    NSString *requestMethod;
    NSDictionary *requestHeaders;
}

@property (nonatomic, strong) NSString *requestURL;
@property (nonatomic, strong) NSString *requestMethod;
@property (nonatomic, strong) NSDictionary *requestHeaders;

- (id) initWithReason:(NSString *)reason 
             userInfo:(NSDictionary *)userInfo 
      nestedException:(NSException *)nested 
       containedError:(NSError *) error 
               forUrl:(NSString *) url 
          usingMethod:(NSString *) method 
          withHeaders:(NSDictionary *) headers;

@end
