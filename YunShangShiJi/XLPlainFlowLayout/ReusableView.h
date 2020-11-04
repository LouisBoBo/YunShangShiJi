//
//  ReusableView.h
//  PlainLayout
//
//  Created by hebe on 15/7/30.
//  Copyright (c) 2015年 ___ZhangXiaoLiang___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReusableView : UICollectionReusableView

- (void)receiveWithNames:(NSArray *)nameArr pubIndex:(NSInteger)pubIndex targe:(id)targe action:(SEL)action;

@end
