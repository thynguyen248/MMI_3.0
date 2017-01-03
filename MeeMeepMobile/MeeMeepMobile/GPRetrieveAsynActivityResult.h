//
//  GPRetrieveAsynActivityResult.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 14/02/13.
//
//

#import <Foundation/Foundation.h>
#import "MMAsyncActivity.h"

@interface GPRetrieveAsynActivityResult :  NSObject<MMAsyncActivityResult> {
}

@property (nonatomic, strong) NSArray* results;

@end
