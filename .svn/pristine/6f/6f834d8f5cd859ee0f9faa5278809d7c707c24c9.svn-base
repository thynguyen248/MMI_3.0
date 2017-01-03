//
//  GMRetrieveMapAnnotationsAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 4/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "GMRetrieveMapAnnotationsAsyncActivity.h"


@implementation GMRetrieveMapAnnotationsAsyncActivity

@synthesize mapClient;
@synthesize query;


- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d forQuery:(NSString*) queryString mapClient:(id<GMMapAnnotationsClient>) client{
    self = [super initWithActivityDelegate:d];
    if (self){
        self.mapClient = client;
        self.query = queryString;
        return self;
    } else return nil;
}


- (id<MMAsyncActivityResult>) doWork {
    
    if (self.query == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Search query was nil" userInfo:nil];
    
    GMRetrieveMapAnnotationsAsyncActivityResult*
    mapAnnotationsResult = 
    [[GMRetrieveMapAnnotationsAsyncActivityResult alloc] init];
    
    NSArray* queryResults = [mapClient findLocationOf:query];
    
    mapAnnotationsResult.retrievedMapAnnotations = queryResults;
    
    
    return mapAnnotationsResult;
    
}

@end

