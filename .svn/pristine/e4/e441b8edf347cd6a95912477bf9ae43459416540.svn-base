//
//  UIKeyboardToolbar.m
//  Test51
//
//  Created by Aydan Bedingham on 17/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "UIKeyboardToolbar.h"


@implementation UIKeyboardToolbar

@synthesize shouldOverrideInputAccessories;
@synthesize inputs;
@synthesize  btnPrevious, btnNext, flexibleSpace, btnDone;



-(id) init{

    
    self = [super initWithFrame:CGRectMake(0, 0, 100, 44)];
    if (self){
        shouldOverrideInputAccessories = false;
        
        inputs = [[NSMutableArray alloc] init];
        
        self.tintColor = [UIColor blackColor];
        
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
                                                                target:self
                                                                action:@selector(resignKeyboard:)];
        
        [self setItems:[[NSArray alloc] initWithObjects:btnPrevious,btnNext,flexibleSpace,btnDone, nil ]];
        
        [btnDone setTintColor:[UIColor colorWithRed:25/255.0f green:79/255.0f blue:219/255.0f alpha:1]];
        
        
        return self;
    } else return nil;

}

-(void) tryOverrideAccessory:(UIResponder*) responder{
    
    if ([responder isKindOfClass:[UITextField class]]){
        UITextField* textField = (UITextField*)responder;
        textField.inputAccessoryView = self;
    } else {
        if ([responder isKindOfClass:[UITextView class]]){
            UITextView* textView = (UITextView*)responder;
            textView.inputAccessoryView = self;            
        }
    }
}



-(void) loadWithInputs:(NSArray*) inputFields{
    inputs = inputFields;
    if (shouldOverrideInputAccessories==true){
        for (UIView* view in inputs){
            [self tryOverrideAccessory:view];
        }
    }
}


-(NSInteger) findIndexOfFirstResponder{    
    bool responderFound = false;
    int i =0;
    NSObject* object;
    while ((responderFound==false)&&(i<[inputs count])) {
        object = [inputs objectAtIndex:i];

        if ([object isKindOfClass:[UIResponder class]]){
            UIResponder* responder = (UIResponder*) object;
            if ([responder isFirstResponder]){
                responderFound=true;
            }
        }
        if (responderFound==false) i++;
    }
    if (responderFound==true) return i; else return -1;
}




-(UIResponder*) findFirstResponder{  
    NSInteger responderIndex = [self findIndexOfFirstResponder];

    if (responderIndex>-1)
        return [inputs objectAtIndex:responderIndex];
    else
        return nil;
}






-(BOOL) isValidInput: (NSObject*) object{
    
    if(
       ([object isKindOfClass:[UIView class]])&&
       ([object conformsToProtocol:@protocol(UITextInput)])&&
       ([object conformsToProtocol:@protocol(UITextInputTraits)])
       )
    {
        UIView* view = (UIView*)object;
        if (view.userInteractionEnabled==true){
            return true;
        } else return false;
    } else return false;
    
}



-(void) setAsFirstResponder: (UIResponder*) responder{
    [self tryOverrideAccessory:responder];
    [responder becomeFirstResponder];
}




-(UIResponder*) getNextField: (UIResponder*) currentField{
    NSInteger responderIndex = [inputs indexOfObject:currentField];
    if (responderIndex==[inputs count]-1) return [inputs objectAtIndex:0];
    else return [inputs objectAtIndex:responderIndex+1];
}




-(UIResponder*) getNextInputField: (UIResponder*) currentField{
    UIResponder* field = [self getNextField:currentField];
    while ([self isValidInput:field]==false){
        field = [self getNextField:field];
    }
    return field;
}




-(IBAction) goToNextInputField: (id)sender{
    id oldResponder = [self findFirstResponder];
    if (oldResponder!=nil){
        UIResponder* field = [self getNextInputField:oldResponder];
        [self setAsFirstResponder:field];
    }
}





-(UIResponder*) getPreviousField: (UIResponder*) aField{
    NSInteger responderIndex = [inputs indexOfObject:aField];
    
    if (responderIndex==0) return [inputs objectAtIndex: [inputs count]-1];
    else return [inputs objectAtIndex:responderIndex-1];
    
}


-(UIResponder*) getPreviousInputField: (UIResponder*) currentField{
    
    UIResponder* field = [self getPreviousField:currentField];
    
    while ([self isValidInput:field]==false){
        field = [self getPreviousField:field];
    }
    return field;
    
}



-(IBAction) goToPreviousInputField: (id)sender{
    id oldResponder = [self findFirstResponder];

    
    if (oldResponder!=nil){        
        UIResponder* field = [self getPreviousInputField:oldResponder];
        
        [self setAsFirstResponder:field];
    }
}




-(IBAction)resignKeyboard:(id)sender{
    UIResponder* input = [self findFirstResponder];
    if (input){
        [input becomeFirstResponder];
        [input resignFirstResponder];
    }
}




@end
