//
//  LoadingView.h
//  LoadingView
//
//  Created by Matt Gallagher on 12/04/09.
//  Copyright Matt Gallagher 2009. All rights reserved.
// 
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

/*
    How it works:
        - LoadingView is initialized and passed it's parent view
        - Displays progress indicator
        - Disables user interaction to parent view until it is removed
*/

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
{
    UILabel *loadingLabel;
}

@property (nonatomic,strong) UILabel* loadingLabel;


CGPathRef CreatePathWithRoundRect(CGRect rect, CGFloat cornerRadius);

- (id)loadingViewInView:(UIView *)aSuperview;
- (void)removeView;

- (void) removeAllOfMeFromSuperView:(UIView *) superView;

@end
