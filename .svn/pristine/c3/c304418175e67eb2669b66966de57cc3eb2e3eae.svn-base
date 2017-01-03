//
//  MMRestUserClient.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 1/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRestAccessToken.h"
#import "MMUserProfile.h"
#import "MMUserRating.h"
#import "MMNewUser.h"

@protocol MMRestUserClient <NSObject>

- (NSArray *) getJobsForUserWithToken:(MMRestAccessToken *) token;
- (NSArray *) getMatchingJobsForUserWithToken:(MMRestAccessToken *) token;
- (MMUserProfile *) getUserProfileForToken:(MMRestAccessToken *) token;
- (BOOL) registerUserProfile:(MMNewUser *)userProfile;
- (NSArray *) getMessagesForUserWithToken:(MMRestAccessToken *) token;
- (BOOL) sendVerifySMS:(NSString*)mobileNumber;
- (BOOL) canOfferIndemnity:(NSNumber*) userId token:(MMRestAccessToken *) token;

- (NSDictionary *) getMyMovingJobsWithAccessToken:(MMRestAccessToken *)token;
- (NSArray *) getMyPostedJobsWithAccessToken:(MMRestAccessToken *)token;

@end
