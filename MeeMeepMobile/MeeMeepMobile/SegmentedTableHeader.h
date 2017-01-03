//
//  SegmentedTableHeader.h
//  MeeMeepMobile
//
//  Created by Julian Raff on 5/02/13.
//
//

#import <UIKit/UIKit.h>
#import "SegmentedTableHeaderDelegate.h"

@interface SegmentedTableHeader : UIView

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segControl;

@property (nonatomic, assign) id <SegmentedTableHeaderDelegate> delegate;

- (IBAction)onSegControlChange:(id)sender;
- (void)fixHeight;

@end
