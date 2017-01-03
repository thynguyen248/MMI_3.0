//
//  MMRestLoginClient.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 1/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestAccessToken.h"

@protocol MMRestAuthorisationClient <NSObject>

- (MMRestAccessToken *) loginWithEmail:(NSString *) email andPassword:(NSString *) password;

- (void) logoutWith:(MMRestAccessToken *) token;

@end
