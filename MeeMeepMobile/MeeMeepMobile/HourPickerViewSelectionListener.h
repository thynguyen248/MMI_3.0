//
//  HourPickerViewDelegate.h
//
//  Created by Aydan Bedingham on 5/06/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HourPickerViewSelectionListener <NSObject>

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end
