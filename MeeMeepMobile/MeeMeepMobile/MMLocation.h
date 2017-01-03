//
//  MMLocation.h
//  MeeMeepMobile
//
//  Created by Julian Raff on 8/03/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MMObject.h"

@interface MMLocation : NSObject <MMObject>

@property (strong, nonatomic) NSString* address;
@property (nonatomic) bool hasCoord;
@property (nonatomic) CLLocationCoordinate2D coordinate;

+ (MMLocation *) getLocationForDictionary:(NSDictionary *) dictionary;

@end
