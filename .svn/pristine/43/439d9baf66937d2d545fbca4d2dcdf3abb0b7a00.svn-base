//
//  MeeMeepCheckbox.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 5/03/13.
//
//

#import "MeeMeepCheckbox.h"

@interface MeeMeepCheckbox(Privates)
-(void) privateInit;
-(void) buttonClicked:(id) source;

@end

@implementation MeeMeepCheckbox

NSString* const MMCheckBox_Checked = @"Checkbox-checked.png";
NSString* const MMCheckBox_Unchecked = @"Checkbox-unchecked.png";

@synthesize checked;

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self privateInit];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self privateInit];
    }
    return self;
}

-(void) privateInit {
    [self setBackgroundImage:[UIImage imageNamed:MMCheckBox_Unchecked] forState:UIControlStateNormal];
    
    [self addTarget:nil action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) buttonClicked:(id) source {
    self.checked = !self.checked;
    
    NSString* imageName;
    if(self.checked) {
        imageName = MMCheckBox_Checked;
    } else {
        imageName = MMCheckBox_Unchecked;
    }
    
    [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

@end
