//
//  TestTableViewCell1.h
//  Test41
//
//  Created by Aydan Bedingham on 8/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LargeKeyValueTableViewCell : UITableViewCell


@property (nonatomic,strong) IBOutlet UILabel* key;

@property (nonatomic,strong) IBOutlet UILabel* value;

-(void) setUpCellUsingText: (NSString*) defaultText withPlaceHolder: (NSString*) placeholder andIsEditable: (BOOL) isEditable;


@end

