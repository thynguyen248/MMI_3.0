//
//  MMMesageClient.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 4/04/13.
//
//

#import <Foundation/Foundation.h>
#import "MMMessageDetail.h"
#import "MMRestAccessToken.h"

@protocol MMRestMessageClient <NSObject>

- (BOOL) sendMessage:(MMMessageDetail *) message withAccessToken:(MMRestAccessToken *) token;

@end
