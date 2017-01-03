//
//  MMRestAuthorisationClientImpl.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 6/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestAuthorisationClient.h"
#import "MMRestHttpTransmission.h"
#import "MMRestHttpAuthorisedTransmission.h"
#import "MMSerialisationFactory.h"

@interface MMRestAuthorisationClientImpl : NSObject<MMRestAuthorisationClient> {
    id<MMRestHttpTransmission> httpTransmission;
    id<MMRestHttpAuthorisedTransmission> authorisedTransmission;
    id<MMSerialisationFactory> serialisationFactory;
    
    NSString *domainUrl;
}

@property (strong, nonatomic) id<MMRestHttpTransmission> httpTransmission;
@property (strong, nonatomic) id<MMRestHttpAuthorisedTransmission> authorisedTransmission;
@property (strong, nonatomic) id<MMSerialisationFactory> serialisationFactory;
@property (strong, nonatomic) NSString *baseUrl;
@property (strong, nonatomic) NSString *loginUrl;
@property (strong, nonatomic) NSString *logoutUrl;

- (id) initWithTransmission:(id<MMRestHttpTransmission>)tx s11nFactory:(id<MMSerialisationFactory>)factory withBaseUrl:(NSString *)url relativeLoginPath:(NSString *)loginPath andRelativeLogoutPath:(NSString*)logoutPath;

@end
