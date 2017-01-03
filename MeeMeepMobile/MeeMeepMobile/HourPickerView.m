//
//  HourPickerView.m
//  HourPickerView
//
//  Created by User on 4/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HourPickerView.h"

@implementation HourPickerView

#define MAX_ROLL 100
#define ROWS_COUNT 10


-(id) init{
    self = [super init];
    
    if (self){
        times = [[NSArray alloc] initWithObjects:
                 @"12:00",
                 @"1:00",
                 @"2:00",
                 @"3:00",
                 @"4:00",
                 @"5:00",
                 @"6:00",
                 @"7:00",
                 @"8:00",
                 @"9:00",
                 @"10:00",
                 @"11:00",
                 nil];
        self.delegate = self;
        self.dataSource = self;
        
        self. showsSelectionIndicator = YES;
        
        
    }
    return self;
}




-(id) initWithSelectionListener: (id<HourPickerViewSelectionListener>) listener{
    self = [self init];
    if (self){
        d = listener;
    }
    return self;
}


-(NSDate*) getSelectedTime{
    
    NSInteger hour = [self selectedRowInComponent:0];
    
    BOOL isPM;
    if ([self selectedRowInComponent:1]==1) isPM = true; else isPM = false;
    
    if (isPM) hour = hour + 12;

    NSDateComponents *comps = [[NSCalendar currentCalendar] 
                               components:NSDayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit 
                               fromDate:[NSDate date]];
    [comps setHour:hour];
    [comps setMinute:0]; 
    [comps setSecond:0];

    
    return [[NSCalendar currentCalendar] dateFromComponents:comps];

}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [d pickerView:self didSelectRow:row inComponent:component];
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView { // This method needs to be used. It asks how many columns will be used in the UIPickerView
	return 2;
}


- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    if (component==0) return 12; else return 2;
	
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component { // This method asks for what the title or label of each row will be.
    if (component==0){
        return [times objectAtIndex:row];
    } else {
        if (row==0) return @"AM";
        else return @"PM";
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    //
    if (component==0) return 80;
    else return 60;
}


@end
