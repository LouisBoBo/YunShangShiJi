//
//  CollectionImageMenuReusableView.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/9/19.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewTaskMenuButtonView;
@interface CollectionImageMenuReusableView : UICollectionReusableView
@property(nonatomic,strong)UIImageView *headImgView;
@property(nonatomic,strong)NewTaskMenuButtonView *menubackview;
@end

typedef void(^MenuBtnClickBlock)(NSInteger btnClickIndex);
@interface NewTaskMenuButtonView : UIView

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *normalImgArray;
@property (nonatomic, strong) NSArray *selectImgArray;

@property (nonatomic, copy) MenuBtnClickBlock menuBtnClickBlock;
- (void)show;
@end
