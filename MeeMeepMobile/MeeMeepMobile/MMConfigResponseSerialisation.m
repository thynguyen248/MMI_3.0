//
//  MMConfigResponseSerialisation.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 20/02/13.
//
//

#import "MMConfigResponseSerialisation.h"
#import "MMConfig.h"
#import "MMRestNotImplementedException.h"
#import "MMSerialisationUtils.h"
#import "MMRestDeserialisationException.h"

@implementation MMConfigResponseSerialisation

- (id<MMObject>) deserialiseData:(NSData*) data {
    @try {
        NSDictionary *config = [MMSerialisationUtils deserialiseData:data];
        id obj = [config objectForKey:@"data"];

        MMConfig *response = [[MMConfig alloc] init];
        
        //This indicates that there is no data change
        if([[obj class] isSubclassOfClass:[NSString class]]) {
            response.changed = FALSE;
        } else {
            response.changed = TRUE;
            response.configuration = obj;
        }
        
        return response;
    } @catch (NSException *anyEx) {
        MMRestDeserialisationException *dex = [[MMRestDeserialisationException alloc] initWithReason:@"Could not deserialise config response object" userInfo:nil nestedException:anyEx containedError:nil serialisedData:nil];
        
        @throw dex;
    }
}

- (NSData*) serialise:(id <MMObject>) object {
    MMRestNotImplementedException *nex = [[MMRestNotImplementedException alloc] initWithReason:@"Serialisation function not implemented for Config Response" userInfo:nil];
    
    @throw nex;
}

@end
