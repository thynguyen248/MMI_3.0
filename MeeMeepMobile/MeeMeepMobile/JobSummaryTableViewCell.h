//
//  JobSummaryTableViewCell.h
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 1/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MMJobSummary.h"


@interface JobSummaryTableViewCell : UITableViewCell{
    MMJobSummary* jobSummary;
}

@property (nonatomic, retain) IBOutlet UILabel* labelTitle;
@property (nonatomic, strong) IBOutlet UILabel* labelPickupAddress;
@property (nonatomic, strong) IBOutlet UILabel* labelPickupDate;

@property (nonatomic, strong) IBOutlet UILabel* labelDropoffAddress;
@property (nonatomic, retain) IBOutlet UILabel* labelDropoffDate;
@property (nonatomic, retain) IBOutlet UILabel* labelTimeLeft;

@property (nonatomic, strong) MMJobSummary* jobSummary;

-(void) update;

@end
