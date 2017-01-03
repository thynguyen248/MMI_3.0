//
//  FixedTransportViewContainer.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 12/02/13.
//
//

#import "FixedTransportViewContainer.h"
#import "CreateJobViewController.h"
#import "MMJobDetail.h"

@implementation FixedTransportViewContainer

static const NSInteger FIXED_TRANSPORT_SPACING = 8;

@synthesize container;

- (id)initWithFrameAndContainer:(CGRect)frame container:(CreateJobViewController *) initContainer
                   restDelegate:(id<GUIRestDeligate>)restDelegate {
    if (self = [super initWithFrame:frame]) {
        container = initContainer;
        
        // Initialization code
        frame.origin.x = 0;
        frame.origin.y = 0;
        
        frame.size.height = 59;
        
        pickupView = [[FixedTransportView alloc] initWithFrameAndContainer:frame container:self restDelegate:restDelegate pickup:TRUE];
        
        frame.origin.y = frame.size.height + FIXED_TRANSPORT_SPACING;
        
        dropoffView = [[FixedTransportView alloc] initWithFrameAndContainer:frame container:self
                                                               restDelegate:restDelegate pickup:FALSE];

        dropoffView.userInteractionEnabled = TRUE;
        [self addSubview:dropoffView];
        [self addSubview:pickupView];

        self.clipsToBounds = TRUE;
    }
    
    return self;
}

-(void) subViewResized:(UIView*) view heightDiff:(CGFloat)heightDiff {
    CGRect frame = self.frame;
    frame.size.height = pickupView.frame.size.height + dropoffView.frame.size.height + FIXED_TRANSPORT_SPACING;
    [self setFrame:frame];
    
    if(view == pickupView) {
        frame = dropoffView.frame;
        frame.origin.y = pickupView.frame.size.height + FIXED_TRANSPORT_SPACING;
        dropoffView.frame = frame;
    }
    
    [container resizeBelowTransportView:heightDiff];
}

-(BOOL) validateRequiredFields {
    BOOL pickupResult = [pickupView validate];
    BOOL dropoffResult = [dropoffView validate];
    
    return pickupResult || dropoffResult;
}

-(BOOL) validateCrossReferences {
    //If both the views a 'inflexible' then we need to ensure that drop off is >= pickup
    if(pickupView.flexibilityControl.selectedSegmentIndex == 1 &&
       dropoffView.flexibilityControl.selectedSegmentIndex == 1) {
        NSComparisonResult result = [pickupView.datePicker.date compare:dropoffView.datePicker.date];
        if(result == NSOrderedDescending) {
            //Display error message
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Delivery date must be greater than or equal to Pickup date" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
            return TRUE;
        }
    }
    
    return FALSE;
}

-(void) populateJob:(MMJobDetail*) job {
    [pickupView populateJob:job];
    [dropoffView populateJob:job];
}

-(void) clearFieldErrors {
    [pickupView clearFieldErrors];
    [dropoffView clearFieldErrors];
}

-(void) resetInputFields {
    [pickupView resetInputFields];
    [dropoffView resetInputFields];    
}

@end
