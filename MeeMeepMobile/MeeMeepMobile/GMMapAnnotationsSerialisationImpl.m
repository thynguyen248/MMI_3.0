//
//  GMMapAnnotationsSerialisationImpl.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 30/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "GMMapAnnotationsSerialisationImpl.h"

@implementation GMMapAnnotationsSerialisationImpl


//Serializes JSON search data into an array of foundation objects
-(NSDictionary*) makeFoundationObjectUsing: (NSData*) jsonData{
    NSError* error;
    NSDictionary* JSON = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONWritingPrettyPrinted error:&error];
    if (error) NSLog(@"MakeFoundationObjectUsing  - %@",[error description]);
    return JSON;
}




//Map the values of a foundationObject to a dictionary
-(NSDictionary*) mapFoundationObjectValues: (NSDictionary*) item{
    
    NSMutableDictionary* addressInfo = [[NSMutableDictionary alloc] init];

    //Extract title
    [addressInfo setValue:[item objectForKey:@"formatted_address"] forKey:@"title"];
        
    //Extract required fields from addressComponents (if they exist)
    NSArray* addressComponents = [item objectForKey:@"address_components"];
    for (NSDictionary* dataSet in addressComponents){
        NSArray* dataTypes = [dataSet objectForKey:@"types"];
        if([dataTypes count] == 0) {
            continue;
        }
        
        NSString* dataType = [dataTypes objectAtIndex:0];
        if ([dataType isEqualToString:@"street_number"]) {
            [addressInfo setValue:[dataSet objectForKey:@"long_name"] forKey:@"streetNumber"];
        } else if ([dataType isEqualToString:@"route"]) {
            [addressInfo setValue:[dataSet objectForKey:@"long_name"] forKey:@"streetName"];
        } else if ([dataType isEqualToString:@"locality"]) {
            [addressInfo setValue:[dataSet objectForKey:@"short_name"] forKey:@"suburb"];
        } else if ([dataType isEqualToString:@"administrative_area_level_1"]) {
            [addressInfo setValue:[dataSet objectForKey:@"short_name"] forKey:@"state"];
        } else if ([dataType isEqualToString:@"country"]) {
            [addressInfo setValue:[dataSet objectForKey:@"long_name"] forKey:@"country"];
        } else if ([dataType isEqualToString:@"postal_code"]) {
            [addressInfo setValue:[dataSet objectForKey:@"short_name"] forKey:@"postCode"];
        }
    }
        
    //Get latitude and longitude
    NSDictionary* mapGeometry = [item objectForKey:@"geometry"];
    NSDictionary* location = [mapGeometry objectForKey:@"location"];
    [addressInfo setValue:[location objectForKey:@"lat"] forKey:@"latitude"];
    [addressInfo setValue:[location objectForKey:@"lng"] forKey:@"longitude"];
        
    return addressInfo;
}



//Map dictionary details to an address object
-(GMMapAnnotation*) mapDictionaryToAnnotation: (NSDictionary*) addressInfo{      
    if ([addressInfo count]==9){
        //Map dictionary to object and place in array (if required fields are present)
        GMMapAnnotation* place = [[GMMapAnnotation alloc] init];
        place.title = [addressInfo objectForKey:@"title"];
            
        [place.jobAddress setStreetNumber:[addressInfo objectForKey:@"streetNumber"]]; 
        place.jobAddress.streetName = [addressInfo objectForKey:@"streetName"]; 
        place.jobAddress.suburb = [addressInfo objectForKey:@"suburb"]; 
        place.jobAddress.state = [addressInfo objectForKey:@"state"];
        place.jobAddress.country = [addressInfo objectForKey:@"country"]; 
        place.jobAddress.postCode = [addressInfo objectForKey:@"postCode"];
        double latitude = [[addressInfo objectForKey:@"latitude"] doubleValue];
        double longitude = [[addressInfo objectForKey:@"longitude"] doubleValue];
            
        place.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        
        if (![place.jobAddress.country isEqualToString:@"Australia"]) return nil;
        
        return place;
    } else return nil; //Not a valid STREET address, return nothing
}





//Extracts annotation data from a foundation object
-(NSArray*) generateAnnotationsUsing: (NSData*) jsonData{
    
    NSDictionary* foundationObject = [self makeFoundationObjectUsing:jsonData];
    
    NSMutableArray* sug;
    
    sug = [[NSMutableArray alloc] init];
    
    NSDictionary* addressInfo;
    GMMapAnnotation* place;
    
    NSArray* results =  [foundationObject objectForKey:@"results"];
    
    
    for (NSDictionary* resultItem in results) {
            addressInfo = [self mapFoundationObjectValues: resultItem];
        NSLog(@"addressInfo: %@",addressInfo);
            place = [self mapDictionaryToAnnotation:addressInfo];
            
            if (place!=nil) [sug addObject:place];
    }
    
    return sug;
}



@end
