//
//  GUICommon.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 13/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "GUICommon.h"

@implementation GUICommon

//Change table view cell self to tableview

+ (AspectRatio) getDeviceAspectRatio {
    UIScreen* mainScreen = [UIScreen mainScreen];
    CGFloat aspect = ((CGFloat)mainScreen.bounds.size.height) /
    ((CGFloat)mainScreen.bounds.size.width);
    
    //Pre iPhone 5 ratio
    if(aspect == 1.5) {
        return PRE_IPHONE_5;
    } else {
        return IPHONE_5;
    }
}

+ (NSTimeInterval) getKeyboardAnimationTime:(NSNotification*) notification {
    NSDictionary* info = [notification userInfo];
    NSValue* value = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval duration = 0;
    [value getValue:&duration];
    return duration;
}

+(JobItemSummaryTableViewCell*) getJobItemSummaryTableViewCell:(UITableView*) tableView
{
    NSString* cellClassName=@"JobItemSummaryTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    JobItemSummaryTableViewCell* cell;
    //Just for Testing
  //  NSString *ver = [[UIDevice currentDevice] systemVersion];
   // float ver_float = [ver floatValue];
//if(ver_float < 7.0 )
   // {
           cell = (JobItemSummaryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
        //End of trying source code
        if (!cell)
        {
            NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
            cell = [topLevelItems objectAtIndex:0];
        }
 /*   }else{
        cell =[[JobItemSummaryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellClassName];
    }*/

    
    return cell;
}

+(SegmentedTableHeader*) getSegmentedTableHeader:(UITableView*) tableView
{
    NSString* cellClassName=@"SegmentedTableHeader";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    SegmentedTableHeader* cell;
    
    cell = (SegmentedTableHeader*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    
    return cell;
}


+( KeyValueTableViewCell*) getKeyValueTableViewCell: (UITableView*) tableView{
    
    NSString* cellClassName=@"KeyValueTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    KeyValueTableViewCell* cell;     
    
    cell = (KeyValueTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    
    return cell;
}


+(MyTableViewCell*) getMyTableViewCell: (UITableView*) tableView{
    
    NSString* cellClassName=@"MyTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    MyTableViewCell* cell;     
    
    cell = (MyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    
    return cell;
}



+(RatingTableViewCell*) getRatingTableViewCell: (UITableView*) tableView{
    
    NSString* cellClassName=@"RatingTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    RatingTableViewCell* cell;     
    
    cell = (RatingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    
    return cell;
}

+(CustomTableViewCell*) getCustomTableViewCell: (UITableView*) tableView {
    
    NSString* cellClassName=@"CustomTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    CustomTableViewCell* cell = nil;    
    cell = (CustomTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    return cell;
}



+(LargeKeyValueTableViewCell*) getLargeKeyValueTableViewCell: (UITableView*) tableView{
    
    NSString* cellClassName=@"LargeKeyValueTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    LargeKeyValueTableViewCell* cell;     
    
    cell = (LargeKeyValueTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    
    return cell;
}

+(LargeEditableKeyValueTableViewCell*) getLargeEditableKeyValueTableViewCell: (UITableView*) tableView{
    
    NSString* cellClassName=@"LargeEditableKeyValueTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    LargeEditableKeyValueTableViewCell* cell;     
    
    cell = (LargeEditableKeyValueTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    
    return cell;
}


+(BidsButtonTableViewCell*) getBidsButtonTableViewCell: (UITableView*) tableView{
    
    NSString* cellClassName=@"BidsButtonTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    BidsButtonTableViewCell* cell;     
    
    cell = (BidsButtonTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    return cell;
}


+(KeyValueTableViewCell_TA*) getKeyValueTableViewCell_TA: (UITableView*) tableView{
    
    NSString* cellClassName=@"KeyValueTableViewCell_TA";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    KeyValueTableViewCell_TA* cell;     
    
    cell = (KeyValueTableViewCell_TA*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    
    return cell;
}


+(DoubleKeyValueTableViewCell*) getDoubleKeyValueTableViewCell: (UITableView*) tableView{
    
    NSString* cellClassName=@"DoubleKeyValueTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    DoubleKeyValueTableViewCell* cell;     
    cell = (DoubleKeyValueTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    
    return cell;
}

+(BidSummaryTableViewCell*) getBidSummaryTableViewCell: (UITableView*) tableView{
    NSString* cellClassName=@"BidSummaryTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    BidSummaryTableViewCell* cell;     
    cell = (BidSummaryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    return cell;
}


+(JobSummaryTableViewCell*) getJobSummaryTableViewCell: (UITableView*) tableView{
    NSString* cellClassName=@"JobSummaryTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    JobSummaryTableViewCell* cell = nil;     
    cell = (JobSummaryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    return cell;
}


+(EditableTableViewCell*) getEditableTableViewCell: (UITableView*) tableView{
    
    NSString* cellClassName=@"EditableTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    EditableTableViewCell* cell;     
    
    cell = (EditableTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    
    return cell;
}


+(EditableKeyValueTableViewCell*) getEditableKeyValueTableViewCell: (UITableView*) tableView{
    
    NSString* cellClassName=@"EditableKeyValueTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    EditableKeyValueTableViewCell* cell;     
    
    cell = (EditableKeyValueTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    
    return cell;
}


+(WrappingKeyValueTableViewCell*) getWrappingKeyValueTableViewCell: (UITableView*) tableView{
    NSString* cellClassName=@"WrappingKeyValueTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    WrappingKeyValueTableViewCell* cell;     
    
    cell = (WrappingKeyValueTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    
    return cell;
}

+(StyledKeyValueTableViewCell*) getStyledKeyValueTableViewCellDontCache: (UITableView*) tableView{
    DLog(@"getStyledKeyValueTableViewCell");
    
    NSString* cellClassName=@"StyledKeyValueTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
    
    StyledKeyValueTableViewCell* cell = [topLevelItems objectAtIndex:0];
    
    return cell;
}

+(StyledKeyValueTableViewCell*) getStyledKeyValueTableViewCell: (UITableView*) tableView{
    DLog(@"getStyledKeyValueTableViewCell");
    
    NSString* cellClassName=@"StyledKeyValueTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    StyledKeyValueTableViewCell* cell;     
    
    cell = (StyledKeyValueTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    
    return cell;
}


+(StyledKeyValueMultilineTableViewCell*) getStyledKeyValueMultilineTableViewCell: (UITableView*) tableView{
    NSString* cellClassName=@"StyledKeyValueMultilineTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    StyledKeyValueMultilineTableViewCell* cell;     
    
    cell = (StyledKeyValueMultilineTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    
    return cell;
}


+(CommSummaryTableViewCell*) getCommSummaryTableViewCell: (UITableView*) tableView{
    NSString* cellClassName=@"CommSummaryTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    CommSummaryTableViewCell* cell;     
    
    //cell = (CommSummaryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    //if (!cell)
    //{
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    //}
    
    return cell;
}


+(ConversationSummaryTableViewCell*) getConversationSummaryTableViewCell: (UITableView*) tableView {
    NSString* cellClassName=@"ConversationSummaryTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    
    ConversationSummaryTableViewCell* cell;     
    
    cell = (ConversationSummaryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    
    return cell;
}




+(MessageTableViewCell*) getMessageTableViewCell: (UITableView*) tableView{
    NSString* cellClassName=@"MessageTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    MessageTableViewCell* cell;     
    cell = (MessageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    return cell;
}



+(BidsMessagesLinkerTableViewCell*) getBidsMessagesLinkerTableViewCell: (UITableView*) tableView{
    NSString* cellClassName=@"BidsMessagesLinkerTableViewCell";
    UINib* cellLoader = [UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]];
    BidsMessagesLinkerTableViewCell* cell;     
    cell = (BidsMessagesLinkerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:tableView options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    return cell;
}


+(id) displayForNull: (id) value displayThisInstead:(id) somethingElse {
    if (value == nil) return somethingElse;
    else {
        if ([value isKindOfClass:[NSNull class]]) {
            return somethingElse;
        } else {
            return value;
        }
    }
}



+(NSString*) formatForString: (id) value{
    if (value==nil) return @"";
    else{
        if ([value isKindOfClass:[NSString class]]) return value;
        else
        if ([value isKindOfClass:[NSNumber class]]) return [(NSNumber*)value stringValue];
        else return @"";
    }
}


+(NSNumber*) formatForNumber: (id) value{
    if (value==nil) return [[NSNumber alloc] initWithInt:0];
    else{
        if ([value isKindOfClass:[NSNumber class]]) return value;
        else
        if ([value isKindOfClass:[NSString class]]){
            NSNumber* tmp;
            @try {tmp = [[NSNumber alloc] initWithDouble: [(NSString*)value doubleValue]];}
            @catch (NSException *exception) {tmp = [[NSNumber alloc] initWithInt:0];}
            return tmp;
        }
        else return [[NSNumber alloc] initWithInt:0];
    }
}

+(NSString*) formatNumber:(NSNumber*)number withRounding:(NSUInteger)rounding
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:rounding];
    [formatter setRoundingMode: NSNumberFormatterRoundHalfUp];
    
    return [GUICommon formatForString:[formatter stringFromNumber:number]];
}

+(NSString*) formatCurrency: (NSNumber*) value{
    /*https://developer.apple.com/library/ios/#DOCUMENTATION/StoreKit/Reference/SKProduc
     t_Reference/Reference/Reference.html#//apple_ref/occ/instp/SKProduct/priceLocale*/    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:[NSLocale currentLocale]];
    return [numberFormatter stringFromNumber:value];
}


+(NSString*) formatDate: (NSDate*) value{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return [dateFormatter stringFromDate:value];
}


+(BOOL) isValidState: (NSString*) stateName{
    stateName = [stateName uppercaseString];
    if (
        ([stateName isEqualToString:@"NSW"])||
        ([stateName isEqualToString:@"ACT"])||
        ([stateName isEqualToString:@"VIC"])||
        ([stateName isEqualToString:@"QLD"])||
        ([stateName isEqualToString:@"SA"])||
        ([stateName isEqualToString:@"WA"])||
        ([stateName isEqualToString:@"TAS"])||
        ([stateName isEqualToString:@"NT"])||
        ([stateName isEqualToString:@"NEW SOUTH WHALES"])||
        ([stateName isEqualToString:@"AUSTRALIAN CAPITAL TERRITORY"])||
        ([stateName isEqualToString:@"VICTORIA"])||
        ([stateName isEqualToString:@"QUEENSLAND"])||
        ([stateName isEqualToString:@"SOUTH AUSTRALIA"])||
        ([stateName isEqualToString:@"WESTERN AUSTRALIA"])||
        ([stateName isEqualToString:@"TASMANIA"])||
        ([stateName isEqualToString:@"NORTHERN TERRITORY"])
        )
    {
        return true;
    } else return true;
}

+(BOOL) isNumber: (NSString*) numberString{
    @try {
        [numberString intValue];
    }
    @catch (NSException *exception) {
        return false;
    }    
    return true;
}


+(BOOL) isValidPostCode: (NSString*) postCode forState:(NSString *) stateName { 
    /*
     NSW     1000-2599, 2619-2898, 2921-2999     (1*** 2***)
     ACT     0200-0299, 2600-2618, 2900-2920     (0*** & 2***)
     VIC     3000-3999, 8000-8999                (3*** & 8***)
     QLD     4000-4999, 9000-9999                (4*** & 9***)
     SA      5000-5799, 5800-5999                (5***)
     WA      6000-6797, 6800-6999                (6***)
     TAS     7000-7799, 7800-7999                (7***)
     NT      0800-0899, 0900-0999                (0***)
    */
    
    stateName = [stateName uppercaseString];

    
    if ([self isValidState:stateName]){
        
        if ([self isNumber:postCode]==true){
            
            if (postCode.length==4){
                
                NSInteger startInt = [[postCode substringToIndex:1] intValue];
    
                
                DLog(@"postCode:%@ stateName:%@ startInt: %d", postCode, stateName, startInt);
                
                //Check if starting digit matches state
                if (([stateName isEqualToString:@"NSW"])||([stateName isEqualToString:@"NEW SOUTH WHALES"])){
                    if ((startInt==1)||(startInt==2)) return true;
                    else return false;
                } else
                if (([stateName isEqualToString:@"ACT"])||([stateName isEqualToString:@"AUSTRALIAN CAPITAL TERRITORY"])){
                    if ((startInt==0)||(startInt==2)) return true;
                    else return false;
                } else
                if (([stateName isEqualToString:@"VIC"])||([stateName isEqualToString:@"VICTORIA"])){
                    if ((startInt==3)||(startInt==8)) return true;
                    else return false;
                } else
                if (([stateName isEqualToString:@"QLD"])||([stateName isEqualToString:@"QUEENSLAND"])){
                    if ((startInt==4)||(startInt==9))return true;
                    else return false;
                } else
                if (([stateName isEqualToString:@"SA"])||([stateName isEqualToString:@"SOUTH AUSTRALIA"])){
                    if (startInt==5) return true;
                    else return false;
                } else
                if (([stateName isEqualToString:@"WA"])||([stateName isEqualToString:@"WESTERN AUSTRALIA"])){
                    if (startInt==6) return true;
                    else return false;
                } else
                if (([stateName isEqualToString:@"TAS"])||([stateName isEqualToString:@"TASMANIA"])){
                    if (startInt==7) return true;
                    else return false;
                } else
                if (([stateName isEqualToString:@"NT"])||([stateName isEqualToString:@"NORTHERN TERRITORY"])){
                    if (startInt==0) return true;
                    else return false;
                } else{
                    //Invalid state
                    return false;
                }   
    
            } else return false;
        } else return false;
    } else return false;

}

+ (NSString *) addressStringForMMJobAddress:(MMJobAddress *) address {
    if (address == nil) return nil;
    
    BOOL u = (address.unitNumber != nil);
    BOOL sn = (address.streetNumber != nil);
    BOOL sname = (address.streetName != nil);
    BOOL st = (address.streetType != nil);
    BOOL sub = (address.suburb != nil);
    BOOL state = (address.state != nil);
    BOOL pc = (address.postCode != nil);
    BOOL c = (address.country != nil);
    
    // (u)/(sn) sname stype?, suburb, state, postcode, country?
    
    NSString *builtString = @"";
    builtString = [builtString stringByAppendingString:((u) ? address.unitNumber: @"")];
    builtString = [builtString stringByAppendingString:((u) ? @"/" : @"")];
    builtString = [builtString stringByAppendingString:((sn) ? address.streetNumber : @"")];
    builtString = [builtString stringByAppendingString:((sn && (st || sname || sub || state || pc || c)) ? @" " : @"")];
    builtString = [builtString stringByAppendingString:((sname) ? address.streetName : @"")];
    builtString = [builtString stringByAppendingString:((sname && st) ? @" " : @"")];

    builtString = [builtString stringByAppendingString:((st) ? address.streetType : @"")];
    
    builtString = [builtString stringByAppendingString:(((u || sname || sn || st) && (sub || state || pc || c)) ? @", " : @"")];
    
    builtString = [builtString stringByAppendingString:((sub) ? address.suburb : @"")];
    builtString = [builtString stringByAppendingString:((sub && (state || pc || c)) ? @", " : @"")];
    builtString = [builtString stringByAppendingString:((state) ? address.state : @"")];
    builtString = [builtString stringByAppendingString:((state && (pc || c)) ? @", " : @"")];
    builtString = [builtString stringByAppendingString:((pc) ? address.postCode : @"")];
    builtString = [builtString stringByAppendingString:((pc && c) ? @", " : @"")];
    builtString = [builtString stringByAppendingString:((c) ? address.country : @"")];

    return builtString;
}

+(NSString*) specialInformationStringForJobDetail:(MMJobDetail*) job{
    if (job == nil) return nil;
    
    NSMutableString* specCons = [NSMutableString stringWithCapacity:5];
    for (NSString* sc in job.specialConsiderations)
    {
        if([specCons length] != 0)
        {
            [specCons appendString:@", "];
        }
        [specCons appendString:sc];
    }
    
    return specCons;
}


+ (NSString *) timeStringForJobDays:(NSInteger)days hours:(NSInteger)hours minutes:(NSInteger)minutes {
    
    BOOL dg0 = days > 0;
    BOOL hg0 = hours > 0;
    BOOL mg0 = minutes > 0;
    
    BOOL dg1 = (days > 1);
    BOOL hg1 = (hours > 1);
    BOOL mg1 = (minutes > 1);
    
    if (!dg0 && !hg0 && !mg0) return nil;
    
    NSString *daysString = [NSString stringWithFormat:@"%d", days];
    NSString *hoursString = [NSString stringWithFormat:@"%d", hours];
    NSString *minutesString = [NSString stringWithFormat:@"%d", minutes];
    
    // d day(s), h hour(s), m minute(s)
   
    NSString *builtString = @"";
    builtString = [builtString stringByAppendingString:((dg0) ? daysString : @"")];
    builtString = [builtString stringByAppendingString:((dg0) ? @" day" : @"")];
    builtString = [builtString stringByAppendingString:((dg1) ? @"s" : @"")];

    builtString = [builtString stringByAppendingString:((dg0 && (hg0 || mg0)) ? @" " : @"")];
    
    builtString = [builtString stringByAppendingString:((hg0) ? hoursString : @"")];
    builtString = [builtString stringByAppendingString:((hg0) ? @" hour" : @"")];
    builtString = [builtString stringByAppendingString:((hg1) ? @"s" : @"")];
    
    builtString = [builtString stringByAppendingString:((hg0 && mg0) ? @" " : @"")];

    builtString = [builtString stringByAppendingString:((mg0) ? minutesString : @"")];
    builtString = [builtString stringByAppendingString:((mg0) ? @" minute" : @"")];
    builtString = [builtString stringByAppendingString:((mg1) ? @"s" : @"")];

    return builtString;

}


+(NSString*) jobTitleForAddress:(MMJobAddress*) address{
    return [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@",
                             [GUICommon formatForString:address.streetNumber],
                             [GUICommon formatForString:address.streetName],
                             [GUICommon formatForString:address.suburb],
                             [GUICommon formatForString:address.state],
                             [GUICommon formatForString:address.postCode],
                             [GUICommon formatForString:address.country]
                             ];
    
}


+(BOOL) isValidTimeLeftDays:(NSInteger)days hours:(NSInteger)hours minutes: (NSInteger)minutes{
    
    if ((days<0) || (hours<0) || (minutes<0)) 
        return false;
    else if ((days>0)||(hours>0)||(minutes>0)) 
        return true; 
    else 
        return false;
}




+(UIColor*) MeeMeepTableCellGreyColor{
    return [UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1];
}


+(UIColor*) MeeMeepBackgroundGreyColor{
    return [UIColor colorWithRed:59/255.0f green:59/255.0f blue:59/255.0f alpha:1];
}

+(NSDate*) getDate:(NSDate*)date AfterDays: (NSInteger) days {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* dateComponents = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    [dateComponents setDay:dateComponents.day + days];
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

+(NSDate*) getDate:(NSDate*)date AfterMonths: (NSInteger) months {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* dateComponents = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    [dateComponents setMonth:dateComponents.month + months];
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

+(NSDate*) getDate:(NSDate*)date AfterYears: (NSInteger) years{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* dateComponents = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    [dateComponents setYear:dateComponents.year+1];
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}



+(NSDate*) getNextHalfHour:(NSDate*)date{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* dateComponents = [calendar components:NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:date];
    
    if (dateComponents.minute>30){
        [dateComponents setMinute:0];
        [dateComponents setHour:dateComponents.hour+1];
    } else{
        [dateComponents setMinute:30];
        [dateComponents setHour:dateComponents.hour];
    }
     
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

+(BOOL)isOwnerOfJob:(MMJobDetail*)jobDetail accessToken:(MMRestAccessToken*)accessToken {
    if (accessToken == nil || jobDetail.userId == nil) {
        return false;
    }
    return [jobDetail.userId isEqualToNumber:accessToken.userId];
}

+(BOOL)isWinningBidderOfJob:(MMJobDetail*)jobDetail accessToken:(MMRestAccessToken*)accessToken {
    if (accessToken == nil || jobDetail.winningBidderId == nil)
    {
        return false;
    }
    return [jobDetail.winningBidderId isEqualToNumber:accessToken.userId];
}



+(BOOL)containsMyBid:(NSArray*) bidSummaries accessToken:(MMRestAccessToken*)accessToken{

    for (MMBidSummary* bid in bidSummaries)
        if ((bid) && (accessToken)) if ([bid.userId isEqualToNumber:accessToken.userId]) return YES;
    return NO;
}


+(BOOL)isMyBid:(MMBidDetail*)bidDetail accessToken:(MMRestAccessToken*)accessToken {
    DLog(@"Bid Detail - bidId.userId %@",[bidDetail.userId stringValue]);
    DLog(@"Bid Detail - accesstoken.UserId %@",[accessToken.userId stringValue]);
    DLog(@"Bid Detail - bidId.username %@",bidDetail.userName);
    if (accessToken==nil) 
        return false; 
    else if ([[GUICommon formatForNumber:bidDetail.userId] isEqualToNumber:accessToken.userId])
        return true;
    else 
        return false;
}


+(BOOL) isMyMessage: (MMMessageDetail*) message accessToken:(MMRestAccessToken*) accessToken{
    if (accessToken==nil) return false; else{
        if ([message.userId intValue]==[accessToken.userId intValue]) return true;
        else return false;
    }
}

+(BOOL)isMyBidSummary:(MMBidSummary*)bidSummary accessToken:(MMRestAccessToken*)accessToken {
    DLog(@"Bid Summary - accesstoken.UserId %@",[accessToken.userId stringValue]);
    DLog(@"Bid Summary - bidId.username %@",bidSummary.userId);
    if (accessToken==nil) 
        return false; 
    else if ([[GUICommon formatForNumber:bidSummary.userId] isEqualToNumber:accessToken.userId])
        return true;
    else 
        return false;
}

+(UIActionSheet*)createActionSheetWithActions:(NSArray*)actionTitles delegate:(id<UIActionSheetDelegate>)delegate {
    if(actionTitles.count == 0) {
        return nil;
    }
    UIActionSheet* myActionSheet = [[UIActionSheet alloc] initWithTitle: nil delegate: delegate cancelButtonTitle:nil 
                                                 destructiveButtonTitle: nil otherButtonTitles: nil];
        
    for (NSString* buttonTitle in actionTitles)
        [myActionSheet addButtonWithTitle:buttonTitle];
    
    // cancel should be at the bottom, last;
    [myActionSheet addButtonWithTitle:@"Cancel"];
    [myActionSheet setCancelButtonIndex: [actionTitles count]];
    
    return myActionSheet;
}

// only returns active bids that you own
+(NSNumber*) getMyCurrentBidId:(NSArray*)bids accessToken:(MMRestAccessToken*)accessToken {
    @synchronized (bids) {
        for(MMBidSummary* bid in bids) {
            if([GUICommon isMyBidSummary:bid accessToken:accessToken] && [bid.status isEqualToString:@"Active"]) {
                return bid.bidId;
            }
        }
    }
    return nil;
}
    


//Estimates the height of text (with given font) when constrained to a width
+(CGFloat) heightOfText: (NSString*)text WithFont:(UIFont*)font ConstrainedToWidth:(CGFloat)width {
	CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, 999999)];
	return size.height + 10;
}


//Another way of estimating the height (hopefully responds better to new lines)
+(CGFloat) heightOfText2: (NSString*)text WithFont:(UIFont*)font ConstrainedToWidth:(CGFloat)width {
    UITextView* textView = [[UITextView alloc] init];
    [textView setFont:font];
    [textView setText:text];
    CGSize size = [textView sizeThatFits:CGSizeMake(width, 999999)];
	return size.height;
}


+ (void) renderButton:(UIButton *) button {
    button.layer.backgroundColor = [[button backgroundColor] CGColor];
    button.layer.cornerRadius = 8.0;
    //Colour
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = button.bounds;
    gradient.cornerRadius = button.layer.cornerRadius;
    UIColor* startColor = [UIColor cyanColor];
    UIColor* endColor = [UIColor blueColor];
    gradient.colors = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    //Border
    gradient.borderWidth = 1;
    gradient.borderColor = [[UIColor blackColor] CGColor];
    //Shadow
    //gradient.shadowColor = [UIColor blackColor].CGColor;
    //gradient.shadowOpacity = 0.5;
    //gradient.shadowRadius = 1;
    //gradient.shadowOffset = CGSizeMake(2.0f, 2.0f);
    //
    [button.layer insertSublayer:gradient atIndex:0];    
}

+ (void) renderButtonDown:(UIButton *) button {
    button.layer.backgroundColor = [[button backgroundColor] CGColor];
    button.layer.cornerRadius = 8.0;
    //Colour
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = button.bounds;
    gradient.cornerRadius = button.layer.cornerRadius;
    UIColor* startColor = [UIColor cyanColor];
    
    gradient.colors = [NSArray arrayWithObjects:(id)[startColor CGColor], nil];
    //Border
    gradient.borderWidth = 1;
    gradient.borderColor = [[UIColor blackColor] CGColor];
    //Shadow
    //gradient.shadowColor = [UIColor blackColor].CGColor;
    //gradient.shadowOpacity = 0.5;
    //gradient.shadowRadius = 1;
    //gradient.shadowOffset = CGSizeMake(2.0f, 2.0f);
    //
    [button.layer insertSublayer:gradient atIndex:0];    
}


+(UIColor*) MeeMeepHeadingText {
    // CCCCCC
    return [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];
}

+(UIColor*) MeeMeepBackground {
    // FAFAFA
    return [UIColor colorWithRed:250/255.0f green:250/255.0f blue:250/255.0f alpha:1];
}

+(UIColor*) MeeMeepActionText {
    return [GUICommon MeeMeepBlue];
}

+(UIColor*) MeeMeepWarningButton {
    return [GUICommon MeeMeepRed];
}

+(UIColor*) MeeMeepGoButton {
    return [GUICommon MeeMeepOrange];
}

+(UIColor*) MeeMeepActionButton {
    return [GUICommon MeeMeepOrange];
}

+(NSArray*) MeeMeepActionButtonGradient {
    return [NSArray arrayWithObjects:
            (id)[[GUICommon MeeMeepLightOrange] CGColor],
            (id)[[GUICommon MeeMeepOrange] CGColor],
            nil ];
}

+(NSArray*) MeeMeepActionButtonGradientHighlighted {
    return [NSArray arrayWithObjects:
            (id)[[GUICommon MeeMeepOrange] CGColor],
            (id)[[GUICommon MeeMeepLightOrange] CGColor],
            nil ];
}


+(UIColor*) MeeMeepBlue {
    return [UIColor colorWithRed:0/255.0f green:151/255.0f blue:207/255.0f alpha:1];
}

+(UIColor*) MeeMeepOrange {
    return [UIColor colorWithRed:220.0/255 green:94.0/255 blue:11.0/255 alpha:1.0];
}

+(UIColor*) MeeMeepLightOrange {
    return [UIColor colorWithRed:244.0/255 green:120.0/255 blue:38.0/255 alpha:1];
}

+(UIColor*) MeeMeepRed {
    return [UIColor colorWithRed:156.0/255 green:0.0/255 blue:1.0/255 alpha:1.0];
}


// CommSummaryTableViewCell
// ConversationSummaryTableViewCell
+(NSArray*) MeeMeepButtonGradientOrange{
    return [NSArray arrayWithObjects:
            (id)[[UIColor colorWithRed:255.0/255 green:173.0/255 blue:0.0/255 alpha:1.0] CGColor],
            (id)[[UIColor colorWithRed:255.0/255 green:173.0/255 blue:0.0/255 alpha:1.0] CGColor],
            (id)[[UIColor colorWithRed:234.0/255 green:154.0/255 blue:0.0/255 alpha:1.0] CGColor],
            (id)[[UIColor colorWithRed:214.0/255 green:135.0/255 blue:0.0/255 alpha:1.0] CGColor],
            nil ];
}

// CommSummaryTableViewCell
// ConversationSummaryTableViewCell
+(NSArray*) MeeMeepButtonGradientOrangeHighlighted{
    return [NSArray arrayWithObjects:
            (id)[[UIColor colorWithRed:234.0/255 green:154.0/255 blue:0.0/255 alpha:1.0] CGColor],
            (id)[[UIColor colorWithRed:255.0/255 green:173.0/255 blue:0.0/255 alpha:1.0] CGColor],
            (id)[[UIColor colorWithRed:255.0/255 green:173.0/255 blue:0.0/255 alpha:1.0] CGColor],
            nil ];
}

// CommSummaryTableViewCell
// CommunicationsViewController
// MyJobsViewController
+(NSArray*) MeeMeepButtonGradientGray {
    return [NSArray arrayWithObjects:
            (id)[[UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255 alpha:1.0] CGColor],
            (id)[[UIColor colorWithRed:180.0/255 green:180.0/255 blue:180.0/255 alpha:1.0] CGColor],
            (id)[[UIColor colorWithRed:140.0/255 green:140.0/255 blue:140.0/255 alpha:1.0] CGColor],
            nil ];
}

// CommunicationsViewController
+(NSArray*) MeeMeepButtonGradientGray2 {
    return [NSArray arrayWithObjects:
            (id)[[UIColor whiteColor] CGColor],
             (id)[[UIColor grayColor] CGColor],
            nil ];
}

// CommSummaryTableViewCell
+(NSArray*) MeeMeepButtonGradientGrayed{
    return [NSArray arrayWithObjects:
            (id)[[UIColor colorWithRed:209.0/255 green:209.0/255 blue:209.0/255 alpha:1.0] CGColor],
            (id)[[UIColor colorWithRed:181.0/255 green:181.0/255 blue:181.0/255 alpha:1.0] CGColor],
            (id)[[UIColor colorWithRed:158.0/255 green:158.0/255 blue:158.0/255 alpha:1.0] CGColor],
            nil];
}

// CommSummaryTableViewCell
+(NSArray*) MeeMeepButtonGradientGrayedHighlighted{
    return [NSArray arrayWithObjects:
            (id)[[UIColor colorWithRed:158.0/255 green:158.0/255 blue:158.0/255 alpha:1.0] CGColor],
            (id)[[UIColor colorWithRed:181.0/255 green:181.0/255 blue:181.0/255 alpha:1.0] CGColor],
            (id)[[UIColor colorWithRed:209.0/255 green:209.0/255 blue:209.0/255 alpha:1.0] CGColor],
            nil];
}

// CommunicationsViewController
+(NSArray*) MeeMeepButtonGradientGrayBar{
    return [NSArray arrayWithObjects:
            (id)[[UIColor colorWithRed:209.0/255 green:209.0/255 blue:209.0/255 alpha:1.0] CGColor],
            (id)[[UIColor colorWithRed:181.0/255 green:181.0/255 blue:181.0/255 alpha:1.0] CGColor],
            nil];
}

+(UIColor*) getColourNonActiveJobs{
    return [UIColor colorWithRed:234.0/255 green:234.0/255 blue:234.0/255 alpha:1.0];
}

+(UIColor*) getColourActiveJobs{
    return [UIColor colorWithRed:250.0/255 green:250.0/255 blue:250.0/255 alpha:1.0];
}

// get JUST the date components, with zero time values
+(NSDate*) stripTimeFromDate:(NSDate*)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit ) fromDate:date];
	[components setHour:0];
 	[components setMinute:0];
  	[components setSecond:0];
    return [[calendar dateFromComponents:components] dateByAddingTimeInterval:[[NSTimeZone localTimeZone]secondsFromGMT]];
}


+(NSDate*) stripMinutesAndSecondsFromDateTime:(NSDate*)date {
    if(date == nil) {
        return nil;
    }
    
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* components = [calendar components:flags fromDate:date];
    
    return [calendar dateFromComponents:components];
}



+(NSString*) getDateRangeFromDays:(NSInteger)days {
    
    
//    //Job DateRange options
//    if (days == 0)
//        return @"On this day";
//    else if (days == 1)
//        return @"Within 1 day of this day";
//    else if (days == 2)
//        return @"Within 2 days of this day";
//    else if (days == 4)
//        return @"Within 4 days of this day";
//    else if (days == 7)
//        return @"Within a week of this day";
//    else 
//        return nil;
    
    if (days == 0) {
        return @"On this day";
    } else if (days >= 7) {
        return @"Within a week of this day";
    } else {
        NSString *str = [NSString stringWithFormat:@"Within %d days of this day", days];
        return str;
    }
}


//Removes whitespaces .etc
+(NSString*) urlEncodeString: (NSString*) string{
    
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef) string,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return string;
}

+(BOOL) jobIsExpired:(MMJobDetail *) job {

//    if ([[GUICommon formatForString: job.jobStatus] isEqualToString:@"Open"]){
//
//        if (job.maximumPickupDate!=nil){
//        
//            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//            NSDateComponents *components = [calendar components:NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit
//                                                   fromDate:[NSDate date]
//                                                     toDate:job.maximumPickupDate
//                                                    options:0];                
//        
//            if (![GUICommon isValidTimeLeftDays:components.day hours:components.hour minutes:components.minute]) {
//                return YES;
//            }
//        
//        } else {
//            return YES;   
//        }
//    }
    
    return NO;
}

+(void) setBackButton:(UINavigationItem*)navigationItem {
    navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
}

+(void) styleActionButton:(UIBarButtonItem*)btnActions {
    //Attempt to style button
    @try {
        [btnActions setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIFont boldSystemFontOfSize:12.0f], UITextAttributeFont,
                                            [UIColor whiteColor], UITextAttributeTextColor,
                                            [UIColor clearColor], UITextAttributeTextShadowColor,
                                            [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset, 
                                            nil] forState:UIControlStateNormal]; 
        
        [btnActions setTintColor:[GUICommon MeeMeepActionButton]];
    }
    @catch (NSException *exception) {
        // not supported by 4.2 and below, so just ignore any errors - aydan
    }
}

+(void) openUserPaymentDetailsWebsite:(id<GUIRestDeligate>) restDelegate {
    MMRestAccessToken* accessToken = [restDelegate getAccessToken];
    NSString* urlString = [[[restDelegate getRestClient] getBaseUrl] stringByAppendingPathComponent:@"secure/user/bankDetails"];
    urlString = [urlString stringByAppendingPathComponent:[[accessToken userId] stringValue]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}



@end
