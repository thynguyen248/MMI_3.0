//
//  MMMockHttpTransmissionResponseMatchingEntry.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 4/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestHttpResponse.h"

@interface MMMockHttpTransmissionResponseMatchingEntry : NSObject {
    NSDictionary *params;
    MMRestHttpResponse *response;
    NSString *url;
}

@property (strong, nonatomic) NSDictionary *params;
@property (strong, nonatomic) MMRestHttpResponse *response;
@property (strong, nonatomic) NSString *url;

- (id) initWithParams:(NSDictionary *) p forUrl:(NSString *) url withResponse:(MMRestHttpResponse *) responseData;

@end
