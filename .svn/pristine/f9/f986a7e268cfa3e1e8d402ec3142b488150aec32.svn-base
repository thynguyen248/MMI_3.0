//
//  MMRestHttpAuthenticatedTransmission.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 8/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestHttpResponse.h"
#import "MMRestAccessToken.h"

@protocol MMRestHttpAuthorisedTransmission <NSObject>

- (MMRestHttpResponse *) authorisedMethod:(NSString *) method toUrl:(NSString *) url withRequestBody:(NSData *) requestBody additionalRequestHeaders:(NSDictionary *) requestHeaders andAccessToken:(MMRestAccessToken *) token;

@end
