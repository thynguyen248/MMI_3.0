//
//  GradientButtonControl.h
//
//  Possible Uses:
//      - Coloured buttons
//      - Gradient buttons
//      - Changing nib views into either of the above
//
//  Created by Aydan Bedingham on 16/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//
//
//------ How to use ---------
//
//  Note: the Nib activities are an alternate way and not additional steps
//
//  1). Initialising the button
//
//      From Code:
//      - Just initialise it like a regular UIControl
//      - Add components programatically in the same manner as a view
//
//      From Nib:
//      - Import "GradientButtonControl.h" into the .h of the view controller
//      - Go to the view of the ViewController and drop a UIView inside it
//      - Click on the UIView you just placed and go to the identity inspector
//      - On the 'Custom Class' section change the class from "UIView" to "GradientButtonControl"
//
//
//  2). Setting the gradient
//
//      - Use the 'setGradientColorForControlState' method to set the Gradient for a given state
//
//      Eg.
//              NSArray* highlightedColors = [NSArray arrayWithObjects:
//                  (id)[[UIColor colorWithRed:0.0/255 green:226.0/255 blue:226.0/255 alpha:1.0] CGColor],
//                  (id)[[UIColor colorWithRed:0.0/255 green:255.0/255 blue:255.0/255 alpha:1.0] CGColor],
//              nil ];
//
//              [btnDone setGradientColor:highlightedColors forState:UIControlStateHighlighted];
//
//
//  3). Linking to action methods (for onClick and other actions)
//
//      From Code:
//      - Do it just like a regular UIControl
//
//      Eg. For detecting clicks:
//          [self addTarget:YOURTARGET action:@selector(YOURMETHOD) forControlEvents:UIControlEventTouchUpInside];
//
//      From Nib:
//          - Go into the nib
//          - Click on the GradientButtonControl and go to the connections inspector
//          - On the 'Sent Events' section click and hold the circle next to 
//          - Click and hold the circle next to a given event eg. for detecting clicks: 'Touch Up Inside'
//          - Drag the cursor over to the object with the action wish to link to (probably the File Owner)
//          - Release the cursor and select the action
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GradientButtonControl : UIControl{
    CGFloat cornerRadius;
    NSDictionary *attributes;
    NSMutableDictionary* stateColorMappings;
}

-(NSArray*) getGradientColorForControlState: (UIControlState) state;

-(void) setGradientColor:(NSArray*) colors forState:(UIControlState) state;


-(void) forceRedraw;

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;

@property (strong, nonatomic) NSDictionary *attributes;



@end
