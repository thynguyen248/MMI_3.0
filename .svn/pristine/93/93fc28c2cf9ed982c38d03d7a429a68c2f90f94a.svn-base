//
//  MMJobsSerialisationFactoryImpl.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMSerialisationFactoryImpl.h"
#import "MMSerialisationDateHelperImpl.h"

@interface MMSerialisationFactoryImpl (Privates)
    -(id<MMSerialisationDateHelper>) createJobDateSerialisation;
    -(id<MMSerialisationDateHelper>) createDateSerialisation:(NSString*) format;
@end

@implementation MMSerialisationFactoryImpl

@synthesize dateSerialisation;

- (MMRecentJobSummaryResponseSerialisation *) getMMRecentJobSummaryResponseSerialisation {
    
    MMRecentJobSummaryResponseSerialisation *serialisation
        = [[MMRecentJobSummaryResponseSerialisation alloc] initWithDateHelper:self.dateSerialisation];
    
    return serialisation;
}

- (MMInitialResponseSerialisation *) getMMInitialResponseSerialisation {
    
    MMInitialResponseSerialisation *serialisation 
        = [[MMInitialResponseSerialisation alloc] init];
    
    return serialisation;
}

- (MMJobDetailResponseSerialisation *) getMMJobDetailResponseSerialisation {
    
    MMJobDetailResponseSerialisation *serialisation
        = [[MMJobDetailResponseSerialisation alloc] initWithDateHelper:self.dateSerialisation];
    
    return serialisation;
}

- (MMBidSummaryResponseSerialisation *) getMMBidSummaryResponseSerialisation {
    
    MMBidSummaryResponseSerialisation *serialisation
        = [[MMBidSummaryResponseSerialisation alloc] initWithDateS11nHelper:self.dateSerialisation];
    
    return serialisation;
}

- (MMBidDetailResponseSerialisation *) getMMBidDetailResponseSerialisation {
    MMBidDetailResponseSerialisation *serialisation
    = [[MMBidDetailResponseSerialisation alloc] initWithDateHelper:self.dateSerialisation];
    
    return serialisation;
}

- (MMLoginResponseSerialisation *) getMMLoginResponseSerialisation {
    MMLoginResponseSerialisation *serialisation
    = [[MMLoginResponseSerialisation alloc] init];
    
    return serialisation;
}

- (MMBidAcceptRequestSerialisation *) getMMBidAcceptRequestSerialisation {
    MMBidAcceptRequestSerialisation *serialisation 
    = [[MMBidAcceptRequestSerialisation alloc] initWithDateHelper:self.dateSerialisation];
    
    return serialisation;
    
}

- (MMJobCreationRequestSerialisation *) getMMJobCreationRequestSerialisation {
    MMJobCreationRequestSerialisation *serialisation 
    = [[MMJobCreationRequestSerialisation alloc] initWithDateS11nHelper:[self createJobDateSerialisation]];
    
    return serialisation;
}

- (MMRestErrorSerialisation *) getMMRestErrorSerialisation {
    MMRestErrorSerialisation *serialisation = [[MMRestErrorSerialisation alloc] init];
    return serialisation;
}

- (MMUserProfileResponseSerialisation *) getMMUserProfileResponseSerialisation {
    MMUserProfileResponseSerialisation *upS11n = [[MMUserProfileResponseSerialisation alloc] init];
    
    return upS11n;
}

- (MMBidCreationRequestSerialisation *) getMMBidCreationRequestSerialisation {
    MMBidCreationRequestSerialisation *bidCS11n = [[MMBidCreationRequestSerialisation alloc] initWithDateS11nHelper:[self createDateSerialisation:@"dd/MM/yyyy"]];
    
    return bidCS11n;
}

- (MMCompleteJobRequestSerialisation *) getMMCompleteJobRequestSerialisation {
    MMCompleteJobRequestSerialisation *userRatingS11n = [[MMCompleteJobRequestSerialisation alloc] init];
    return userRatingS11n;
}

- (MMRegistrationRequestSerialisation *) getMMRegistrationRequestSerialisation {
    return [[MMRegistrationRequestSerialisation alloc] init];
}

- (MMMessageDetailListResponseSerialisation *) getMMMessageDetailListResponseSerialisation {
    MMMessageDetailListResponseSerialisation *s11n = [[MMMessageDetailListResponseSerialisation alloc] initWithDateHelper:self.dateSerialisation];
    return s11n;
}

- (MMCreateMessageRequestSerialization *) getMMCreateMessageRequestSerialization {
    return[[MMCreateMessageRequestSerialization alloc] init];
}

- (MMConfigResponseSerialisation *) getMMConfigResponseSerialisation {
    return [[MMConfigResponseSerialisation alloc] init];
}

- (MMMyMovingJobsResponseSerialisation *) getMMMyMovingJobResponseSerialisation {
    return [[MMMyMovingJobsResponseSerialisation alloc] init];
}

- (MMCanOfferIndemnityResponseSerialisation *) getMMCanOfferIndemnityResponseSerialisation {
    return [[MMCanOfferIndemnityResponseSerialisation alloc] init];
}


- (id) initWithS11nDateHelper:(id<MMSerialisationDateHelper>) dateSerialisationHelper {
    self = [super init];
    if (self) {
        self.dateSerialisation = dateSerialisationHelper;
        return self;
    }
    
    return nil;
}

- (id) init {
    self = [super init];
    if (self) {
        NSLocale *locale = [NSLocale currentLocale];
        NSString *inDateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSSZZZ";
        // need to be changed to out format
        NSTimeZone *tz = [NSTimeZone systemTimeZone];
        
        NSDateFormatter *formatterIn = [[NSDateFormatter alloc] init];
        [formatterIn setLocale:locale];
        [formatterIn setDateFormat:inDateFormat];
        [formatterIn setTimeZone:tz];
        
        NSString *toStringDateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSSZZZ";
        NSDateFormatter *formatterOut = [[NSDateFormatter alloc] init];
        [formatterOut setLocale:locale];
        [formatterOut setDateFormat:toStringDateFormat];
        [formatterOut setTimeZone:tz];
        
        self.dateSerialisation = [[MMSerialisationDateHelperImpl alloc] initWithDateFormatterToString:formatterOut toDate:formatterIn];
        
        return self;
    }
    
    return nil;
}

-(id<MMSerialisationDateHelper>) createJobDateSerialisation {
    return [self createDateSerialisation:@"dd/MM/yyyy"];
}

-(id<MMSerialisationDateHelper>) createDateSerialisation:(NSString *) format {
    NSLocale *locale = [NSLocale currentLocale];
    // need to be changed to out format
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    
    NSDateFormatter *formatterIn = [[NSDateFormatter alloc] init];
    [formatterIn setLocale:locale];
    [formatterIn setDateFormat:format];
    [formatterIn setTimeZone:tz];
    
    NSDateFormatter *formatterOut = [[NSDateFormatter alloc] init];
    [formatterOut setLocale:locale];
    [formatterOut setDateFormat:format];
    [formatterOut setTimeZone:tz];
    
    return[[MMSerialisationDateHelperImpl alloc] initWithDateFormatterToString:formatterOut toDate:formatterIn];
}

@end
