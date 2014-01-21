//
//  ConversationController.h
//  OpenSnow
//
//  Created by KCQ_HIEUTT16 on 1/21/14.
//  Copyright (c) 2014 KCQ_HIEUTT16. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversationController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listConversation;
@end
