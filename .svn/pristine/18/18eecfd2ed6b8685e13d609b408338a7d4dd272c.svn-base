//
//  GPClient.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 14/02/13.
//
//

#import "GPClient.h"
#import "GPAutocompleteResult.h"

@interface GPClient (Privates)
-(NSString *) constructURL:(NSString *)location;
-(NSArray *) extractData:(NSData *) data;
@end

@implementation GPClient

NSString* const BASE_URL = @"https://maps.googleapis.com/maps/api/place/autocomplete/";
NSString* const FORMAT = @"json";
NSString* const TYPE = @"(cities)"; //@"(regions)";
NSString* const SENSOR = @"false";
NSString* const KEY = @"AIzaSyB_bsptfrmpD1E7ETcY8DpnWL44oa72TXY";
NSString* const COMPONENTS = @"country:au";

-(NSArray*) find:(NSString*) location {
    NSLog(@">> getLocationForAddress: %@", location);
    
    NSString *urlAsString = [self constructURL:location];
    
    //NSString *urlAsString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@", location];
    
    NSLog(@"Sending request to %@", urlAsString);
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSError* error;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
    return [self extractData:response];
}

-(NSString *) constructURL:(NSString *)location {
    NSString* urlString =  [NSString stringWithFormat:@"%@%@?input=%@&types=%@&sensor=%@&key=%@&components=%@", BASE_URL, FORMAT, location, TYPE, SENSOR, KEY, COMPONENTS];
    
    return [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(NSArray *) extractData:(NSData *) data {
    NSLog(@">> connection:didReceiveData");
    
    NSDictionary *tljson = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: nil];
    
    NSArray *predictions = [tljson objectForKey:@"predictions"];
    
    NSMutableArray *locations = [[NSMutableArray alloc] initWithCapacity:5];
    //NSString *response = @"";
    
    for(id prediction in predictions) {
        NSString* description = [prediction objectForKey:@"description"];
        
        NSArray* termsData = [prediction objectForKey:@"terms"];
        NSMutableArray* terms = [[NSMutableArray alloc] initWithCapacity:[termsData count]];

        for(NSDictionary* termsDict in termsData) {
            [terms addObject:[termsDict objectForKey:@"value"]];
        }
        
        NSArray* types = [prediction objectForKey:@"types"];
                
        GPAutocompleteResult* result = [[GPAutocompleteResult alloc] initWithData:description
                                                                            terms:terms
                                                                            types:types];
        
        [locations addObject:result];
    }
    
    return locations;
}

@end