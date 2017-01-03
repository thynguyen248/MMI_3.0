//
//  LoadingView.m
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

#import "LoadingView.h"
#import <QuartzCore/QuartzCore.h>

//
// NewPathWithRoundRect
//
// Creates a CGPathRect with a round rect of the given radius.
//
CGPathRef CreatePathWithRoundRect(CGRect rect, CGFloat cornerRadius)
{
	//
	// Create the boundary path
	//
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y + rect.size.height - cornerRadius);

	// Top left corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y,
		rect.origin.x + rect.size.width,
		rect.origin.y,
		cornerRadius);

	// Top right corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + rect.size.width,
		rect.origin.y,
		rect.origin.x + rect.size.width,
		rect.origin.y + rect.size.height,
		cornerRadius);

	// Bottom right corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + rect.size.width,
		rect.origin.y + rect.size.height,
		rect.origin.x,
		rect.origin.y + rect.size.height,
		cornerRadius);

    
	// Bottom left corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y + rect.size.height,
		rect.origin.x,
		rect.origin.y,
		cornerRadius);


	// Close the path at the rounded rect
	CGPathCloseSubpath(path);
	
	return path;

}

@implementation LoadingView

@synthesize loadingLabel;


//
// loadingViewInView:
//
// Constructor for this view. Creates and adds a loading view for covering the
// provided aSuperview.
//
// Parameters:
//    aSuperview - the superview that will be covered by the loading view
//
// returns the constructed view, already added as a subview of the aSuperview
//	(and hence retained by the superview)
//
- (id)loadingViewInView:(UIView *)aSuperview
{
    [self setUserInteractionEnabled:FALSE];
    
	LoadingView *loadingView =
		[[LoadingView alloc] initWithFrame:[aSuperview bounds]];
	if (!loadingView)
	{
		return nil;
	}
    
    
    //Settings
    loadingView.opaque = NO;

	[aSuperview addSubview:loadingView];
    
    //Position view
    const CGFloat width = 80;
    const CGFloat height = 80;
    
    
    //Leave it hardcoded or bad things will happen
    // eg. Position on modal vs navigated views (in relation to titlebar)
    // Possible solution: get the app delegate to display it on the tabbar
    int x = 125;
    int y = 145;
    
    loadingView.frame = CGRectMake(x, y, width, height);
	
    
    //Add activity indicator icon
    UIActivityIndicatorView *activityIndicatorView =[[UIActivityIndicatorView alloc]
                                                     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[loadingView addSubview:activityIndicatorView];
    
	[activityIndicatorView startAnimating];

     
    //Position activity monitor
	CGRect activityIndicatorRect = activityIndicatorView.frame;
	activityIndicatorRect.origin.x = (width/2) - (activityIndicatorRect.size.width/2);
	activityIndicatorRect.origin.y = (height/2) - (activityIndicatorRect.size.height/2);
	activityIndicatorView.frame = activityIndicatorRect;
	
	// Set up the fade-in animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
    [[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
	
    DLog(@"LoadingView: Setting parent view to disabled");
    [aSuperview setUserInteractionEnabled:NO];
    DLog(@"Done");
     
	return loadingView;
}

//
// removeView
//
// Animates the view out from the superview. As the view is removed from the
// superview, it will be released.
//
- (void)removeView
{
	UIView *aSuperview = [self superview];
	//[super removeFromSuperview]; not trusted as we see some view leaks (residual loading views even though user interaction has been enabled!!

    [self removeAllOfMeFromSuperView:aSuperview];    
    
	// Set up the animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	
	[[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
    
    [aSuperview setUserInteractionEnabled:YES];
}

- (void) removeAllOfMeFromSuperView:(UIView *) superView {
    if (!superView) return;
    
    NSMutableArray *loadviewList = [[NSMutableArray alloc] init];
    
    for (UIView *suspectedLoadingView in superView.subviews) {
        if ([suspectedLoadingView isKindOfClass:[LoadingView class]]) {
            LoadingView *establishedLoadingView = (LoadingView *) suspectedLoadingView;
            
            [loadviewList addObject:establishedLoadingView];
        }
    }
    
    DLog(@"Removing %d instances of loading view...", [loadviewList count]);
    
    for (LoadingView *loadingView in loadviewList) {
        [loadingView removeFromSuperview];
    }
}


//
// drawRect:
//
// Draw the view.
//
- (void)drawRect:(CGRect)rect
{

    
	rect.size.height -= 1;
	rect.size.width -= 1;
	
	const CGFloat RECT_PADDING = 8.0;
	rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);
    
	const CGFloat ROUND_RECT_CORNER_RADIUS = 5.0;
    
	CGPathRef roundRectPath = CreatePathWithRoundRect(rect, ROUND_RECT_CORNER_RADIUS);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
    
	const CGFloat BACKGROUND_OPACITY = 0.85;
	CGContextSetRGBFillColor(context, 0, 0, 0, BACKGROUND_OPACITY);
	CGContextAddPath(context, roundRectPath);
	CGContextFillPath(context);
    
	const CGFloat STROKE_OPACITY = 0.25;
	CGContextSetRGBStrokeColor(context, 1, 1, 1, STROKE_OPACITY);
     
	CGContextStrokePath(context);

	CGPathRelease(roundRectPath);
     

}
    



@end
