//
//  KeyboardToolBar.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 16/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "KeyboardToolBar.h"

@implementation KeyboardToolBar

@synthesize  btnPrevious, btnNext, flexibleSpace, btnDone;


-(UIToolbar*)initWithInputFields:(UIView*)aView inputs:(NSArray*)inputs {
    myView = aView;
    self = [super initWithFrame:CGRectMake(0, 0, myView.bounds.size.width, 44)]; //Apples reccommended height
    if (self){
        self.tintColor = [UIColor blackColor];
        
        inputFields = [NSMutableArray arrayWithArray:inputs];
        
        
        //self?
        
        btnPrevious = [[UIBarButtonItem alloc] initWithTitle:@"Previous"
                                                    style:UIBarButtonItemStyleBordered
                                                    target:self
                                                    action:@selector(goToPreviousInputField:)];
        
        btnNext = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                       style:UIBarButtonItemStyleBordered
                                                      target:self
                                                  action:@selector(goToNextInputField:)];
        
        flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];    
        
        btnDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
            target:self action:@selector(resignKeyboard:)];
        
        [self setItems:[[NSArray alloc] initWithObjects:btnPrevious,btnNext,flexibleSpace,btnDone, nil ]];
        
        [btnDone setTintColor:[UIColor colorWithRed:25/255.0f green:79/255.0f blue:219/255.0f alpha:1]];
        
        
        return self;
    } else return nil;
}

-(void) setInputs:(NSArray *) inputs {
    inputFields = [NSMutableArray arrayWithArray:inputs];
}

-(void) insertInput:(UITextField*) input after:(UITextField*) after {
    NSInteger index = 0;
    for(UITextField* inputField in inputFields) {
        if(inputField == after) {
            ++index;
            break;
        }
        
        ++index;
    }
    
    [inputFields insertObject:input atIndex:index];
}

-(void) removeInput:(UITextField*) input {
    [inputFields removeObject:input];
}
    

-(NSInteger) findIndexOfFirstResponder{    
    bool responderFound = false;
    int i =0;
    UIResponder* input;
    while ((responderFound==false)&(i<[inputFields count])) {
        input = [inputFields objectAtIndex:i];
        if ([input isFirstResponder]){
            responderFound=true;
        } else i++;
    }
    if (responderFound==true) return i; else return -1;
}




-(UIView*) findFirstResponder{  
    NSInteger responderIndex = [self findIndexOfFirstResponder];
    
    if (responderIndex>-1)
        return [inputFields objectAtIndex:responderIndex];
    else
        return nil;
}




-(UIView*) getNextInputfield: (UIResponder*) aField{
    NSInteger responderIndex = [inputFields indexOfObject:aField];
    if (responderIndex==[inputFields count]-1) return [inputFields objectAtIndex:0];
    else return [inputFields objectAtIndex:responderIndex+1];
}



-(UIView*) getPreviousInputfield: (UIResponder*) aField{
    NSInteger responderIndex = [inputFields indexOfObject:aField];
    if (responderIndex==0) return [inputFields objectAtIndex: [inputFields count]-1];
    else return [inputFields objectAtIndex:responderIndex-1];
}







-(IBAction) goToNextInputField: (id)sender{
    
    id oldResponder = [self findFirstResponder];
    
    UIView* field = [self getNextInputfield:oldResponder];
    
    while (field.userInteractionEnabled==false){
        field = [self getNextInputfield:field];
    }
    
    [self resignKeyboard:oldResponder];
    [field becomeFirstResponder];
}



-(IBAction) goToPreviousInputField: (id)sender{
    id oldResponder = [self findFirstResponder];
    
    UIView* field = [self getPreviousInputfield:oldResponder];
    while (field.userInteractionEnabled==false){
        field = [self getPreviousInputfield:field];
    }

    [self resignKeyboard:oldResponder];
    [field becomeFirstResponder];
}




-(IBAction)resignKeyboard:(id)sender{
    UIView* input = [self findFirstResponder];
    [input becomeFirstResponder];
    if (input)  [input resignFirstResponder];
}



@end
