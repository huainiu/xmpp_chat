//
//  ListConservationDelegate.h
//  OpenSnow
//
//  Created by KCQ_HIEUTT16 on 1/21/14.
//  Copyright (c) 2014 KCQ_HIEUTT16. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSXMPPMessage.h"
@protocol ListConservationDelegate <NSObject>
- (void)didReceiveMessage:(OSXMPPMessage *)message;
@end
