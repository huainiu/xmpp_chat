//
//  ChatController.h
//  OpenSnow
//
//  Created by KCQ_HIEUTT16 on 1/21/14.
//  Copyright (c) 2014 KCQ_HIEUTT16. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSMessagesViewController.h"
#import "JSBubbleImageViewFactory.h"

//XMPP
#import "XMPPMessage.h"
@interface ChatController : JSMessagesViewController <JSMessagesViewDataSource,JSMessagesViewDelegate>
@property (nonatomic,strong) NSString *chatWithJID;
-(id)initWithJID:(NSString*)JID;
@end
