//
//  GradientButtonControl.m
//
//  Created by Aydan Bedingham on 16/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "GradientButtonControl.h"


@implementation GradientButtonControl

@synthesize attributes;


-(NSArray*) getGradientColorForControlState: (UIControlState) state{
    for (NSNumber* key in stateColorMappings) {
        if ([key unsignedIntValue]==state)
            return [stateColorMappings objectForKey:key];
    }
    return nil;
}


-(void) eventOccured{
    //Create a new gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    
    //Set layer attributes
    [self.layer setCornerRadius:8];
    //[self.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
    //[self.layer setShadowOpacity:0.5];
    //[self.layer setShadowOffset:CGSizeMake(1, 1)];
    
    [gradient setCornerRadius:self.layer.cornerRadius];
    
    //Get gradientColor for state
    UIControlState state = self.state;
    gradient.colors = [self getGradientColorForControlState:state];
    
    //Replace existing layer with new layer
    [self.layer replaceSublayer:[self.layer.sublayers objectAtIndex:0] with:gradient];
}



-(void) setGradientColor:(NSArray*) colors forState:(UIControlState) state {
    //Maps gradient color to state
    [stateColorMappings setObject:colors forKey:[NSNumber numberWithUnsignedInt:state]];
    //Forces button to redraw - reflect poential changes
    [self eventOccured];
}



-(void) resetState{
    [self setHighlighted:FALSE];
    [self eventOccured];
}





-(void) setup{
    
    [self addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:NULL];
    
    //Setup state mappings
    stateColorMappings = [[NSMutableDictionary alloc] init];
    
    //Add gradient layer (will be overidden later)
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    [self.layer insertSublayer:gradient atIndex:0];
    
    //Action that reapplies layer everytime event occurs
    [self addTarget:self action:@selector(eventOccured) forControlEvents:UIControlEventAllEvents];
    
    //Action that resets state of button when touch is complete
    [self addTarget:self action:@selector(resetState) forControlEvents:UIControlEventTouchUpInside];
    
    [self eventOccured];
}



-(void) forceRedraw{
    [self eventOccured];
}



-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self eventOccured];
}


- (id)init
{
    self = [super init];
    if (self) {        
        [self setup];
    }
    
    return self;
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {        
        [self setup];
    }
    return self;
}

-(void) dealloc {
    [self removeObserver:self forKeyPath:@"enabled"];
}


@end
