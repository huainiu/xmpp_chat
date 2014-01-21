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
#import "PersonEntity.h"
#import "OSXMPPMessage.h"
#import "ConservationDetailDelegate.h"
#import "OpenSnowXMPPParser.h"
@interface ChatController : JSMessagesViewController <JSMessagesViewDataSource,JSMessagesViewDelegate,ConservationDetailDelegate>
@property (nonatomic,strong) PersonEntity *chatWithJID;
@property (nonatomic, strong) NSMutableArray *listMessage;
-(id)initWithPerson:(PersonEntity *)JID message:(NSMutableArray*)listMessage;
@end
