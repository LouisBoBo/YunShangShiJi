//
//  TypeShareModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/10/12.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface TypeShareModel : BaseModel

@property (nonatomic, assign) NSInteger status;    //结果
@property (nonatomic, copy)   NSString *message;   //结果信息
@property (nonatomic, strong) NSString *type2;     //二级类目
@property (nonatomic, strong) NSString *supp_label_id; //品牌ID
@property (nonatomic, assign) NSInteger newbie;    //0为新手任务，1不是新手任务
@property (nonatomic, assign) NSString *current_date; //newbie01第一天 newbie02第二天
@property (nonatomic, assign) NSString *LotteryNumber; //抽奖次数
/**
 * 获取二级类目ID
 *
 * @param shop_code  商品编号
 * @param success    成功回调
 */
+ (void)getTypeCodeWithShop_code:(NSString *)shop_code
                     success:(void (^)(TypeShareModel *data))success;

//0为新手任务，1不是新手任务
+ (void)getNewbieHTTP:(void (^)(TypeShareModel *data))success;
@end
