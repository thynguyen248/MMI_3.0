//
//  TestTableViewCell1.h
//  Test41
//
//  Created by Aydan Bedingham on 8/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditableKeyValueTableViewCell : UITableViewCell <UITextFieldDelegate>


@property (nonatomic,strong) IBOutlet UILabel* key;

@property (nonatomic,strong) IBOutlet UITextField* value;


@end

