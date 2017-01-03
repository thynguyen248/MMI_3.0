//
//  HourPickerView.h
//  HourPickerView
//
//
//  What it is:
//
//  The hour picker is a subclass of the pickerview that allows the user to 
//  choose a given hour of the day it is used as an alternative to the TimePicker 
//  because it does not require a minute field.
//
//
//
//  How it works:
//
//  The hour pickerview is set to be it's own datasource and delegate when it is 
//  initialised - the reason for this is to allow it to manage it's own data and 
//  remain self-contained.
//
//  However the fact it is it's own delegate means it returns notifications to 
//  itself (and not any perspective view controllers that want to implement it)  - 
//  if the delegate is overriden it will prevent any data being displayed (the 
//  pickerview delegate is responsible for the display of data and not just 
//  handling callbacks for when selections are made).
//
//  As a workaround the HourPickerView can be initialised with a 'listener' that 
//  implements the HourPickerViewSelectionListener interface. This will result in 
//  the HourPickerView calling into the listener every time a selection change is 
//  made using the standardard 'pickerView didSelectRow' method.
//
//
//
//  How to use it:
//
//  - Make object implement the PickerViewDelegate
//  - Make object implement the HourPickerViewSelectionListener
//  - Initialise a HourPickerView with the listener set to object
//  - Use it like a normal pickerview
//  
//  Keep in mind that the 'pickerView didSelectRow' method in object is the only 
//  method that will be called by the HourPickerView
//
//
//
//  Future improvements:
//
//  - HourPickerView should be a View that encapsultaes a pickerview (not a pickerview 
//  subclass)
//
//  - This would allow for a completly seperate HourpickerViewDelegate interface to be 
//  setup that does not impede the existing pickerView delegate system.
//
//  - This would also mean the HourPickerViewSelectionListener pattern could be removed
//
//
//
//  Created by Aydan Bedingham on 16/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HourPickerViewSelectionListener.h"

@interface HourPickerView : UIPickerView <UIPickerViewDelegate,UIPickerViewDataSource>{
    NSArray* times;
    id<HourPickerViewSelectionListener> d;
}


-(NSDate*) getSelectedTime;

-(id) initWithSelectionListener: (id<HourPickerViewSelectionListener>) listener;

@end
