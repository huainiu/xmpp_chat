//
//  ConversationController.h
//  OpenSnow
//
//  Created by KCQ_HIEUTT16 on 1/21/14.
//  Copyright (c) 2014 KCQ_HIEUTT16. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAlertView+Blocks.h"
#import "ChatController.h"
#import "PersonEntity.h"
#import "ListConservationDelegate.h"
#import "OpenSnowXMPPParser.h"
@interface ConversationController : UIViewController <UITableViewDataSource,UITableViewDelegate,ListConservationDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listConversation;
@property (nonatomic, strong) NSMutableArray *listRecvMessage;
@end
