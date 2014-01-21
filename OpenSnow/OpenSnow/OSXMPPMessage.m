//
//  OSXMPPMessage.m
//  OpenSnow
//
//  Created by KCQ_HIEUTT16 on 1/21/14.
//  Copyright (c) 2014 KCQ_HIEUTT16. All rights reserved.
//

#import "OSXMPPMessage.h"

@implementation OSXMPPMessage
-(id) initWithXMPPMessage:(XMPPMessage*)message messageType:(JSBubbleMessageType)messageType {
    self = [super init];
    if (self) {
        _message=message;
        _date=[NSDate date];
        _messageType=messageType;
    }
    return self;
}
@end
