//
//  CommsViewController.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 8/04/13.
//
//

#import "CommunicationsViewController.h"
#import "GUICommon.h"
#import "EditableTableViewCell.h"
#import "MessageThreadViewController.h"

@interface CommunicationsViewController ()

@end

@implementation CommunicationsViewController

-(NSString *) getTitle {
    return job.title;
}

-(NSInteger) getNumberOfRowsInSection:(NSInteger)section {
    return [messages count];
}

-(NSInteger) getHeightForCellAtIndex:(NSIndexPath*)indexPath {
    return 44.0f;
}

-(UITableViewCell *) getCellForAtIndex:(NSIndexPath *)indexPath {
    NSArray* messagesForGroup = [messages objectAtIndex:indexPath.row];
    MMMessageDetail* messageDetail = [messagesForGroup objectAtIndex:0];
    
    UITableViewCell* cell = [super.tableView dequeueReusableCellWithIdentifier:@"MessageThreadCell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MessageThreadCell"];
    }
    
    cell.textLabel.text = messageDetail.content;
    [cell.textLabel setTextColor:[GUICommon MeeMeepHeadingText]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d %@", [messagesForGroup count],
                                 [messagesForGroup count] == 1 ? @"message" : @"messages"];
    
    return cell;
}

-(void) cellSelectedAtIndex:(NSIndexPath *)indexPath {
    MessageThreadViewController* vc = [[MessageThreadViewController alloc] initWithCommandObject:restDelegate job:job selectedMessageIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
}

-(NSNumber*) getParentMessageID {
    return nil;
}

@end
