//
//  TestTableViewCell1.m
//  Test41
//
//  Created by Aydan Bedingham on 8/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "LargeEditableKeyValueTableViewCell.h"

@implementation LargeEditableKeyValueTableViewCell

@synthesize key, value;


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    DLog(@"textViewDidBeginEditing");
    key.hidden = true;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    DLog(@"textViewDidEndEditing");
    if(textView.text.length == 0) {
        key.hidden = false;
    }
}

@end
