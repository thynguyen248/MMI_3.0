//
//  KeyboardToolBar.h
//
//  Deprecated version of UIKeyboardToolbar - kept for compatibility only
//
//  Created by Aydan Bedingham on 16/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardToolBar : UIToolbar{
    NSMutableArray* inputFields;
    
    UIBarButtonItem* btnPrevious;
    UIBarButtonItem* btnNext;
    UIBarButtonItem* flexibleSpace;
    UIBarButtonItem* btnDone;
    UIView* myView;
}

-(UIToolbar*)initWithInputFields:(UIView*)aView inputs:(NSArray*)inputs;
-(void) insertInput:(UITextField*) input after:(UITextField*) after;
-(void) removeInput:(UITextField*) input;
-(void) setInputs:(NSArray *) inputs;

@property (nonatomic,strong) UIBarButtonItem* btnPrevious;    
@property (nonatomic,strong) UIBarButtonItem* flexibleSpace;
@property (nonatomic,strong) UIBarButtonItem* btnNext;
@property (nonatomic,strong) UIBarButtonItem* btnDone;

-(IBAction)resignKeyboard:(id)sender;


-(UIView*) findFirstResponder;

@end
