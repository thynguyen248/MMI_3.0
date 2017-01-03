//
//  UIKeyboardToolbar.h
//
//
//  UIKeyboardToolbar is intended to function as an input accessory that adds a Toolbar 
//  with the options of Previous, Next and Done to standard UITextField and UITextView
//
//
//  How to use:
//  
//  - Initialise it like a UIToolbar
//
//  - Create an array of the TextInputs you want it to apply to
//
//  - Set the input accessory of the TextInputs to the instance of UIKeyboardToolbar
//
//  - Parse the array of TextInputs to the instance of UIKeyboardToolbar using the 
//  'loadWithInputs' method
//
//
//  Created by Aydan Bedingham on 17/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIKeyboardToolbar : UIToolbar{
    
    BOOL shouldOverrideInputAccessories; //Overrides inputaccessory of views on action
    
    NSArray* inputs;
}


@property (nonatomic,assign) BOOL shouldOverrideInputAccessories;

@property (nonatomic,strong) UIBarButtonItem* btnPrevious;    
@property (nonatomic,strong) UIBarButtonItem* flexibleSpace;
@property (nonatomic,strong) UIBarButtonItem* btnNext;
@property (nonatomic,strong) UIBarButtonItem* btnDone;

@property (nonatomic,strong) NSArray* inputs;





-(void) loadWithInputs:(NSArray*) inputFields;
    
-(NSInteger) findIndexOfFirstResponder;
-(UIResponder*) findFirstResponder;

-(void) tryOverrideAccessory:(UIResponder*) responder;


-(BOOL) isValidInput: (NSObject*) object;
-(void) setAsFirstResponder: (UIResponder*) responder;

-(UIResponder*) getNextField: (UIResponder*) currentField;
-(UIResponder*) getNextInputField: (UIResponder*) currentField;
-(IBAction) goToNextInputField: (id)sender;

-(UIResponder*) getPreviousField: (UIResponder*) currentField;
-(UIResponder*) getPreviousInputField: (UIResponder*) currentField;
-(IBAction) goToPreviousInputField: (id)sender;

-(IBAction)resignKeyboard:(id)sender;



@end
