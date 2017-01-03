//
//  StyledKeyValueTableViewCell.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 7/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StyledKeyValueTableViewCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel* key;

@property (nonatomic,strong) IBOutlet UITextField* value;

@property (nonatomic,strong) IBOutlet UIControl* bgTouchCatcherControl;

-(void) setupCellWithKey:(NSString*) keyString andValue:(NSString*)valueString andValuePlaceHolder: valuePlaceholder isEditable:(BOOL)isEditable;
-(void) validate:(bool)isRequired;

-(IBAction)backgroundTouch:(id)sender;

@end
