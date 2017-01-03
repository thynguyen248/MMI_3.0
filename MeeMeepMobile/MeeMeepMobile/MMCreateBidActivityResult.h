//
//  MMCreateBidActivityResult.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMAsyncActivityResult.h"

enum MMAsyncBidCreateResultEnum {
    MMAsyncBidCreateResultFailure = 0,
    MMAsyncBidCreateResultBankAccountNotRegistered = 1,
    MMAsyncBidCreateResultSuccess = 2,
    MMAsyncBidCreateResultUndefined = 3
};

typedef enum MMAsyncBidCreateResultEnum MMAsyncBidCreateResult;

@interface MMCreateBidActivityResult : NSObject<MMAsyncActivityResult> {
    MMAsyncBidCreateResult bidCreateStatus;
}

@property (assign, nonatomic) MMAsyncBidCreateResult bidCreateStatus;

@end
