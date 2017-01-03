//
//  GUICommon.h
//  MeeMeepMobile
//
//  Contains common code snippets that have been abstracted to methods
//
//  Created by Aydan Bedingham on 13/03/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "KeyValueTableViewCell.h"
#import "RatingTableViewCell.h"
#import "LargeKeyValueTableViewCell.h"
#import "BidsButtonTableViewCell.h"
#import "DoubleKeyValueTableViewCell.h"
#import "EditableTableViewCell.h"
#import "JobSummaryTableViewCell.h"
#import "BidSummaryTableViewCell.h"
#import "CustomTableViewCell.h"
#import "EditableKeyValueTableViewCell.h"
#import "MyTableViewCell.h"
#import "MMJobAddress.h"
#import "WrappingKeyValueTableViewCell.h"
#import "MMAsyncActivityManagementImpl.h"
#import "MMJobDetail.h"
#import "MMBidDetail.h"
#import "MMRestAccessToken.h"
#import "LargeEditableKeyValueTableViewCell.h"
#import "StyledKeyValueTableViewCell.h"
#import "CommSummaryTableViewCell.h"
#import "MessageTableViewCell.h"
#import "ConversationSummaryTableViewCell.h"
#import "BidsMessagesLinkerTableViewCell.h"
#import "StyledKeyValueMultilineTableViewCell.h"
#import "KeyValueTableViewCell_TA.h"
#import "SegmentedTableHeader.h"
#import "JobItemSummaryTableViewCell.h"
#import "GUIRestDeligate.h"

typedef enum _AspectRatio {
    PRE_IPHONE_5,
    IPHONE_5
} AspectRatio;

@interface GUICommon : NSObject

+ (AspectRatio) getDeviceAspectRatio;
+ (NSTimeInterval) getKeyboardAnimationTime:(NSNotification*) notification;

+ (void) renderButton:(UIButton *) button;
+ (void) renderButtonDown:(UIButton *) button;

+(BOOL) jobIsExpired:(MMJobDetail *) job;

+(JobItemSummaryTableViewCell*) getJobItemSummaryTableViewCell:(UITableView*) tableView;

+(SegmentedTableHeader*) getSegmentedTableHeader:(UITableView*) tableView;

+(KeyValueTableViewCell*) getKeyValueTableViewCell: (UITableView*) tableView;

+(RatingTableViewCell*) getRatingTableViewCell: (UITableView*) tableView;

+(CustomTableViewCell*) getCustomTableViewCell: (UITableView*) tableView;

+(LargeKeyValueTableViewCell*) getLargeKeyValueTableViewCell: (UITableView*) tableView;


+(LargeEditableKeyValueTableViewCell*) getLargeEditableKeyValueTableViewCell: (UITableView*) tableView;
    
+(BidsButtonTableViewCell*) getBidsButtonTableViewCell: (UITableView*) tableView;
    
+(DoubleKeyValueTableViewCell*) getDoubleKeyValueTableViewCell: (UITableView*) tableView;

+(JobSummaryTableViewCell*) getJobSummaryTableViewCell: (UITableView*) tableView;

+(EditableTableViewCell*) getEditableTableViewCell: (UITableView*) tableView;

+(EditableKeyValueTableViewCell*) getEditableKeyValueTableViewCell: (UITableView*) tableView;

+(WrappingKeyValueTableViewCell*) getWrappingKeyValueTableViewCell: (UITableView*) tableView;

+(StyledKeyValueTableViewCell*) getStyledKeyValueTableViewCellDontCache: (UITableView*) tableView;

+(StyledKeyValueTableViewCell*) getStyledKeyValueTableViewCell: (UITableView*) tableView;

+(StyledKeyValueMultilineTableViewCell*) getStyledKeyValueMultilineTableViewCell: (UITableView*) tableView;

+(CommSummaryTableViewCell*) getCommSummaryTableViewCell: (UITableView*) tableView;

+(ConversationSummaryTableViewCell*) getConversationSummaryTableViewCell: (UITableView*) tableView;

+(MessageTableViewCell*) getMessageTableViewCell: (UITableView*) tableView;

+(MyTableViewCell*) getMyTableViewCell: (UITableView*) tableView;

+(KeyValueTableViewCell_TA*) getKeyValueTableViewCell_TA: (UITableView*) tableView;

+(BidSummaryTableViewCell*) getBidSummaryTableViewCell: (UITableView*) tableView;

+(BidsMessagesLinkerTableViewCell*) getBidsMessagesLinkerTableViewCell: (UITableView*) tableView;

+(id) displayForNull: (id) value displayThisInstead:(id) somethingElse;

+(NSString*) formatNumber:(NSNumber*)number withRounding:(NSUInteger)rounding;

+(NSString*) formatForString: (id) value;

+(NSNumber*) formatForNumber: (id) value;

+(NSString*) formatCurrency: (NSNumber*) value;
    
+(NSString*) formatDate: (NSDate*) value;

+(BOOL) isValidState: (NSString*) stateName;

+(BOOL) isNumber: (NSString*) numberString;

+(BOOL) isValidPostCode: (NSString*) postCode forState:(NSString *) stateName; 

+ (NSString *) addressStringForMMJobAddress:(MMJobAddress *) address;

+(NSString*) specialInformationStringForJobDetail:(MMJobDetail*) jobDetail;
    
+ (NSString *) timeStringForJobDays:(NSInteger)days hours:(NSInteger)hours minutes:(NSInteger)minutes;

+(BOOL) isValidTimeLeftDays:(NSInteger)days hours:(NSInteger)hours minutes: (NSInteger)minutes;

+(NSDate*) getDate:(NSDate*)date AfterDays: (NSInteger) days;

+(NSDate*) getDate:(NSDate*)date AfterMonths: (NSInteger) months;

+(NSDate*) getDate:(NSDate*)date AfterYears: (NSInteger) years;
    
+(NSDate*)getNextHalfHour:(NSDate*)date;

+(BOOL)isOwnerOfJob:(MMJobDetail*)jobDetail accessToken:(MMRestAccessToken*)accessToken;

+(BOOL)isWinningBidderOfJob:(MMJobDetail*)jobDetail accessToken:(MMRestAccessToken*)accessToken ;

+(BOOL)containsMyBid:(NSArray*) bidSummaries accessToken:(MMRestAccessToken*)accessToken;

+(BOOL)isMyBid:(MMBidDetail*)bidDetail accessToken:(MMRestAccessToken*)accessToken;

+(BOOL) isMyMessage: (MMMessageDetail*) message accessToken:(MMRestAccessToken*) accessToken;

+(BOOL)isMyBidSummary:(MMBidSummary*)bidSummary accessToken:(MMRestAccessToken*)accessToken;

+(UIActionSheet*)createActionSheetWithActions:(NSArray*)actionTitles delegate:(id<UIActionSheetDelegate>)delegate;

// only returns active bids that you own
+(NSNumber*) getMyCurrentBidId:(NSArray*)bids accessToken:(MMRestAccessToken*)accessToken;


+(NSString*) jobTitleForAddress:(MMJobAddress*) address;

+(CGFloat) heightOfText: (NSString*)text WithFont:(UIFont*)font ConstrainedToWidth:(CGFloat)width;

+(CGFloat) heightOfText2: (NSString*)text WithFont:(UIFont*)font ConstrainedToWidth:(CGFloat)width;

+(UIColor*) getColourNonActiveJobs;

+(UIColor*) getColourActiveJobs;

+(NSArray*) MeeMeepButtonGradientGrayBar;

+(NSDate*) stripMinutesAndSecondsFromDateTime:(NSDate*)date;

// New Colours
+(UIColor*) MeeMeepHeadingText;
+(UIColor*) MeeMeepBackground;
+(UIColor*) MeeMeepActionText;
+(UIColor*) MeeMeepWarningButton;
+(UIColor*) MeeMeepGoButton;
+(UIColor*) MeeMeepActionButton;
+(NSArray*) MeeMeepActionButtonGradient;
+(NSArray*) MeeMeepActionButtonGradientHighlighted;

//Colours
+(NSArray*) MeeMeepButtonGradientOrange;
+(NSArray*) MeeMeepButtonGradientOrangeHighlighted;
+(NSArray*) MeeMeepButtonGradientGray;
+(NSArray*) MeeMeepButtonGradientGray2;
+(NSArray*) MeeMeepButtonGradientGrayed;
+(NSArray*) MeeMeepButtonGradientGrayedHighlighted;


+(NSDate*) stripTimeFromDate:(NSDate*)date;
+(NSString*) getDateRangeFromDays:(NSInteger)days;

+(NSString*) urlEncodeString: (NSString*) string;

+(void) setBackButton:(UINavigationItem*)navigationItem;
+(void) styleActionButton:(UIBarButtonItem*)btnActions;

+(void) openUserPaymentDetailsWebsite:(id<GUIRestDeligate>) restDelegate;

@end
