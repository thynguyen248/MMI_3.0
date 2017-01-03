//
//  MMJobsSerialisationFactory.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMRecentJobSummaryResponseSerialisation.h"
#import "MMInitialResponseSerialisation.h"
#import "MMJobDetailResponseSerialisation.h"
#import "MMBidSummaryResponseSerialisation.h"
#import "MMBidDetailResponseSerialisation.h"
#import "MMLoginResponseSerialisation.h"
#import "MMBidAcceptRequestSerialisation.h"
#import "MMJobCreationRequestSerialisation.h"
#import "MMUserProfileResponseSerialisation.h"
#import "MMRestErrorSerialisation.h"
#import "MMBidCreationRequestSerialisation.h"
#import "MMCompleteJobRequestSerialisation.h"
#import "MMRegistrationRequestSerialisation.h"
#import "MMMessageDetailListResponseSerialisation.h"
#import "MMCreateMessageRequestSerialization.h"
#import "MMConfigResponseSerialisation.h"
#import "MMMyMovingJobsResponseSerialisation.h"
#import "MMCanOfferIndemnityResponseSerialisation.h"

@protocol MMSerialisationFactory <NSObject>

- (MMRecentJobSummaryResponseSerialisation *) getMMRecentJobSummaryResponseSerialisation;
- (MMInitialResponseSerialisation *) getMMInitialResponseSerialisation;
- (MMJobDetailResponseSerialisation *) getMMJobDetailResponseSerialisation;
- (MMBidSummaryResponseSerialisation *) getMMBidSummaryResponseSerialisation;
- (MMBidDetailResponseSerialisation *) getMMBidDetailResponseSerialisation;
- (MMLoginResponseSerialisation *) getMMLoginResponseSerialisation;
- (MMBidAcceptRequestSerialisation *) getMMBidAcceptRequestSerialisation;
- (MMJobCreationRequestSerialisation *) getMMJobCreationRequestSerialisation;
- (MMRestErrorSerialisation *) getMMRestErrorSerialisation;
- (MMUserProfileResponseSerialisation *) getMMUserProfileResponseSerialisation;
- (MMBidCreationRequestSerialisation *) getMMBidCreationRequestSerialisation;
- (MMCompleteJobRequestSerialisation *) getMMCompleteJobRequestSerialisation;
- (MMRegistrationRequestSerialisation *) getMMRegistrationRequestSerialisation;
- (MMMessageDetailListResponseSerialisation *) getMMMessageDetailListResponseSerialisation;
- (MMCreateMessageRequestSerialization *) getMMCreateMessageRequestSerialization;
- (MMConfigResponseSerialisation *) getMMConfigResponseSerialisation;
- (MMMyMovingJobsResponseSerialisation *) getMMMyMovingJobResponseSerialisation;
- (MMCanOfferIndemnityResponseSerialisation *) getMMCanOfferIndemnityResponseSerialisation;

@end
