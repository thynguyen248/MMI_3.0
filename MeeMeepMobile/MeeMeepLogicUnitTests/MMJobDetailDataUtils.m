//
//  MMJobDetailDataUtils.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 2/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMJobDetailDataUtils.h"
#import "MMSerialisationFactory.h"
#import "MMSerialisationFactoryImpl.h"
#import "MMJobDetailResponse.h"
#import "MMJobDetailResponseSerialisation.h"
#import "MMJobDetail.h"
#import "MMSerialisationDateHelper.h"
#import "MMSerialisationDateHelperImpl.h"

@implementation MMJobDetailDataUtils

+ (MMJobDetail *) getJobDetailToCreateForUserWithName:(NSString *) username userId:(NSNumber *) userId {
    
    NSDate *futureDate = [NSDate dateWithTimeIntervalSinceNow:20000];
    
    NSDateFormatter *dateToStringFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_AU"];
    NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:11*60*60];
    [dateToStringFormatter setTimeZone:zone];
    [dateToStringFormatter setLocale:locale];
    NSString *rfc822Format = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSSZZZ";
    [dateToStringFormatter setDateFormat:rfc822Format];
    
    NSString *futureDateString = [dateToStringFormatter stringFromDate:futureDate];
    
    NSInteger uId = (userId) ? [userId intValue] : 519;
    NSString *uName = (username) ? username : @"unico";
    
    NSString *jobDetailStringFormat = @"{\"success\":true,\"job\":{\"acceptedBid\":null,\"dateCreated\":\"2013-02-27T21:07:50Z\",\"jobCategoryId\":20,\"deliveryDateEnd\":\"2013-03-02T21:07:50Z\",\"status\":\"JOB_CREATED\",\"lastUpdated\":\"2013-02-27T21:07:52Z\",\"affiliateId\":33,\"jobCategory\":{\"class\":\"com.meemeep.portal.JobCategory\",\"id\":20,\"lastUpdated\":\"%@\",\"name\":\"Box\"},\"pickupAddress\":null,\"deliveryAddress\":null,\"deliveryDateStart\":\"%@\",\"fromLng\":null,\"toLat\":null,\"auctionWon\":false,\"items\":[{\"dateCreated\":\"%@\",\"jobId\":114,\"width\":5,\"weight\":5,\"height\":5,\"imageId\":null,\"lastUpdated\":\"%@\",\"description\":\"Table\",\"length\":5,\"weightUnit\":null,\"id\":45},{\"weight\":2,\"jobId\":114,\"width\":5,\"imageId\":null,\"dateCreated\":\"%@\",\"description\":\"Chair\",\"lastUpdated\":\"%@\",\"height\":15,\"length\":5,\"weightUnit\":null,\"id\":46}],\"affiliateJobId\":\"123ABC\",\"title\":\"I need to move a bunch of my stuff!\",\"deliveryTime\":null,\"pickupDateEnd\":\"%@\",\"indemnityId\":null,\"toLng\":null,\"user\":{\"transportProvider\":false,\"displayName\":\"%@\",\"id\":%d},\"pickupTime\":null,\"affiliate\":{\"class\":\"com.meemeep.portal.Affiliate\",\"id\":33,\"lastUpdated\":\"2013-02-27T21:07:26Z\",\"name\":\"GraysOnline\"},\"bidding\":false,\"totalMessageCount\":1,\"fromLat\":null,\"indemnity\":null,\"distance\":null,\"toLocation\":{\"class\":\"com.meemeep.portal.Location\",\"id\":45,\"address\":\"Brunswick West, VIC\",\"lat\":-37.763542,\"lng\":144.943924},\"pickupDateStart\":\"2013-02-27T21:07:50Z\",\"acceptedBidId\":null,\"specialConsiderations\":[{\"class\":\"com.meemeep.portal.SpecialConsideration\",\"id\":25,\"description\":\"Limited access\",\"lastUpdated\":\"2013-02-27T21:07:25Z\"},{\"class\":\"com.meemeep.portal.SpecialConsideration\",\"id\":26,\"description\":\"Tailgate lifter required\",\"lastUpdated\":\"2013-02-27T21:07:25Z\"},{\"class\":\"com.meemeep.portal.SpecialConsideration\",\"id\":23,\"description\":\"Forklift already onsite\",\"lastUpdated\":\"2013-02-27T21:07:25Z\"},{\"class\":\"com.meemeep.portal.SpecialConsideration\",\"id\":24,\"description\":\"Forklift required onsite\",\"lastUpdated\":\"2013-02-27T21:07:25Z\"}],\"fromLocation\":{\"class\":\"com.meemeep.portal.Location\",\"id\":46,\"address\":\"South Melbourne, VIC\",\"lat\":-37.8323792,\"lng\":144.9604333},\"id\":114}}";
    
    NSString *jobDetailString = [NSString stringWithFormat:jobDetailStringFormat, futureDateString, futureDateString, futureDateString, futureDateString, futureDateString, futureDateString, futureDateString, uName, uId];
    
    NSData *jobDetailData = [jobDetailString dataUsingEncoding:NSUTF8StringEncoding];
    
    id<MMSerialisationFactory> s11nFactory = [[MMSerialisationFactoryImpl alloc] init];
    
    MMJobDetailResponseSerialisation *responseS11n = [s11nFactory getMMJobDetailResponseSerialisation];
    
    MMJobDetailResponse *response = [responseS11n deserialiseData:jobDetailData];
    
    MMJobDetail *detail = response.jobDetail;
    
    return detail;
}

@end
