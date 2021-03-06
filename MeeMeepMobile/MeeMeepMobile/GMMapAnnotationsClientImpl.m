//
//  GMMapAnnotationsClientImpl.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 30/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "GMMapAnnotationsClientImpl.h"

#import "GUICommon.h"



#define mapsUrl @"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false&region=au"



@implementation GMMapAnnotationsClientImpl




-(id) init{
    self = [super init];
    
    if (self){
        serialiser = [[GMMapAnnotationsSerialisationImpl alloc] init];
    }
    
    return self;
}



//Retrieves data from url
-(NSData*) getUrl: (NSString*) address{
    NSURL *url = [NSURL URLWithString: address];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
   
    NSError* error;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];

    return response;
}







//
-(NSArray*) findLocationOf: (NSString*) queryString{
    
    queryString = [queryString stringByAppendingString:@" Australia"];
    
    NSString* encodedQueryString = [GUICommon urlEncodeString:queryString];

    NSString* urlString = [NSString stringWithFormat: mapsUrl, encodedQueryString];
    
    
    DLog(@"FIND LOCATION: %@", urlString);

    NSData* jsonData;
    jsonData = [self getUrl:urlString];
    
    
    NSArray* annotations;
    annotations = [serialiser generateAnnotationsUsing:jsonData];
    
    DLog(@"annotations count: %d", [annotations count]);
    
    return annotations;
    
}

@end
