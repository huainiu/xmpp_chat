//
//  ConversationController.m
//  OpenSnow
//
//  Created by KCQ_HIEUTT16 on 1/21/14.
//  Copyright (c) 2014 KCQ_HIEUTT16. All rights reserved.
//

#import "ConversationController.h"
#import "XMPPMessage.h"
@interface ConversationController ()

@end

@implementation ConversationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _listConversation=[NSMutableArray array];
    _listRecvMessage=[NSMutableArray array];
    
    //
    //PersonEntity *person=[[PersonEntity alloc] initWithJID:@"hieutt16" newMessage:0];
    //[_listConversation addObject:person];
    //add conversation bar button
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addConversation)];
    self.navigationItem.rightBarButtonItem = addItem;
    //
    self.title=@"User: hieutt16";
    //delegate
    OpenSnowXMPPParser *parser=[OpenSnowXMPPParser sharedInstance];
    parser.listDelagate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Bar button
-(void)addConversation {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Nhập nick" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    [alert showWithHandler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex==1) {
            NSString *inputText=[alertView textFieldAtIndex:0].text;
            PersonEntity *entity=[[PersonEntity alloc] initWithJID:inputText newMessage:0];
            [_listConversation addObject:entity];
            [_tableView reloadData];
            ChatController *chat=[[ChatController alloc] initWithPerson:entity message:[NSMutableArray array]];
            [self.navigationController pushViewController:chat animated:YES];
        }
    }];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listConversation.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"CellIdentifier";
    UITableViewCell *cell=nil;
    cell=[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.detailTextLabel.textColor=[UIColor blueColor];
    }
    PersonEntity *person=_listConversation[indexPath.row];
    cell.textLabel.text=person.JID;
    if (person.numberOfMessage==0) {
        cell.detailTextLabel.text=@"";
    } else {
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%d new message",person.numberOfMessage ];
    }
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonEntity *person=_listConversation[indexPath.row];
    //refresh tableview data
    person.numberOfMessage=0;
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    //push chat controller
    NSMutableArray *discardedItems = [NSMutableArray array];

    
    for (OSXMPPMessage *item in _listRecvMessage) {
        if ([person.JID isEqualToString:item.message.from.user])
         [discardedItems addObject:item];
    }
    
    [_listRecvMessage removeObjectsInArray:discardedItems];
    ChatController *chat=[[ChatController alloc] initWithPerson:person message:discardedItems];
    [self.navigationController pushViewController:chat animated:YES];
}
#pragma mark - ListConservationDelegate
- (void)didReceiveMessage:(OSXMPPMessage *)message {
    
    NSString *sender=message.message.from.user;
    //check navagation stack
    UIViewController *topController=[self.navigationController.viewControllers lastObject];
    
    if ([topController isKindOfClass:[ChatController class]]) {
        ChatController *chatController=(ChatController*)topController;
        NSString *JID=chatController.chatWithJID.JID;
        if ([JID isEqualToString:sender]) {
            return;
        }
        [_listRecvMessage addObject:message];
        BOOL exist=NO;
        for (int i=0;i<_listConversation.count;i++) {
            PersonEntity *person=_listConversation[i];
            if ([person.JID isEqualToString:sender]) {
                exist=YES;
                person.numberOfMessage++;
                [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            }
        }
        if (!exist) {
            PersonEntity *person=[[PersonEntity alloc] initWithJID:sender newMessage:1];
            [_listConversation addObject:person];
            [_tableView reloadData];
        }
    } else if ([topController isKindOfClass:[ConversationController class]]) {
        [_listRecvMessage addObject:message];
        BOOL exist=NO;
        for (int i=0;i<_listConversation.count;i++) {
            PersonEntity *person=_listConversation[i];
            if ([person.JID isEqualToString:sender]) {
                exist=YES;
                person.numberOfMessage++;
                [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            }
        }
        if (!exist) {
            PersonEntity *person=[[PersonEntity alloc] initWithJID:sender newMessage:1];
            [_listConversation addObject:person];
            [_tableView reloadData];
        }
    }
}
@end
