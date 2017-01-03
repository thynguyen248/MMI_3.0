//
//  JobItemSummaryTableViewCell.h
//  MeeMeepMobile
//
//  Created by Julian Raff on 18/02/13.
//
//

#import <UIKit/UIKit.h>
#import "MMJobItem.h"

@interface JobItemSummaryTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dimensions;
//@property (strong, nonatomic) IBOutlet UILabel *weight;
//@property (strong, nonatomic) IBOutlet UIImageView *thumbnail;
@property (strong, nonatomic) IBOutlet UILabel *descriptions;

-(void)populate:(MMJobItem*)item;

@end
