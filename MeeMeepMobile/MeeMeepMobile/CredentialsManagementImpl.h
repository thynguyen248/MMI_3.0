//
//  CredentialsManagementImpl.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CredentialsManagement.h"

@interface CredentialsManagementImpl : NSObject<CredentialsManagement> {
    NSString *filePath;
}

@property (strong, nonatomic) NSString *filePath;

- (id) initWithPath:(NSString *) path;

@end
