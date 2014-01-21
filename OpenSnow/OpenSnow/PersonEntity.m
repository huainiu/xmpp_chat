//
//  PersonEntity.m
//  OpenSnow
//
//  Created by KCQ_HIEUTT16 on 1/21/14.
//  Copyright (c) 2014 KCQ_HIEUTT16. All rights reserved.
//

#import "PersonEntity.h"

@implementation PersonEntity
-(id) initWithJID:(NSString*)JID newMessage:(NSInteger)numberOfMessage {
    self = [super init];
    if (self) {
        _JID=JID;
        _numberOfMessage=numberOfMessage;
    }
    return self;
}
@end
