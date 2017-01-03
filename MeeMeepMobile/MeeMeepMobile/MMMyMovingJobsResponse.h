//
//  MMMyMovingJobsResponse.h
//  MeeMeepMobile
//
//  Created by Julian Raff on 15/03/13.
//
//

#import <Foundation/Foundation.h>

#import "MMObject.h"

@interface MMMyMovingJobsResponse : NSObject <MMObject> 

@property (strong, nonatomic) NSMutableDictionary *jobs;

@end
