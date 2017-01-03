//
//  JobItemSummaryTableViewCell.m
//  MeeMeepMobile
//
//  Created by Julian Raff on 18/02/13.
//
//

#import "JobItemSummaryTableViewCell.h"

@implementation JobItemSummaryTableViewCell

-(void)populate:(MMJobItem*)item
{
    //.text = item.description;
    _descriptions.text = item.description;
    NSMutableString* dimensions = [[NSMutableString alloc]init];
    if(item.length != nil && item.width != nil && item.height != nil)
    {
        [dimensions appendFormat:@"%@ x %@ x %@%@", item.length, item.width, item.height, item.dimensionsUnit];
        [dimensions appendString:@"   "];
    }
    if(item.weight != nil)
    {
        [dimensions appendString:[item.weight stringValue]];
        if(item.weightUnit != nil)
        {
            [dimensions appendFormat:@" %@", item.weightUnit];
        }
        else
        {
            [dimensions appendString:@" kg"];
        }
    }
    _dimensions.text = dimensions;
    
    if(item.photoId == nil)
    {
        [self setAccessoryType:UITableViewCellAccessoryNone];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else
    {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [self setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
}


@end
