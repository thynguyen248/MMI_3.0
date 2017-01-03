//
//  MMRestHttpTransmission.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestHttpResponse.h"

@protocol MMRestHttpTransmission <NSObject>

- (MMRestHttpResponse *) httpGET:(NSString *) url 
                withBody:(NSData *) requestBody 
                withHeaderParams:(NSDictionary *) params;

- (MMRestHttpResponse *) httpPUT:(NSString *) url 
                withBody:(NSData *) requestBody 
                withHeaderParams:(NSDictionary *) params;

- (MMRestHttpResponse *) httpPOST:(NSString *) url 
                withBody:(NSData *) requestBody 
                withHeaderParams:(NSDictionary *) params;

@end
