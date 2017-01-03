//
//  GMMapAnnotation.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 1/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <MapKit/MapKit.h>

#import "MMJobAddress.h"

@interface GMMapAnnotation : MKPointAnnotation{
    MMJobAddress* jobAddress;
}

@property (nonatomic,strong) MMJobAddress* jobAddress;

@end
