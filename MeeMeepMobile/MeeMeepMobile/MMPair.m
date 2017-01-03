//
//  MMPair.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 21/02/13.
//
//

#import "MMPair.h"

@implementation MMPair

@synthesize first;
@synthesize second;

-(id) initWithPair:(id) initFirst second:(id)initSecond {
    if(self = [super init]) {
        self.first = initFirst;
        self.second = initSecond;
    }
    
    return self;
}

@end
