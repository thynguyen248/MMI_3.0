//
//  FixedTransportView.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 8/02/13.
//
//

#import <UIKit/UIKit.h>
@class FixedTransportViewContainer;
@class MMJobDetail;
@class UIKeyboardToolbar;
@protocol GUIRestDeligate;

@interface FixedTransportView : UIView<UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource,
                                       UIPickerViewDataSource, UITextFieldDelegate> {
    UIView* view;
    UILabel* label;
    UISegmentedControl* flexibilityControl;
    UITableView* dateTimeTableView;
    UIDatePicker* datePicker;
    UIPickerView* timePicker;
    FixedTransportViewContainer* container;
    id<GUIRestDeligate> restDelegate;
                                           
                                           
    NSMutableDictionary* cellCache;
    
    NSString* time;
                                           
    UIKeyboardToolbar* keyboardToolbar;
    
    BOOL pickup;
}

-(id) initWithFrameAndContainer:(CGRect)frame container:(FixedTransportViewContainer *) initContainer restDelegate:(id<GUIRestDeligate>) restDelegate pickup:(BOOL)initPickup;
-(IBAction) segmentSelected:(id) selector;
-(IBAction) dateChange:(id)sender;
-(BOOL) validate;
-(void) populateJob:(MMJobDetail*) job;
-(void) clearFieldErrors;
-(void) resetInputFields;

@property (nonatomic,strong) IBOutlet UIView* view;
@property (nonatomic,strong) IBOutlet UILabel* label;
@property (nonatomic,strong) IBOutlet UISegmentedControl* flexibilityControl;
@property (nonatomic,strong) IBOutlet UITableView* dateTimeTableView;
@property (nonatomic,strong) IBOutlet UIDatePicker* datePicker;
@property (nonatomic,strong) IBOutlet UIPickerView* timePicker;
@property (nonatomic,strong) IBOutlet UILabel* requiredFieldNote;

@end
