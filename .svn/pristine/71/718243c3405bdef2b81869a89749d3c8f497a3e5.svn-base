//
//  GMRetrieveMapAnnotationsAsyncActivity.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 4/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMAsyncActivity.h"
#import "GMMapAnnotationsClient.h"
#import "MMRestClient.h"

#import "GMRetrieveMapAnnotationsAsyncActivityResult.h"


@interface GMRetrieveMapAnnotationsAsyncActivity : MMAsyncActivity {
    id<MMRestClient> restClient;
    id<GMMapAnnotationsClient> mapClient;
    NSString* query;
}

@property (strong, nonatomic) id<GMMapAnnotationsClient> mapClient;
@property (strong, nonatomic) NSString* query;


- (id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d forQuery:(NSString*) queryString mapClient:(id<GMMapAnnotationsClient>) client;

@end
