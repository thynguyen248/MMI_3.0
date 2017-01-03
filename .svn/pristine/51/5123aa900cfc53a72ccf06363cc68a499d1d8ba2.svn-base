//
//  MMJobStatus.h
//  MeeMeepMobile
//
//  Created by Julian Raff on 1/03/13.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    JOB_CREATED,
    BID_ACCEPTED,
    JOB_EXPIRED,
    JOB_CANCELLED,
    AWAITING_CUSTOMER_COMPLETION,
    COMPLETED,
    CLOSED,
    DISPUTED
} JobStatus;

@interface MMJobStatus : NSObject

@property JobStatus status;
@property (strong, nonatomic) NSString* statusString;
@property (strong, nonatomic) NSString* displayableString;

-(id) initWithString:(NSString*)statusStr displayableString:(NSString*)displayableStr andEnum:(JobStatus)jobStat;

+(MMJobStatus*) statusFromString:(NSString*)statusString;
+(MMJobStatus*) statusFromEnum:(JobStatus)status;

-(Boolean) compareTo:(MMJobStatus*)otherStatus;

-(Boolean) is:(JobStatus)status;

@end
