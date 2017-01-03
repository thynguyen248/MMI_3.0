//
//  FixedTransportView.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 8/02/13.
//
//

#import "FixedTransportView.h"
#import "EditableTableViewCell.h"
#import "GUICommon.h"
#import "FixedTransportViewContainer.h"
#import "PickupDeliveryTimeRangeListDelegate.h"
#import "ListSelectorViewController.h"
#import "CreateJobViewController.h"
#import "MMJobDetail.h"
#import "MMConfig.h"
#import "UIKeyboardToolbar.h"

@interface FixedTransportView (Privates)
    -(void) setupComponents;
    -(NSString *) formatDate:(NSDate *) date;
    -(EditableTableViewCell*) getCachedCell:(NSInteger) section row:(NSInteger)row;
@end

@implementation FixedTransportView

@synthesize view;
@synthesize label;
@synthesize flexibilityControl;
@synthesize dateTimeTableView;
@synthesize datePicker;
@synthesize timePicker;
@synthesize requiredFieldNote;

-(id) initWithFrameAndContainer:(CGRect)frame container:(FixedTransportViewContainer *) initContainer restDelegate:(id<GUIRestDeligate>) initRestDelegate pickup:(BOOL)initPickup {
    if(self = [super initWithFrame:frame]) {
        [[NSBundle mainBundle] loadNibNamed:@"FixedTransportView" owner:self options:nil];
        
        frame.origin.x = 0;
        frame.origin.y = 0;
        
        self.view.frame = frame;
        
        [self addSubview:self.view];
        
        container = initContainer;
        restDelegate = initRestDelegate;
        pickup = initPickup;
        
        if(!pickup) {
            self.label.text = @"Delivery date and time:";
        }
        
        [self.label sizeToFit];
        CGRect frame = self.requiredFieldNote.frame;
        frame.origin.x = self.label.frame.origin.x + self.label.frame.size.width;
        self.requiredFieldNote.frame = frame;
        
        cellCache = [[NSMutableDictionary alloc] initWithCapacity:2];
        
        [self setupComponents];
    }
    
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    
    [self addSubview:self.view];
}

-(void) setupComponents {
    keyboardToolbar = [[UIKeyboardToolbar alloc] init];
    
    //Setup keyboard - Pass it inputs of table cells
    NSMutableArray* inputs = [[NSMutableArray alloc] init];
    
    for (NSInteger j = 0; j < [dateTimeTableView numberOfSections]; j++) {
        for (NSInteger i = 0; i < [dateTimeTableView numberOfRowsInSection:j]; i++){
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:j];
            
            UITableViewCell* cell = [self tableView:dateTimeTableView cellForRowAtIndexPath:indexPath];
            
            if([cell isKindOfClass:[EditableTableViewCell class]])
            {
                EditableTableViewCell* sCell = (EditableTableViewCell*) cell;

                
                if(j == 0) {
                    sCell.textField.inputView = self.datePicker;
                } else {
                    sCell.textField.inputView = self.timePicker;
                }

                sCell.textField.delegate = self;
                sCell.textField.inputAccessoryView = keyboardToolbar;
                [inputs addObject:sCell.textField];
            }
        }
    }
    
    [keyboardToolbar setInputs:inputs];
        
    NSDate* currentDate = [NSDate date];
    
    datePicker.minimumDate = currentDate;
    datePicker.maximumDate = [GUICommon getDate:currentDate AfterYears:1];
    [datePicker setDate:[NSDate date]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 31;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 6;
    return 1.0;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditableTableViewCell* myCell = [cellCache objectForKey:indexPath];
    if(myCell == nil) {
        myCell = [GUICommon getEditableTableViewCell:dateTimeTableView];
        myCell.textField.userInteractionEnabled = TRUE;
        //Code for dropdown boxes
    
        //Sets disclosure icon to down arrow
        UIButton* accessory = [UIButton buttonWithType:UIButtonTypeCustom];
        [accessory setImage:[UIImage imageNamed:@"DownArrow.png"] forState:UIControlStateNormal];
        accessory.frame = CGRectMake(0, 0, 26, 26);
        accessory.userInteractionEnabled = YES;
        [accessory setEnabled:false];
        myCell.accessoryView = accessory;
        [cellCache setObject:myCell forKey:indexPath];        
    }
        
    if (indexPath.section == 0){
        myCell.textField.placeholder = @"Select date...";
    } else {
        myCell.textField.placeholder = @"Select time...";
    }
        
    return myCell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EditableTableViewCell* viewCell = (EditableTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    [viewCell.textField becomeFirstResponder];
}

-(EditableTableViewCell*) getCachedCell:(NSInteger) section row:(NSInteger)row {
    return (EditableTableViewCell*)[self tableView:dateTimeTableView                                                             cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

#pragma mark - Pickers / Spinners

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[[restDelegate getConfig] getTimePeriods] count];
}


- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[[restDelegate getConfig] getTimePeriods] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    time = [[[restDelegate getConfig] getTimePeriods] objectAtIndex:row];
    EditableTableViewCell* viewCell = [self getCachedCell:1 row:0];
    viewCell.textField.text = time;
}

#pragma mark - UITextField

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if([self getCachedCell:0 row:0].textField == textField) {
        [self dateChange:self.datePicker];
    } else {
        [self pickerView:self.timePicker didSelectRow:0 inComponent:0];
    }
    
    return [container.container textFieldShouldBeginEditing:textField];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return [container.container textFieldShouldEndEditing:textField];
}

-(IBAction) segmentSelected:(id) selector {
    CGFloat diff;
    
    if(flexibilityControl.selectedSegmentIndex == 0) {
        diff = -dateTimeTableView.frame.size.height;
    } else {
        diff = dateTimeTableView.frame.size.height;
    }
    
    CGRect frame = self.frame;
    frame.size.height += diff;
    [self setFrame:frame];
    
    [container subViewResized:self heightDiff:diff];
    [self setNeedsLayout];
}

- (void)dateChange:(id)sender{
    EditableTableViewCell* viewCell = [self getCachedCell:0 row:0];
    viewCell.textField.text = [self formatDate:datePicker.date];
}

-(NSString *) formatDate:(NSDate *) date {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	df.dateStyle = NSDateFormatterMediumStyle;
    return [NSString stringWithFormat:@"%@", [df stringFromDate:date]];
}

-(BOOL) validate {
    //Fixed, validate that the time and date have been entered
    if(flexibilityControl.selectedSegmentIndex == 1) {
        if(datePicker.date == nil || time == nil) {
            self.requiredFieldNote.text = @"* Required fields";
            return TRUE;
        }
    }
    
    return FALSE;
}

-(void) populateJob:(MMJobDetail*) job {
    NSString* flexibility;
    NSDate* date;
    if(flexibilityControl.selectedSegmentIndex == 0) {
        flexibility = JOB_DATE_OPTION_GROUP_FLEXIBLE;
        date =  nil;
    } else {
        flexibility = JOB_DATE_OPTION_GROUP_FIXED;
        date = datePicker.date;
    }
    
    if(pickup) {
        job.pickupDateOptionGroup = flexibility;
        job.pickupDate = date;
        job.pickupTime = time.description;
    } else {
        job.deliveryDateOptionGroup = flexibility;
        job.deliveryDate = date;
        job.deliveryTime = time.description;
    }
}

-(void) clearFieldErrors {
    requiredFieldNote.text = @"*";
}

-(void) resetInputFields {
    for(EditableTableViewCell* cell in [cellCache allValues]) {
        cell.textField.text = nil;
    }

    if(flexibilityControl.selectedSegmentIndex != 0) {
        flexibilityControl.selectedSegmentIndex = 0;
        [self segmentSelected:flexibilityControl];
    }
}

@end
