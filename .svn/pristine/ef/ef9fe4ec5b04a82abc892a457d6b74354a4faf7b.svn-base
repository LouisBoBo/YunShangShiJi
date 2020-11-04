//
//  UIViewController+chatList.m
//  YunShangShiJi
//
//  Created by zgl on 16/5/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "UIViewController+chatList.h"

#import "YFTestChatViewController.h"
#import "YFChatViewController.h"
//#import "ChatListViewController.h"
//#import "ChatViewController.h"
#import "LoginViewController.h"
#import "TFHomeViewController.h"
#import "ShopStoreViewController.h"
#import "TFSalePurchaseViewController.h"
#import "MymineViewController.h"
#import "TFIntimateCircleVC.h"

#import "RobotManager.h"
#import "ShopDetailModel.h"
#import "RCTokenModel.h"
#import "GlobalTool.h"
#import "ShopCarManager.h"
#import "NoMentionView.h"

#import <objc/runtime.h>

@implementation UIViewController (chatList)

static char YFLoadFaildBlock;
static char YFBackView;

#pragma mark - 即时通讯（IM）
/// 跳转消息列表
- (void)presentChatList {
    __weak typeof(self) weakSelf = self;
    [self loginVerifySuccess:^{
        if (IsRongCloub) {
            // 融云
            YFTestChatViewController *chatlist = [[YFTestChatViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chatlist];
            [weakSelf presentViewController:nav animated:YES completion:nil];
        } else {
            // 环信
//            ChatListViewController *chatlist=[[ChatListViewController alloc]init];
//            [weakSelf presentViewController:chatlist animated:YES completion:nil];
//            [weakSelf.navigationController setNavigationBarHidden:NO animated:YES];

        }

    }];
}

/// 跳转聊天界面
- (void)messageWithSuppid:(NSString *)suppid title:(NSString *)title model:(ShopDetailModel *)model detailType:(NSString *)detailType imageurl:(NSString *)imageurl{
    __weak typeof(self) weakSelf = self;
    [self loginVerifySuccess:^{
        if (IsRongCloub) {
            // 融云
            YFChatViewController *chatVC = [[YFChatViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:suppid];
            if ([@"915" isEqual:suppid]) {
                chatVC.title = @"客服";
            } else {
                chatVC.title = title?:suppid;
            }
            if (model) {
                chatVC.model = model;
                if(detailType) {
                    chatVC.detailtype = detailType;
                    chatVC.imageurl = imageurl;
                }
                else {
                    chatVC.detailtype = @"活动商品";
                }
            }
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chatVC];
            [weakSelf presentViewController:nav animated:YES completion:nil];
        } else {
            // 环信
//            ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:suppid
//                                                                            conversationType:eConversationTypeChat];
//            chatController.title = title?:suppid;
//            
//            if (model) {
//                chatController.model = model;
//                if(detailType) {
//                    chatController.detailtype = detailType;
//                    chatController.imageurl = imageurl;
//                } else {
//                    chatController.detailtype = @"活动商品";
//                }
//            }
            
//            if ([[RobotManager sharedInstance] getRobotNickWithUsername:suppid]) {
//                chatController.title = [[RobotManager sharedInstance] getRobotNickWithUsername:suppid];
//            }
//            [weakSelf presentViewController:chatController animated:YES completion:nil];
        }

    }];
}

/// 登录融云
+ (void)loginRongCloub{
    if (NO == [DataManager sharedManager].isRongCloubLogin) {
        NSString *token = [DataManager sharedManager].rcToken;
        if (token == nil) {
            [[DataManager sharedManager] updateRcToken];
        } else {
            [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
                NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
                [DataManager sharedManager].isRongCloubLogin = YES;
                NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
                NSString *defaultPic = [[NSUserDefaults standardUserDefaults] objectForKey:USER_HEADPIC];
                if (![defaultPic hasPrefix:@"http://"]) {
                    defaultPic = [NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy],defaultPic];
                }
                RCUserInfo *user=[[RCUserInfo alloc]initWithUserId:userId name:name portrait:defaultPic];
                [RCIM sharedRCIM].currentUserInfo = user;
            } error:^(RCConnectErrorCode status) {
                NSLog(@"登陆的错误码为:%ld", status);
            } tokenIncorrect:^{
                NSLog(@"token错误");
            }];
        }
    }
}

/// 用户是否登录
- (void)loginVerifySuccess:(void (^)())success {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    if(token == nil)
    {
        LoginViewController *login=[[LoginViewController alloc]init];
        login.tag = 1000;
        login.loginStatue=@"toBack";
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:login] animated:YES completion:nil];
    } else {
        
        if (success) {
            success();
        }
    }
}

/// 登录
- (void)loginSuccess:(void (^)())success {
    [self loginWithPro:@"toBack" Success:success];
}
- (void)loginWithPro:(NSString *)pro Success:(void (^)())success {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    if(token == nil)
    {
        MyLog(@"%@, %p", [self class], self);
        
        LoginViewController *login=[[LoginViewController alloc]init];
        login.tag = 1000;
        login.loginStatue= pro;
        login.modalPresentationStyle = UIModalPresentationFullScreen;
        [login returnClick:success withCloseBlock:success];

        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        UIViewController *topVC = [keyWindow topViewControllerWithRootViewController:self];
        
        if (![topVC isKindOfClass:[LoginViewController class]]) {
            UIViewController *nav = [[UINavigationController alloc] initWithRootViewController:login];
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:nav animated:YES completion:nil];
        }
    } else {
        if (success) {
            success();
        }
    }
}
#pragma mark - 导航栏按钮
- (UIBarButtonItem *)barBackButton {
    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame = CGRectMake(0, 0, 22, 22);
    [backbtn setImage:[UIImage imageNamed:@"icon_fanhui_black"] forState:UIControlStateNormal];
    [backbtn setImage:[UIImage imageNamed:@"icon_fanhui_black"] forState:UIControlStateHighlighted];
    [backbtn addTarget:self action:@selector(leftBarButtonItemPressed) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backbtn];
    return item;
}

- (UIView *)setNavigationBackWithTitle:(NSString *)title {
    
    UIView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headview.frame.size.height - 1, headview.frame.size.width, 1)];
    lineView.backgroundColor = lineGreyColor;
    [headview addSubview:lineView];
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn addTarget:self action:@selector(leftBarButtonItemPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, headview.frame.size.width, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text= title;
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment= NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    return headview;
}

- (void)setNavigationWithTitle:(NSString *)title rightBtnTitle:(NSString *)btnTitle {
    UIView *headview = [self setNavigationBackWithTitle:title];
    UIButton *rightBtn=[[UIButton alloc]init];
    [rightBtn setTitle:btnTitle forState:UIControlStateNormal];
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM6(28)];
    [rightBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.equalTo(headview).offset(10);
    }];
}

/// 返回上一页面方法
- (void)leftBarButtonItemPressed {
    if ((self.navigationController.viewControllers.firstObject == self) || (self.presentedViewController)) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/// 导航栏右侧按钮点击（子类重写）
- (void)rightButtonClick {
    
}

//当加载失败时显示默认标题和图片
- (void)loadingDataFail {
    [self loadingDataBackgroundView:self.view img:[UIImage imageNamed:@"哭脸"] text:@"亲,没网了"];
}

//当无数据时显示默认标题和图片
- (void)loadingDataBlank {
    [self loadingDataBackgroundView:self.view img:nil text:nil];
}

//加载成功
- (void)loadingDataSuccess {
    [[self backView] removeFromSuperview];
}
- (void)loadSmileView:(UIView *)view {
    TFBackgroundView *tb = [self backView];
    if (tb != nil) {
        [view addSubview:tb];
        [view bringSubviewToFront:tb];
    }else {
        tb = [[[NSBundle mainBundle] loadNibNamed:@"TFBackgroundView" owner:self options:nil] lastObject];
        tb.frame = CGRectMake(0, 64, view.bounds.size.width, 200);
        tb.tag = 30009;
        tb.backgroundColor = self.view.backgroundColor;
    }
    tb.headImageView.image = [UIImage imageNamed:@"笑脸21"];
    tb.textLabel.text = @"亲,暂时没有相关数据哦";

    [view addSubview:tb];
    [view bringSubviewToFront:tb];
    [self setBackView:tb];
}
- (void)loadNormalView:(UIView *)view
{
    TFBackgroundView *tb = [self backView];
    if (tb != nil) {
        [view addSubview:tb];
        [view bringSubviewToFront:tb];
    }else {
        tb = [[[NSBundle mainBundle] loadNibNamed:@"TFBackgroundView" owner:self options:nil] lastObject];
        tb.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
        tb.tag = 30009;
        tb.backgroundColor = self.view.backgroundColor;
    }
    tb.headImageView.image = [UIImage imageNamed:@"笑脸21"];
    tb.textLabel.text = @"亲,暂时没有相关数据哦";
    
    [view addSubview:tb];
    [view bringSubviewToFront:tb];
    [self setBackView:tb];

}
- (void)loadingDataBackgroundView:(UIView *)view img:(UIImage *)img text:(NSString *)text
{
    TFBackgroundView *tb = [self backView];
    if (tb != nil) {
        [view addSubview:tb];
        [view bringSubviewToFront:tb];
    } else {
        tb = [[[NSBundle mainBundle] loadNibNamed:@"TFBackgroundView" owner:self options:nil] lastObject];
        tb.frame = view == self.view?CGRectMake(0, Height_NavBar, view.bounds.size.width, view.bounds.size.height - Height_NavBar):CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
        tb.tag = 30009;
        tb.backgroundColor = self.view.backgroundColor;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 30013;
        btn.layer.cornerRadius = 4;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 0.5;
        [btn setTitle:@"重新加载" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setBackgroundColor:self.view.backgroundColor];
        [btn addTarget:self action:@selector(loadFailBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [tb addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tb.textLabel.mas_bottom).offset(10);
            make.centerX.equalTo(tb.textLabel);
            make.width.equalTo(@(80));
            make.height.equalTo(@(38));
        }];
    }
    
    UIButton *btn = [tb viewWithTag:30013];
    if (img != nil) {
        tb.headImageView.image = img;
        btn.hidden = NO;
    } else {
        tb.headImageView.image = [UIImage imageNamed:@"笑脸21"];
        btn.hidden = YES;
    }
    
    if (text != nil) {
        tb.textLabel.text = text;
    } else {
        tb.textLabel.text = @"亲,暂时没有相关数据哦";
    }
    [view addSubview:tb];
    [view bringSubviewToFront:tb];
    [self setBackView:tb];
}

- (void)setBackView:(TFBackgroundView *)backView {
    objc_setAssociatedObject(self, &YFBackView, backView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TFBackgroundView *)backView {
    TFBackgroundView *backView = objc_getAssociatedObject(self, &YFBackView);
    return backView;
}

- (void)loadFailBtnClick {
    dispatch_block_t loadFailBtnBlock = objc_getAssociatedObject(self, &YFLoadFaildBlock);
    if (loadFailBtnBlock) {
        [self loadingDataSuccess];
        loadFailBtnBlock();
    }
}

- (void)loadFailBtnBlock:(dispatch_block_t)block {
    objc_setAssociatedObject(self, &YFLoadFaildBlock, [block copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)changeTabbarCartNum{
//    int cart1= (int)[ShopCarManager sharedManager].s_count ;
    int cart2= (int)[ShopCarManager sharedManager].p_count ;
    if(cart2>0){
        [Mtarbar showBadgeOnItemIndex:3];
        [Mtarbar changeBadgeNumOnItemIndex:3 withNum:[NSString stringWithFormat:@"%d",cart2]];
//        [Mtarbar changeBadgeNumOnItemIndex:3 withNum:[NSString stringWithFormat:@"%d",cart1+cart2]];
    }else
        [Mtarbar hideBadgeOnItemIndex:3];
}


/**
 重新加载密友圈数据
 */
- (void)reloadSecretFriendViewController {
    UINavigationController *naVC = Mtarbar.viewControllers[2];
    
    TFIntimateCircleVC *VC = naVC.viewControllers[0];
    [VC reloadChildViewController];
}

@end
