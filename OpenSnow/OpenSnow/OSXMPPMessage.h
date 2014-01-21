//
//  OSXMPPMessage.h
//  OpenSnow
//
//  Created by KCQ_HIEUTT16 on 1/21/14.
//  Copyright (c) 2014 KCQ_HIEUTT16. All rights reserved.
//

#import "XMPPMessage.h"
#import "JSBubbleImageViewFactory.h"
@interface OSXMPPMessage : XMPPMessage
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) JSBubbleMessageType messageType;
@end
