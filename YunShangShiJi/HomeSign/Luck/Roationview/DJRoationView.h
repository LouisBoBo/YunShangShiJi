//
//  DJRoationView.h
//  DJRotainVIew
//
//  Created by Jason on 28/12/15.
//  Copyright © 2015年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJRoationView : UIView
/**
 *  速度最高20
 */
@property (nonatomic,assign) int speed;
@property (nonatomic,assign) NSInteger yidou;             //抽奖可用的衣豆
@property (nonatomic,assign) CGFloat balance;             //抽奖可用的余额
@property (nonatomic,assign) NSInteger LotteryNumber;     //疯狂星期一抽奖次数
@property (nonatomic,assign) BOOL is_OrderRedLuck;        //50元红包抽奖
@property (nonatomic,assign) BOOL is_oneLuck;             //是否1元抽奖
@property (nonatomic,assign) NSInteger is_orNotPreze;          //是否有中奖资格 0中奖 1不中奖
@property (nonatomic,assign) bool is_rotating;            //是否正在旋转
@property (nonatomic , copy) void(^startRotainBlock)(NSString*);

- (void)startRotainAnimation:(NSInteger)is_orNotPreze;
//- (void)stopRotainAnimation;
- (void)loadMainImage;
- (void)rotatingDidFinishBlock:(void(^)(NSInteger index,CGFloat score,CGFloat raward,NSInteger rewardtype))block;
- (void)refreshData:(NSInteger)yidou LotteryNumber:(NSInteger)LotteryNumber Balance:(CGFloat)balance;
@end
