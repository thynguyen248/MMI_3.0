//
//  StyleKeyValueMultilineTableViewCell.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 23/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StyledKeyValueMultilineTableViewCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel* key;

@property (nonatomic,strong) IBOutlet UITextView* value;

@property (nonatomic,strong) IBOutlet UIControl* bgTouchCatcherControl;

-(void) setupCellWithKey:(NSString*) keyString andValue:(NSString*)valueString isEditable:(BOOL)isEditable;

-(IBAction)backgroundTouch:(id)sender;

@end
