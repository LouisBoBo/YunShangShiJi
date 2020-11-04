//
//  SpecialCollocationModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface SpecialCollocationModel : BaseModel
@property (nonatomic , strong) NSString *collocation_code;      //专题编号
@property (nonatomic , strong) NSString *collocation_pic;       //专题图片
@property (nonatomic , strong) NSString *collocation_name;      //专题主名称
@property (nonatomic , strong) NSString *collocation_name2;     //专题副名称

@end
