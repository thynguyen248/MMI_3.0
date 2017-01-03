//
//  AusPostUtil.m
//  MeeMeepMobile
//
//  Created by Le Do Truong An on 9/30/14.
//
//

#import "AusPostUtil.h"
#import "GUICommon.h"
@implementation AusPostUtil
+(NSString*)getPostCodeFromLocation:(NSString *)location
{
    
    NSArray* locationSeparate = [location componentsSeparatedByString:@","];
    NSString* state = locationSeparate[1] ;
    state = [state substringFromIndex:1];
    NSString* newUrl = [NSString stringWithFormat:AusMapsUrl,locationSeparate[0],state];
    NSURL *url = [NSURL URLWithString: newUrl];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:aupostAPI forHTTPHeaderField:@"AUTH-KEY"];
    NSError* error;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if(response!=nil&&response.length>0)
    {
        NSError* error;
        NSDictionary* parsing =[NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
        if(error==nil)
        {
            NSDictionary* locations = [parsing objectForKey:@"localities"];
            if (locations!=nil&&locations.count>0) {
                NSArray* locals = [locations objectForKey:@"locality"];
                if(locals!=nil&&locals.count>0)
                {
                    for (NSDictionary* item in locals) {
                        NSString* q = [item objectForKey:@"location"];
                        NSString* state = [item objectForKey:@"state"];
                        if([q compare:locationSeparate[0]]&&[state compare:locationSeparate[1]])
                        {
                            return [item objectForKey:@"postcode"];
                        }
                    }
                }
            }
        }
    }
    return @"";
   // return response;
}
@end
