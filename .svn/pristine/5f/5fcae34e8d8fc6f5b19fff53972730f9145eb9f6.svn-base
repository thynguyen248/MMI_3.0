//
//  GPRetrieveAsyncActivity.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 14/02/13.
//
//

#import "GPRetrieveAsyncActivity.h"
#import "GPRetrieveAsynActivityResult.h"

@implementation GPRetrieveAsyncActivity

@synthesize client;
@synthesize location;

-(id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d location:(NSString*) initLocation
                        client:(GPClient *) initClient {
    if(self = [super initWithActivityDelegate:d]) {
        self.client = initClient;
        self.location = initLocation;
    }
    
    return self;
}

- (id<MMAsyncActivityResult>) doWork {
    if (self.location == nil) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Search location was nil" userInfo:nil];
    
    GPRetrieveAsynActivityResult* result = [[GPRetrieveAsynActivityResult alloc] init];
    
    NSArray* queryResults = [client find:location];
    
    result.results = queryResults;
        
    return result;
}

@end
