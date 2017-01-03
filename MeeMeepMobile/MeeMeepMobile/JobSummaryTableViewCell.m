//
//  JobSummaryTableViewCell.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 1/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "JobSummaryTableViewCell.h"

#import "GUICommon.h"

@implementation JobSummaryTableViewCell

@synthesize jobSummary;

@synthesize labelTitle;
@synthesize labelDropoffAddress;
@synthesize labelDropoffDate;
@synthesize labelPickupAddress;
@synthesize labelPickupDate;
@synthesize labelTimeLeft;

const int ADDRESS_DATE_INNER_PADDING = 4;
const int ADDRESS_DATE_WIDTH = 270;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1]];
    [self setSelectedBackgroundView:bgColorView];
}

-(void) update
{
    labelTitle.text = [GUICommon formatForString:jobSummary.title];
    
    labelPickupAddress.text = [GUICommon formatForString:jobSummary.fromLocation.address];
    labelDropoffAddress.text = [GUICommon formatForString:jobSummary.toLocation.address];
    
    labelPickupDate.text = [GUICommon formatDate:jobSummary.pickupDate];
    labelDropoffDate.text = [GUICommon formatDate:jobSummary.deliveryDate];
    
    [JobSummaryTableViewCell sizeAddress:labelPickupAddress andDate:labelPickupDate];
    [JobSummaryTableViewCell sizeAddress:labelDropoffAddress andDate:labelDropoffDate];
    
    @try {
        NSString* status = [GUICommon formatForString:jobSummary.jobStatus.displayableString];
        
        NSString* value;
        
        BOOL timeShown = false;
        
        if ([jobSummary.jobStatus is:JOB_CREATED])
        {
            if (jobSummary.expiryDate != nil)
            {
                NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                NSDateComponents *components = [calendar components:NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit
                                                           fromDate:[NSDate date]
                                                             toDate:jobSummary.expiryDate
                                                            options:0];
                
                if ([GUICommon isValidTimeLeftDays:components.day hours:components.hour minutes:components.minute]){
                    timeShown = true;
                    
                    value = [NSString stringWithFormat:@"%@ remaining",[GUICommon timeStringForJobDays:[components day]
                                                                                                 hours:[components hour]
                                                                                               minutes:[components minute]]];
                }
                else
                {
                    status = @"Expired";
                }
            }
        }
        
        if (timeShown==false) value = status;
        
        
        labelTimeLeft.text = value;
    }
    @catch (NSException *exception) {
        labelTimeLeft.text = @"";
    }
    
    if([jobSummary.jobStatus is:JOB_CREATED])
    {
        // jobs that can be bid on
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[GUICommon getColourActiveJobs]];
        [self setBackgroundView:bgColorView];
    }
    else
    {
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[GUICommon getColourNonActiveJobs]];
        [self setBackgroundView:bgColorView];
    }
}

+(void) sizeAddress:(UILabel*)addressLabel andDate:(UILabel*)dateLabel
{
    // Size the labels to fit all the text
    [addressLabel sizeToFit];
    [dateLabel sizeToFit];
    
    int combinedWidth = addressLabel.frame.size.width + ADDRESS_DATE_INNER_PADDING + dateLabel.frame.size.width;
    if(combinedWidth > ADDRESS_DATE_WIDTH)
    {
        // If they're too wide, shrink the address label
        addressLabel.frame = CGRectMake(addressLabel.frame.origin.x,
                                        addressLabel.frame.origin.y,
                                        ADDRESS_DATE_WIDTH - ADDRESS_DATE_INNER_PADDING - dateLabel.frame.size.width,
                                        addressLabel.frame.size.height);
    }
    
    // Move the date label to sit nicely next to the address label
    int dateLabelLeft = addressLabel.frame.origin.x + addressLabel.frame.size.width + ADDRESS_DATE_INNER_PADDING;
    dateLabel.frame = CGRectMake(dateLabelLeft, dateLabel.frame.origin.y, dateLabel.frame.size.width, dateLabel.frame.size.height);
}

@end
