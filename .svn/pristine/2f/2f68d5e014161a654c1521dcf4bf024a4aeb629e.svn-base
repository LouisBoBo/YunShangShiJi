//
//  TaskTimerManager.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/10/24.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TaskTimerManager.h"
#import "TaskSignModel.h"
#import "FinishTaskPopview.h"

@implementation TaskTimerManager
{
    FinishTaskPopview *bonusview;
}
+ (instancetype)taskTimerManager;
{
    static TaskTimerManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        assert(sharedManager != nil);
    });
    return sharedManager;
}

- (void)goFinsihTaskTimer:(NSString*)t_name Count:(NSInteger)mentionCount Second:(NSInteger)second Minute:(NSInteger)minute Day:(NSString*)day;
{
    self.day = day;
    self.minute = minute;
    self.second = second;
    
    [self.Taskmytimer invalidate];
    self.Taskmytimer = nil;
    
    self.Taskmytimer = [NSTimer weakTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod1:) userInfo:t_name repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.Taskmytimer forMode:NSDefaultRunLoopMode];
}

#pragma mark 浏览多长时间倒计时
- (void)timerFireMethod1:(NSTimer*)timer
{
    id object = timer.userInfo;
    
    self.second--;
    if (self.second==-1 && self.minute !=0)
    {
        self.second=59;
        self.minute--;
    }
    
    if (self.second==0 && self.minute==0) {
        [_Taskmytimer invalidate];
        _Taskmytimer = nil;
        
        NSMutableDictionary *dic= [self getCustomTask:object];
        NSString *index_id = [dic objectForKey:@"index"];
        NSString *day = self.day;
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"is_read"];
        [TaskSignModel getTaskHttp:index_id Day:day Success:^(id data) {
            TaskSignModel *model = data;
            if(model.status == 1)
            {
                
                UIViewController *cuurentVC = [self topViewController];
                if([cuurentVC isKindOfClass:[MakeMoneyViewController class]])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{

                        [[NSNotificationCenter defaultCenter] postNotificationName:@"liulanTaskFinish" object:self];
                    });
                    
                }else{
                    if(self.liulanFinishBlock)
                    {
                        self.liulanFinishBlock(NO);
                    }
                    self.liulan_isfinish = YES;
                }
            }
        }];
    }
    
    if(self.minute >=0 && self.second >=0)
    {
        [Signmanager SignManarer].now_minute = self.minute;
        [Signmanager SignManarer].now_second = self.second;
        
        NSLog(@"*******************%zd",[Signmanager SignManarer].now_second);
    }
}

#pragma mark 签到任务弹框
- (void)setTaskPopMindView:(TaskPopType)type Value:(NSString*)value Title:(NSString*)title Rewardvalue:(NSString*)rewardValue Rewardnum:(int)num
{
    [bonusview removeFromSuperview];
    
    bonusview = [[FinishTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) TaskType:type TaskValue:value Title:title RewardValue:rewardValue RewardNumber:num Rewardtype:self.liulan_rewardtype];
    
    __weak FinishTaskPopview *view = bonusview;
    bonusview.tapHideMindBlock = ^{
        
        [view remindViewHiden];
    };
    kWeakSelf(self);
    bonusview.leftHideMindBlock = ^(NSString*title){
        if(weakself.nextTaskBlock)
        {
            weakself.nextTaskBlock();
        }
    };
    
    bonusview.rightHideMindBlock = ^(NSString*title){
        
    };
    
    UIViewController *cuurentVC = [self topViewController];
    [cuurentVC.view addSubview:bonusview];
}

#pragma mark 获取当前正在完成的任务
- (NSMutableDictionary*)getCustomTask:(NSString*)task_type
{
    NSString *index = @"";
    NSString *task_value = @"";
    NSString *rewardNumber = @"";
    NSString *reward_value = @"";
    
    for(NSDictionary *dic in self.selectTaskList)
    {
        NSString *index_id = [dic objectForKey:task_type];
        for(NSDictionary *taskdic in self.noFinishTasklist)
        {
            NSString *ind = [NSString stringWithFormat:@"%@",taskdic[@"index"]];
            
            if([ind isEqualToString:index_id])
            {
                index = taskdic[@"index"];
                task_value = taskdic[@"value"];//任务值
                rewardNumber = taskdic[@"num"];//分几次奖励
                
                NSString *t_id = [NSString stringWithFormat:@"%@",taskdic[@"t_id"]];
                NSString *task_id = @"";
                NSString *value   = @"";
                
                for(NSDictionary *taskdic in self.motaskDataArray)
                {
                    task_id = [NSString stringWithFormat:@"%@",taskdic[@"t_id"]];
                    if([t_id isEqualToString:task_id])
                    {
                        
                        value   = [NSString stringWithFormat:@"%@",taskdic[@"value"]];
                        
                        reward_value = value;
                        
                        break;
                    }
                }
                
                break;
            }
        }
    }
    
    NSMutableDictionary *taskdic = [NSMutableDictionary dictionary];
    [taskdic setObject:index forKey:@"index"];
    [taskdic setObject:task_value forKey:@"task_value"];
    [taskdic setObject:rewardNumber forKey:@"rewardNumber"];
    [taskdic setObject:reward_value forKey:@"reward_value"];
    
    return taskdic;
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
