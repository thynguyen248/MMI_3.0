//
//  MessageThreadViewController.m
//  MeeMeepMobile
//
//  Created by Cameron McKenzie on 8/04/13.
//
//

#import "MessageThreadViewController.h"
#import "MessageTableViewCell.h"
#import "GUICommon.h"

@interface MessageThreadViewController ()

@end

@implementation MessageThreadViewController

-(id) initWithCommandObject: (id<GUIRestDeligate>) commandObj job:(MMJobDetail*) initJob
       selectedMessageIndex:(NSInteger)initSelectedMessageIndex {
    if(self = [super initWithCommandObject:commandObj job:initJob]) {
        selectedMessageIndex = initSelectedMessageIndex;
    }
    
    return self;
}

-(NSString *) getTitle {
    return job.title;
}

-(NSInteger) getNumberOfRowsInSection:(NSInteger)section {
    NSArray* messageDetails = [messages objectAtIndex:selectedMessageIndex];
    return [messageDetails count];
}

-(NSInteger) getHeightForCellAtIndex:(NSIndexPath*)indexPath {
    MessageTableViewCell* cell = (MessageTableViewCell*)[self tableView:super.tableView cellForRowAtIndexPath:indexPath];
    return cell.inptMessage.frame.size.height;
}

-(UITableViewCell *) getCellForAtIndex:(NSIndexPath *)indexPath {
    NSArray* messageThread = [messages objectAtIndex:selectedMessageIndex];
    MMMessageDetail* message = [messageThread objectAtIndex:indexPath.row];
    
    MessageTableViewCell* myCell = [GUICommon getMessageTableViewCell:super.tableView];
    
    enum messageOrientation orientation;
    // Put me on the right and others on the left
    if([message.userId isEqualToNumber:[[restDelegate getAccessToken] userId]]) {
        orientation = messageOrientationRight;
    } else{
        orientation = messageOrientationLeft;
    }
    
    [myCell setupCellWithMessage:message AndOrientation:orientation];
    myCell.textLabel.userInteractionEnabled = FALSE;
    
    UITableViewCell* cell = myCell;
    return cell;
}

-(void) cellSelectedAtIndex:(NSIndexPath *)indexPath {
    //Do nothing
}

-(NSNumber*) getParentMessageID {
    NSArray* messageThread = [messages objectAtIndex:selectedMessageIndex];
    return [[messageThread objectAtIndex:0] messageId];
    
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    super.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

@end
