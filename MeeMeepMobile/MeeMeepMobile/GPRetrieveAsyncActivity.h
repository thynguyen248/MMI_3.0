//
//  GPRetrieveAsyncActivity.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 14/02/13.
//
//

#import <Foundation/Foundation.h>
#import "MMAsyncActivity.h"
#import "GPClient.h"

@interface GPRetrieveAsyncActivity : MMAsyncActivity {
    
}

-(id) initWithActivityDelegate:(id<MMAsyncActivityDelegate>)d location:(NSString*) initLocation
                        client:(GPClient *) initClient;

@property (nonatomic, strong) GPClient* client;
@property (nonatomic, strong) NSString* location;

@end
