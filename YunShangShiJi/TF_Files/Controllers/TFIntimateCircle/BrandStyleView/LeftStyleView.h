//
//  LeftStyleView.h
//  BrandStyleView
//
//  Created by yssj on 2017/4/1.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftStyleView : UIView

@property(copy,nonatomic,readonly) id block;
@property (nonatomic,strong)UICollectionView *StyleCollectionView;

-(instancetype)initWithFrame:(CGRect)frame WithData:(NSArray*)data withSelectIndex:(void(^)(NSInteger left,id right,id info))selectIndex;

@end
