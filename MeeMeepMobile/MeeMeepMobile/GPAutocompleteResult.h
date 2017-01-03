//
//  GPAutocompleteResult.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 18/02/13.
//
//

#import <Foundation/Foundation.h>

@interface GPAutocompleteResult : NSObject

-(id) initWithData:(NSString*) initResult terms:(NSArray *)initTerms types:(NSArray *)initTypes;

-(BOOL) isLocality;

@property (nonatomic, strong) NSString* result;
@property (nonatomic, strong) NSArray* terms;
@property (nonatomic, strong) NSArray* types;

@end
