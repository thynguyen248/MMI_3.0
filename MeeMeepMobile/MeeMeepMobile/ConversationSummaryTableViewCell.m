//
//  ConversationSummaryTableViewCell.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 11/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "ConversationSummaryTableViewCell.h"
#import "GUICommon.h"


@implementation ConversationSummaryTableViewCell

@synthesize lblSubject;
@synthesize lblUsername;
@synthesize lblMessageCount;
@synthesize messageView;

@synthesize messageGroup;


-(IBAction)messageViewClick:(id)sender{
    [delegate conversationSummaryCellDidReturnMessageGroup:messageGroup];
}



-(void) setMessageGroup:(MMMessageGroup*) theMessageGroup{
    
    messageGroup = theMessageGroup;
    
    [lblUsername setText: messageGroup.username];
    [lblSubject setText: messageGroup.subject];
    
    [lblMessageCount setText: [NSString stringWithFormat:@"%d", [messageGroup.messages count]]];
}




-(void) setupCellWithMessageGroup:(MMMessageGroup*) theMessageGroup andDelegate: (id<ConversationSummaryCellDelegate>) d{
    
    delegate = d;
    
    [messageView setUserInteractionEnabled:YES];  
    [self setMessageGroup: theMessageGroup];
    
    // Style message view    
    NSArray* normalColors = [GUICommon MeeMeepButtonGradientOrange];      
    NSArray* highlightedColors = [GUICommon MeeMeepButtonGradientOrangeHighlighted];
    [messageView setGradientColor:highlightedColors forState:UIControlStateHighlighted];
    [messageView setGradientColor:normalColors forState:UIControlStateNormal];
    

}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
