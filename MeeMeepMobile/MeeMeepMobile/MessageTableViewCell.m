//
//  MessageTableViewCell.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 9/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "MessageTableViewCell.h"



@implementation MessageTableViewCell

//NSInteger const commentFontSize = 12;
//NSInteger const commentFieldWidth = 263;


@synthesize message;

@synthesize imgPerson, inptMessage;

@synthesize commentBlurbImage;

#define _commentFieldWidth 245
#define _commentFontSize 13
#define _defaultHeight 54
#define _horizontalIndentation 10
#define _defaultWidth 320

#define ImagePersonRight @"PersonRight.png"
#define ImagePersonLeft @"PersonLeft.png"
#define ImageBlurb @"CommentBorder.png"





+(NSInteger)commentFieldWidth {
    return _commentFieldWidth;
}

+(NSInteger)commentFontSize {
    return _commentFontSize;
}


+(NSInteger)defaultHeight {
    return _defaultHeight;
}

+(NSInteger) horizontalIndentation {
    return _horizontalIndentation;
}

+(NSInteger)defaultWidth {
    return _defaultWidth;
}



-(void) resizeSpeechBlurb{
    inptMessage.frame = CGRectMake(inptMessage.frame.origin.x, inptMessage.frame.origin.y, inptMessage.frame.size.width+10, inptMessage.contentSize.height+10);

}

-(void) setMessage:(MMMessageDetail*)theMessage{
    theMessage.content = [theMessage.content stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    message = theMessage;
    [inptMessage setText:[NSString stringWithFormat:@"%@ says:\n%@", message.username, message.content]];
    [self resizeSpeechBlurb];
}
 



-(void) setOrientation:(enum messageOrientation) theOrientation{
    orientation = theOrientation;
    
    [inptMessage setFont:[UIFont systemFontOfSize: [MessageTableViewCell commentFontSize]]];
    
    if (orientation==messageOrientationLeft){
        //Set image of person
        [imgPerson setImage:[UIImage imageNamed:ImagePersonRight]];
        
        //Position image of person
        imgPerson.frame = CGRectMake(
                                     [MessageTableViewCell horizontalIndentation],
                                     imgPerson.frame.origin.y,
                                     imgPerson.frame.size.width,
                                     imgPerson.frame.size.height
                                     );
        
        //Position the speechblurb
        NSInteger overlapAlignmentOffset = 6;
        inptMessage.frame = CGRectMake(
                                       imgPerson.frame.size.width+overlapAlignmentOffset,
                                       imgPerson.frame.origin.y,
                                       [MessageTableViewCell commentFieldWidth],
                                       inptMessage.frame.size.height
                                       );
    } else{ //right
        //Set image of Person
        [imgPerson setImage:[UIImage imageNamed:ImagePersonLeft]];
        
        //Position image of person
        imgPerson.frame = CGRectMake(
                                     [MessageTableViewCell defaultWidth] - imgPerson.frame.size.width - [MessageTableViewCell horizontalIndentation],
                                     imgPerson.frame.origin.y,
                                     imgPerson.frame.size.width,
                                     imgPerson.frame.size.height
                                     );

        //Positioning the speechblurb
        NSInteger overlapAlignmentOffset = 2;
        inptMessage.frame = CGRectMake(
                                       imgPerson.frame.origin.x-[MessageTableViewCell commentFieldWidth]+overlapAlignmentOffset,
                                       imgPerson.frame.origin.y,
                                       [MessageTableViewCell commentFieldWidth],
                                       inptMessage.frame.size.height
                                       );
    }
}

-(void) setupCellWithMessage:(MMMessageDetail*) theMessage AndOrientation:(enum messageOrientation) theOrientation{
    [self setMessage: theMessage];
    [self setOrientation: theOrientation];
     
    //Put border around TextView
    commentBlurbImage.frame = CGRectMake(inptMessage.frame.origin.x, inptMessage.frame.origin.y, 
                                         inptMessage.frame.size.width, inptMessage.frame.size.height);
    commentBlurbImage.image = [[UIImage imageNamed:ImageBlurb] stretchableImageWithLeftCapWidth:10 topCapHeight:14];
    [commentBlurbImage setNeedsDisplay];
}


//Automatically resizes textbox
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    [self resizeSpeechBlurb];
    
    return true;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
