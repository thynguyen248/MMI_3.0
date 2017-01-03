//
//  MMNamedJobSearchRequest.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMNamedJobSearchRequest : NSObject {
    NSString *searchName;
    NSDictionary *searchParameters;
}

@property (strong, nonatomic) NSString *searchName;
@property (strong, nonatomic) NSDictionary *searchParameters;

- (id) initWithName:(NSString *) sName forParameters:(NSDictionary *) searchParams;

@end
