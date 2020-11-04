//
//  BrandStyleView.h
//  BrandStyleView
//
//  Created by yssj on 2017/3/31.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BrandStyleDelegate
- (void)leftMenuSelectLeft:(NSInteger)left right:(id)right info:(id) info;
- (void)rightMenuSelectLeft:(NSInteger)left right:(NSInteger)right info:(id) info;
@end

@interface BrandStyleView : UIView

@property (nonatomic,assign)id<BrandStyleDelegate>delegate;

@property(copy,nonatomic) NSArray *leftData;

-(instancetype)initWithData:(NSArray *)data;
- (void)show;

@end
