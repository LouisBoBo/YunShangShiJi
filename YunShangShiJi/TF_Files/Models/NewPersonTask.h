//
//  NewPersonTask.h
//  YunShangShiJi
//
//  Created by 云商 on 16/3/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TFMissionModel : NSObject
/**
 *  任务id
 */
@property (nonatomic, copy)NSString *ID;
/**
 *  m_mis_day
 */
@property (nonatomic, copy)NSString *m_mis_day;
/**
 *  完成任务获得积分
 */
@property (nonatomic, copy)NSString *integral_num;
/**
 *  任务是否删除
 */
@property (nonatomic, copy)NSString *is_del;
/**
 *  任务名称
 */
@property (nonatomic, copy)NSString *m_name;
/**
 *  任务添加时间
 */
@property (nonatomic, copy)NSString *add_data;
/**
 *  任务类型
 */
@property (nonatomic, copy)NSString *m_type;

@end

@interface NewPersonTask : NSObject
/**
 *  所有的新手任务
 */
@property (nonatomic, copy)NSArray *mission;

+(NewPersonTask *)shareNewPersonTask;


@end
