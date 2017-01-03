//
//  MessageTableViewCell.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 9/05/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
#import "MMMessageDetail.h"


enum messageOrientation {messageOrientationLeft, messageOrientationRight};

@interface MessageTableViewCell : UITableViewCell<UITextViewDelegate>{
    //MMMessageDetail* message;
    enum messageOrientation orientation;
}

+(NSInteger)commentFieldWidth;
+(NSInteger)commentFontSize;
+(NSInteger)defaultHeight;


@property (nonatomic,strong) IBOutlet UIImageView* imgPerson;

@property (nonatomic,strong) IBOutlet UITextView* inptMessage;

@property (nonatomic,strong) MMMessageDetail* message;

@property (nonatomic,strong) IBOutlet UIImageView* commentBlurbImage;


-(void) setupCellWithMessage:(MMMessageDetail*) theMessage AndOrientation:(enum messageOrientation) theOrientation;

@end
