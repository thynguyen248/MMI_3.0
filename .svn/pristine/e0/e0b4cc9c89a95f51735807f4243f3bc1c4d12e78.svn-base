//
//  MMJobAddress.m
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMJobAddress.h"
#import "MMSerialisationUtils.h"

@implementation MMJobAddress 

@synthesize country;
@synthesize latitude;
@synthesize longitude;
@synthesize postCode;
@synthesize state;
@synthesize streetName;
@synthesize streetNumber;
@synthesize streetType;
@synthesize suburb;
@synthesize unitNumber;

+ (MMJobAddress *) getAddressForDictionary:(NSDictionary *) dictionary {
    if (dictionary == nil) return nil;
    
    MMJobAddress *address = [[MMJobAddress alloc] init];
    address.state       =   [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"State"]];
    address.country     =   [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"Country"]];
    address.latitude    =   [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"Latitude"]];
    address.longitude   =   [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"Longitude"]];
    address.postCode    =   [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"PostCode"]];
    address.streetName  =   [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"StreetName"]];
    address.streetNumber =  [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"StreetNumber"]];
    address.streetType  =   [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"StreetType"]];
    address.unitNumber  =   [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"UnitNumber"]];
    address.suburb      =   [MMSerialisationUtils nilIfNSNull:[dictionary objectForKey:@"Suburb"]];
    
    return address;    
}

+ (NSDictionary *) getDictionaryForAddress:(MMJobAddress *) address {
    if (address == nil) return nil;
    
    NSDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:address.state] forKey:@"State"];
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:address.country] forKey:@"Country"];
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:address.latitude] forKey:@"Latitude"];
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:address.longitude] forKey:@"Longitude"];
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:address.postCode] forKey:@"PostCode"];
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:address.streetName] forKey:@"StreetName"];
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:address.streetNumber] forKey:@"StreetNumber"];
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:address.streetType] forKey:@"StreetType"];
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:address.unitNumber] forKey:@"UnitNumber"];
    [dictionary setValue:[MMSerialisationUtils nsNullForNil:address.suburb] forKey:@"Suburb"];
    
    return dictionary;
}


@end
