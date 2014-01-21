//
//  ChatController.m
//  OpenSnow
//
//  Created by KCQ_HIEUTT16 on 1/21/14.
//  Copyright (c) 2014 KCQ_HIEUTT16. All rights reserved.
//

#import "ChatController.h"

@interface ChatController ()

@end

@implementation ChatController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithPerson:(PersonEntity *)JID message:(NSMutableArray*)listMessage{
    self=[super init];
    if (self) {
        _chatWithJID=JID;
        _listMessage=[NSMutableArray arrayWithArray:listMessage];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.delegate = self;
    self.dataSource = self;
    //    [[JSBubbleView appearance] setFont:/* your font for the message bubbles */];
    
    self.title = [NSString stringWithFormat:@"Chat with %@",_chatWithJID.JID ];
    
    self.messageInputView.textView.placeHolder = @"Your placeholder text";
    OpenSnowXMPPParser *parser=[OpenSnowXMPPParser sharedInstance];
    parser.detailDelagate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listMessage.count;
}
#pragma mark - JSMessagesViewDataSource
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
    OSXMPPMessage *mess=_listMessage[indexPath.row];
    return mess.message.body;
    //return @"Demo chat, chat demo. Demo\n Demo";
}
- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath {
    OSXMPPMessage *mess=_listMessage[indexPath.row];
    return mess.date;
}
- (UIImageView *)avatarImageViewForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

/**
 *  Asks the data source for the text to display in the subtitle label *below* the row at the specified index path.
 *
 *  @param indexPath An index path locating a row in the table view.
 *
 *  @return A string containing the subtitle for the message at indexPath. This value may be `nil`.
 */
- (NSString *)subtitleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
#pragma mark - JSMessagesViewDelegate
- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath {
    OSXMPPMessage *mess=_listMessage[indexPath.row];
    return mess.messageType;
}
- (void)didSendText:(NSString *)text {
    OpenSnowXMPPParser *parser=[OpenSnowXMPPParser sharedInstance];
    if ([parser.xmppStream isConnected]) {
        NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
        [body setStringValue:text];
        
        NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
        [message addAttributeWithName:@"type" stringValue:@"chat"];
        [message addAttributeWithName:@"to" stringValue:[NSString stringWithFormat:@"%@@hieu-pc",_chatWithJID.JID]];
        [message addChild:body];
        [parser.xmppStream sendElement:message];
        
        XMPPMessage *xmppMessage=[XMPPMessage messageFromElement:message];
        OSXMPPMessage *myMess=[[OSXMPPMessage alloc] initWithXMPPMessage:xmppMessage messageType:JSBubbleMessageTypeOutgoing];
        [_listMessage addObject:myMess];
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_listMessage.count-1 inSection:0]]  withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
        [self scrollToBottomAnimated:YES];
        
    }
   
}
- (UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type
                       forRowAtIndexPath:(NSIndexPath *)indexPath {
    OSXMPPMessage *mess=_listMessage[indexPath.row];
    if (mess.messageType==JSBubbleMessageTypeIncoming) {
        return [JSBubbleImageViewFactory classicBubbleImageViewForType:JSBubbleMessageTypeIncoming style:JSBubbleImageViewStyleClassicSquareGray];
    } else {
        return [JSBubbleImageViewFactory classicBubbleImageViewForType:JSBubbleMessageTypeOutgoing style:JSBubbleImageViewStyleClassicSquareBlue];
    }
    
}

/**
 *  Asks the delegate for the timestamp policy.
 *
 *  @return A constant describing the timestamp policy.
 *  @see JSMessagesViewTimestampPolicy.
 */
- (JSMessagesViewTimestampPolicy)timestampPolicy {
    return JSMessagesViewTimestampPolicyAll;
}

/**
 *  Asks the delegate for the avatar policy.
 *
 *  @return A constant describing the avatar policy.
 *  @see JSMessagesViewAvatarPolicy.
 */
- (JSMessagesViewAvatarPolicy)avatarPolicy {
    return JSMessagesViewAvatarPolicyAll;
}

/**
 *  Asks the delegate for the subtitle policy.
 *
 *  @return A constant describing the subtitle policy.
 *  @see JSMessagesViewSubtitlePolicy.
 */
- (JSMessagesViewSubtitlePolicy)subtitlePolicy {
    return JSMessagesViewSubtitlePolicyAll;
}

/**
 *  Asks the delegate for the input view style.
 *
 *  @return A constant describing the input view style.
 *  @see JSMessageInputViewStyle.
 */
- (JSMessageInputViewStyle)inputViewStyle {
    return JSMessageInputViewStyleFlat;
}
#pragma mark - ConservationDetailDelegate
- (void)didReceiveMessage:(OSXMPPMessage *)message {
    [_listMessage addObject:message];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_listMessage.count-1 inSection:0]]  withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    [self scrollToBottomAnimated:YES];
}
@end
