//
//  MessageThreadViewController.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 8/04/13.
//
//

#import "BaseCommsViewController.h"

@interface MessageThreadViewController : BaseCommsViewController {
    NSInteger selectedMessageIndex;
}

-(id) initWithCommandObject: (id<GUIRestDeligate>) commandObj job:(MMJobDetail*) initJob
       selectedMessageIndex:(NSInteger)initSelectedMessageIndex;

@end
