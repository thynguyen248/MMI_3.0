//
//  GMMapAnnotationsClient.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 30/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GMMapAnnotationsClient

-(NSArray*) findLocationOf: (NSString*) queryString;

@end
