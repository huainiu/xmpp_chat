//
//  PersonEntity.h
//  OpenSnow
//
//  Created by KCQ_HIEUTT16 on 1/21/14.
//  Copyright (c) 2014 KCQ_HIEUTT16. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonEntity : NSObject
@property (nonatomic, strong) NSString *JID;
@property (nonatomic) NSInteger numberOfMessage;
-(id) initWithJID:(NSString*)JID newMessage:(NSInteger)numberOfMessage;
@end
