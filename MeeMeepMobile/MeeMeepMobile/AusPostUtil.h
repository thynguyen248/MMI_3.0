//
//  AusPostUtil.h
//  MeeMeepMobile
//
//  Created by Le Do Truong An on 9/30/14.
//
//

#import <Foundation/Foundation.h>

@interface AusPostUtil : NSObject
#define AusMapsUrl @"https://auspost.com.au/api/postcode/search.json?q=%@&state=%@"
#define aupostAPI @"e5262be7-29d8-4507-9b68-48393167bc6d"
+(NSString*) getPostCodeFromLocation:(NSString*)location;

@end
