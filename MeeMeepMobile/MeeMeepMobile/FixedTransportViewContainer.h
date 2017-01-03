//
//  FixedTransportViewContainer.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 12/02/13.
//
//

#import <UIKit/UIKit.h>
#import "FixedTransportView.h"

@class CreateJobViewController;
@class MMJobDetail;
@protocol GUIRestDeligate;

@interface FixedTransportViewContainer : UIView {
    FixedTransportView* pickupView;
    FixedTransportView* dropoffView;
    
    CreateJobViewController* container;
}

- (id)initWithFrameAndContainer:(CGRect)frame container:(CreateJobViewController *) initContainer
                   restDelegate:(id<GUIRestDeligate>)restDelegate;


-(void) subViewResized:(UIView*) view heightDiff:(CGFloat)heightDiff;
-(BOOL) validateCrossReferences;
-(BOOL) validateRequiredFields;
-(void) populateJob:(MMJobDetail*) job;
-(void) clearFieldErrors;
-(void) resetInputFields;

@property (nonatomic, strong) CreateJobViewController* container;

@end
