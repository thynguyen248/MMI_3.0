//
//  UrgentTransportView.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 8/02/13.
//
//

#import "UrgentTransportView.h"
#import "MMJobDetail.h"
#import "CreateJobViewController.h"
#import "MMConfig.h"

@interface UrgentTransportView (Privates)

-(NSString*) getCollectionSelector:(NSInteger)index;

@end

@implementation UrgentTransportView

@synthesize view;
@synthesize pickupDay;
@synthesize deliveryDay;

-(id) initWithFrameAndContainer:(CGRect) frame viewController:(CreateJobViewController *) initViewController restDelegate:(id<GUIRestDeligate>) initRestDelegate {
    if(self = [super initWithFrame:frame]) {
        [[NSBundle mainBundle] loadNibNamed:@"UrgentTransportView" owner:self options:nil];
        
        restDelegate = initRestDelegate;
        
        frame.origin.x = 0;
        frame.origin.y = 0;
        
        self.view.frame = frame;
        
        [self addSubview:self.view];
        
        self.autoresizesSubviews = TRUE;
        viewController = initViewController;
    }
    
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    
    [self addSubview:self.view];
}

-(IBAction) segmentChanged:(id)sender {
    if(sender == pickupDay) {
        if(pickupDay.selectedSegmentIndex == 0) {
            [deliveryDay setEnabled:TRUE forSegmentAtIndex:0];
        } else if(pickupDay.selectedSegmentIndex == 1) {
            deliveryDay.selectedSegmentIndex = 1;
            [deliveryDay setEnabled:FALSE forSegmentAtIndex:0];
        }
    }
}

-(void) populateJob:(MMJobDetail*) job {
    job.urgentCollectionSelector = [self getCollectionSelector:pickupDay.selectedSegmentIndex];
    job.urgentDeliverySelector = [self getCollectionSelector:deliveryDay.selectedSegmentIndex];
}

-(NSString*) getCollectionSelector:(NSInteger)index {
    NSArray* tags = [[restDelegate getConfig] getUrgencyTags];
    
    return [tags objectAtIndex:index];
}

-(void) resetInputFields {
    pickupDay.selectedSegmentIndex = 0;
    deliveryDay.selectedSegmentIndex = 0;
    
    [self segmentChanged:pickupDay];
}

@end
