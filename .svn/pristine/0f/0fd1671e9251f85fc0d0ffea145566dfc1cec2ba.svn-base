//
//  MMCanOfferIndemnityResponseSerialisation.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 22/04/13.
//
//

#import "MMCanOfferIndemnityResponseSerialisation.h"
#import "MMCanOfferIndemnityResponse.h"
#import "MMSerialisationUtils.h"
#import "MMRestDeserialisationException.h"
#import "MMRestNotImplementedException.h"

@implementation MMCanOfferIndemnityResponseSerialisation

- (id<MMObject>) deserialiseData:(NSData*) data {
    @try {
        NSDictionary *responseDict = [MMSerialisationUtils deserialiseData:data];

        MMCanOfferIndemnityResponse* resp = [[MMCanOfferIndemnityResponse alloc] init];
        NSNumber* canOfferValue = (NSNumber*)[MMSerialisationUtils nilIfNSNull:[responseDict objectForKey:@"canOfferIndemnity"]];
        if(canOfferValue == nil) {
            resp.userExists = FALSE;
            resp.canOffer = FALSE;
        } else {
            resp.userExists = TRUE;
            resp.canOffer =  [canOfferValue boolValue];
        }

        return resp;        
    } @catch (NSException *anyEx) {
        MMRestDeserialisationException *desex = [[MMRestDeserialisationException alloc] initWithReason:@"Could not deserialise can offer indemnity response" userInfo:nil nestedException:anyEx containedError:nil];
        @throw desex;
    }
}

- (NSData*) serialise:(id <MMObject>) object {
    MMRestNotImplementedException *nex = [[MMRestNotImplementedException alloc] initWithReason:@"Serialisation not implemented!" userInfo:nil];
    
    @throw nex;
}

@end
