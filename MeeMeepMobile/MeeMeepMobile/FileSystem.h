//
//  FileSystem.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 10/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestAccessToken.h"

@protocol FileSystem <NSObject>



-(BOOL) saveAccessToken: (MMRestAccessToken*) accessToken;


-(MMRestAccessToken*) loadAccessToken;

-(void) deleteAccessToken;

- (NSString *) pathForDataFile;

@end
