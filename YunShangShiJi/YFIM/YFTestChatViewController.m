//
//  YFTestChatViewController.m
//  YunShangShiJi
//
//  Created by zgl on 16/5/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFTestChatViewController.h"
#import "YFChatViewController.h"
#import "GlobalTool.h"

@interface YFTestChatViewController ()

@end

@implementation YFTestChatViewController

- (void)dealloc {
    NSLog(@"%@,释放了",[self class]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息盒子";
    self.navigationItem.leftBarButtonItem = [self barBackButton];
    self.conversationListTableView.backgroundColor = kBackgroundColor;
    self.conversationListTableView.tableFooterView = [UIView new];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kApplicationWidth, 40)];
    lable.text = @"暂无任何消息哦！";
    lable.textColor = kTextColor;
    lable.font = kTextFontSize;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.center = self.view.center;
    self.emptyConversationView = lable;
    
    //设置在会话列表中显示的头像形状，矩形或者圆形（全局有效）
    //    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM),
                                        @(ConversationType_CUSTOMERSERVICE)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
    [UIViewController loginRongCloub];
}

//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    YFChatViewController *conversationVC = [[YFChatViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = model.conversationTitle;
    [self.navigationController pushViewController:conversationVC animated:YES];
}

//删除消息
- (void)didDeleteConversationCell:(RCConversationModel *)model {
    [[RCIMClient sharedRCIMClient] clearMessages:model.conversationType targetId:model.targetId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
