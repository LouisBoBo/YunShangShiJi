//
//  TaskTimerManager.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/10/24.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskTimerManager : NSObject
+ (instancetype)taskTimerManager;

@property (nonatomic , strong) NSTimer  *Taskmytimer;     //倒计时
@property (nonatomic , assign) NSInteger mentionCount;    //记数
@property (nonatomic , assign) NSInteger second;          //秒数
@property (nonatomic , assign) NSInteger minute;          //分钟数
@property (nonatomic , strong) NSString *day;             //任务第几天
@property (nonatomic , assign) BOOL liulan_isfinish;      //浏览任务完成
@property (nonatomic , assign) BOOL current_liulanisfinish;//当前正在完成浏览任务
@property (nonatomic , copy) NSString *liulan_rewardtype; //当前浏览分钟数任务类型
//@property (nonatomic , strong) dispatch_block_t liulanFinishBlock;
@property (nonatomic , copy) dispatch_block_t nextTaskBlock;
@property (nonatomic , strong) NSMutableArray *selectTaskList;
@property (nonatomic , strong) NSMutableArray *noFinishTasklist;
@property (nonatomic , strong) NSMutableArray *motaskDataArray;
@property (nonatomic , strong) void(^liulanFinishBlock)(BOOL popup);
- (void)goFinsihTaskTimer:(NSString*)t_name Count:(NSInteger)mentionCount Second:(NSInteger)second Minute:(NSInteger)minute Day:(NSString*)day;
@end
