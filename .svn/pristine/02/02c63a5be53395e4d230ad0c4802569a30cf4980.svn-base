//
//  MMLocation.m
//  MeeMeepMobile
//
//  Created by Julian Raff on 8/03/13.
//
//

#import "MMLocation.h"
#import "MMSerialisationUtils.h"

@implementation MMLocation

+ (MMLocation *) getLocationForDictionary:(NSDictionary *) dictionary {
    if(dictionary == nil)
    {
        return nil;
    }
    
    MMLocation* location = [[MMLocation alloc] init];
    
    location.address = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"address"]];

    // Coords
    id lat = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"lat"]];
    id lng = [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"lng"]];
    
    bool hasCoord = (lat && lng);
    location.hasCoord = hasCoord;
    if(hasCoord)
    {
        location.coordinate = CLLocationCoordinate2DMake([lat floatValue], [lng floatValue]);
    }
    
    return location;
}

@end
