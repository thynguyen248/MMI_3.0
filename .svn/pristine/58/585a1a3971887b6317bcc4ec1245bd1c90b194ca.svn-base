//
//  UrgentTransportView.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 8/02/13.
//
//

#import <UIKit/UIKit.h>

@class MMJobDetail;
@class CreateJobViewController;
@protocol GUIRestDeligate;

@interface UrgentTransportView : UIView {
    CreateJobViewController* viewController;
    id<GUIRestDeligate> restDelegate;
}

-(id) initWithFrameAndContainer:(CGRect) frame viewController:(CreateJobViewController *) initViewController restDelegate:(id<GUIRestDeligate>) restDelegate;
-(void) populateJob:(MMJobDetail*) job;
-(IBAction) segmentChanged:(id)sender;
-(void) resetInputFields;

@property (nonatomic, strong) IBOutlet UIView* view;
@property (nonatomic, strong) IBOutlet UISegmentedControl* pickupDay;
@property (nonatomic, strong) IBOutlet UISegmentedControl* deliveryDay;

@end
