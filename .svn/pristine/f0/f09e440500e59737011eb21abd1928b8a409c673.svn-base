//
//  GPAutocompleteResult.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 18/02/13.
//
//

#import "GPAutocompleteResult.h"

@implementation GPAutocompleteResult

static NSString* const LOCALITY_TYPE = @"locality";

@synthesize result;
@synthesize terms;
@synthesize types;

-(id) initWithData:(NSString*) initResult terms:(NSArray *)initTerms types:(NSArray *)initTypes {
    if(self = [super init]) {
        self.result = initResult;
        self.terms = initTerms;
        self.types = initTypes;
    }
    
    return self;
}

-(BOOL) isLocality {
    return [self.types containsObject:LOCALITY_TYPE];
}

@end
