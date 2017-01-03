//
//  MMRestHttpRequestActivity.h
//  MeeMeepMobile
//
//  Created by Greg Soertsz on 26/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMAsyncActivity.h"
#import "MMRestHttpResponse.h"

@interface MMRestHttpRequestActivity : MMAsyncActivity <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    NSMutableURLRequest *request;
    MMRestHttpResponse *response;
    NSError *requestError;
    NSMutableData *receivedData;
    BOOL requestCompleted;
    NSURLConnection *connection;
    NSUInteger requestTimeout;
    
    //NSUInteger _requestDurationSeconds;
    NSDate *_expectedRequestCompletionDate;
}
    
@property (strong, nonatomic) NSMutableURLRequest *request;
@property (strong, nonatomic) MMRestHttpResponse *response;
@property (strong, nonatomic) NSError *requestError;
@property (strong, nonatomic) NSMutableData *receivedData;
@property (assign, nonatomic) BOOL requestCompleted;
@property (strong, nonatomic) NSURLConnection *connection;
@property (assign, nonatomic) NSUInteger requestTimeout;

- (void) httpTimerExpired;
- (id) initWithRequest:(NSMutableURLRequest *)req andTimeout:(NSUInteger) timeout;
- (void) connectionLoadingComplete;

@end
