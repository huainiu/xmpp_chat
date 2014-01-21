//
//  ConversationController.m
//  OpenSnow
//
//  Created by KCQ_HIEUTT16 on 1/21/14.
//  Copyright (c) 2014 KCQ_HIEUTT16. All rights reserved.
//

#import "ConversationController.h"

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
    [_listConversation addObject:@"hieutt16"];
    //add conversation bar button
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addConversation)];
    self.navigationItem.rightBarButtonItem = addItem;
    //
    self.title=@"User: haitt22";
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
            [_listConversation addObject:inputText];
            [_tableView reloadData];
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
    }
    cell.textLabel.text=_listConversation[indexPath.row];
    cell.detailTextLabel.text=@"0 new message";
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *JID=_listConversation[indexPath.row];
    ChatController *chat=[[ChatController alloc] initWithJID:JID];
    [self.navigationController pushViewController:chat animated:YES];
}
@end
