//
//  GMMapAnnotationsClientImpl.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 30/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GMMapAnnotationsClient.h"
#import <CommonCrypto/CommonHMAC.h>
#import "GMMapAnnotationsSerialisationImpl.h"
#import "MMRestHttpTransmissionImpl.h"



@interface GMMapAnnotationsClientImpl : NSObject <GMMapAnnotationsClient>{
    id<GMMapAnnotationsSerialisation> serialiser;
    id<MMRestHttpTransmission> transmission;
}

@end
