//
//  CFPopView.h
//  YunShangShiJi
//
//  Created by yssj on 2016/12/15.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 

 - CFPopTypeWhite: <#CFPopTypeWhite description#>
 - CFPopTypeRed: <#CFPopTypeRed description#>
 */
typedef NS_ENUM(NSUInteger, CFPopType) {
    CFPopTypeWhite,
    CFPopTypeRed,
};

@interface CFPopView : UIView

@property (nonatomic,strong)NSString *textStr;
@property (nonatomic,strong)NSString *leftBtnStr;
@property (nonatomic,strong)NSString *rightBtnStr;

@property (nonatomic,strong)NSArray *discriptionData;

@property (nonatomic,copy)dispatch_block_t leftBlock;
@property (nonatomic,copy)dispatch_block_t rightBlock;

@property (nonatomic,strong)UITableView  *MytableView;
@property (nonatomic, strong) UIView *showView;

@property (nonatomic,assign)CFPopType popType;

- (void)show;
- (void)close;


/**
 <#Description#>

 @param frame <#frame description#>
 @param textStr 标题
 @param leftBtnStr <#leftBtnStr description#>
 @param rightBtnStr <#rightBtnStr description#>
 @param popType <#popType description#>
 @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame textStr:(NSString *)textStr leftBtnStr:(NSString *)leftBtnStr rightBtnStr:(NSString *)rightBtnStr popType:(CFPopType)popType;

- (instancetype)initWithFrame:(CGRect)frame newFriend:(NSString *)newfriend oldFriend:(NSString *)oldfriend reward:(NSString *)reward ;

- (instancetype)initWithFrame:(CGRect)frame textStr:(NSString *)textStr popType:(CFPopType)popType;

- (instancetype)initWithFrame:(CGRect)frame textStrs:(NSString *)textStrs;

- (void)setLeftBlock:(dispatch_block_t)letfBlock withRightBlock:(dispatch_block_t)rightBlock;

@end
