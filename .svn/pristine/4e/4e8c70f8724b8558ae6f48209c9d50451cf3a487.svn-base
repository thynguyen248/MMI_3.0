//
//  SegmentedTableHeader.m
//  MeeMeepMobile
//
//  Created by Julian Raff on 5/02/13.
//
//

#import "SegmentedTableHeader.h"

@implementation SegmentedTableHeader

- (void)fixHeight {
    CGRect frame = _segControl.frame;
    [_segControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 30)];
}


- (IBAction)onSegControlChange:(id)sender {
    return [_delegate onSegControlChange:_label.text withNewValue:_segControl.selectedSegmentIndex];
}

@end
