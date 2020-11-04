//
//  SignCell.h
//  YunShangShiJi
//
//  Created by yssj on 15/9/10.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *name;

@property (nonatomic, strong) UILabel *detail;

-(void)setImg:(NSString *)img name:(NSString *)name detail:(NSString *)detail;

@end
