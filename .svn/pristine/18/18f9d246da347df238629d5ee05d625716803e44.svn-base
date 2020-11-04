//
//  WTFAlertView.h
//  YunShangShiJi
//
//  Created by yssj on 16/5/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlertViewDelegate <NSObject>


@optional

-(void)clickButton:(NSInteger)index;

@end

@interface WTFAlertView : UIView

//@property(nonatomic,copy)void (^GlodeBottomView)(NSInteger index ,NSString *string);
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)id<AlertViewDelegate>delegate;
@property (nonatomic, copy) dispatch_block_t toLoginBlock;

+(id)GlodeBottomView;

-(void)show;

@end
