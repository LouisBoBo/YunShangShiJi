//
//  NextTaskManager.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/10/21.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "NextTaskManager.h"

@implementation NextTaskManager
+ (NextTaskManager*)taskManager
{
    static NextTaskManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        assert(sharedManager != nil);
    });
    return sharedManager;
}
- (void)bakeToMakemoneyVC;
{
    UIViewController *cuurentVC = [self topViewController];
    for(UIViewController *vv in cuurentVC.navigationController.viewControllers)
    {
        if([vv isKindOfClass:[MakeMoneyViewController class]])
        {
            self.backToMakeMoney = YES;
            [cuurentVC.navigationController popToViewController:vv animated:YES];
            return;
        }
    }
    
    MakeMoneyViewController *makemoney = [[MakeMoneyViewController alloc]init];
    self.backToMakeMoney = YES;
    makemoney.hidesBottomBarWhenPushed = YES;
    [cuurentVC.navigationController pushViewController:makemoney animated:YES];
}

//获取当前的VC
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
