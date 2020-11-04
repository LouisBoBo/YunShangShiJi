//
//  CollectionImageHeaderView.m
//  YunShangShiJi
//
//  Created by YF on 2017/9/13.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "CollectionImageHeaderView.h"
#import "GlobalTool.h"


@implementation CollectionImageHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        _headImgView = [[UIImageView alloc]init];
        _headImgView.frame = CGRectMake(0,0, kScreenWidth,frame.size.height);
//        _headImgView.backgroundColor=DRandomColor;
        [self addSubview:_headImgView];

    }
    return self;
}

@end


