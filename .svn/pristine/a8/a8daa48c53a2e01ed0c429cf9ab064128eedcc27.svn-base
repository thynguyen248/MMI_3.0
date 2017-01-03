//
//  MMItem.h
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 7/02/13.
//
//

#import <Foundation/Foundation.h>
#import "MMObject.h"

@interface MMJobItem : NSObject<MMObject> {
    Boolean hasImage;
}

+ (MMJobItem *) getJobItemForDictionary:(NSDictionary *) dictionary;
+ (NSDictionary *) dictionaryFromJobItem:(MMJobItem *) jobDetail;

@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSNumber *height;
@property (strong, nonatomic) NSNumber *width;
@property (strong, nonatomic) NSNumber *length;
@property (strong, nonatomic) NSString *dimensionsUnit;
@property (strong, nonatomic) NSNumber *weight;
@property (strong, nonatomic) NSString *weightUnit;

@property (strong, nonatomic) NSNumber *itemId;
@property (strong, nonatomic) NSNumber *photoId;

@end

