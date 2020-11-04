//
//  ZYTagInfo.h
//  ZYTagViewDemo
//
//  Created by ripper on 2016/9/28.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZYTagDirectionNormal,
    ZYTagDirectionLeft,
    ZYTagDirectionRight,
} ZYTagDirection;

/** 比例 */
struct ZYPositionProportion {
    CGFloat x;
    CGFloat y;
};
typedef struct ZYPositionProportion ZYPositionProportion;
ZYPositionProportion ZYPositionProportionMake(CGFloat x, CGFloat y);

@interface ZYTagInfo : NSObject
@property (assign,nonatomic)BOOL isShopTag;         //是不是商品标签
@property (nonatomic,strong)NSMutableDictionary *dic;
@property (nonatomic,copy) NSNumber *label_id;
@property (nonatomic,copy) NSNumber *label_type;
@property (nonatomic,copy) NSNumber *style;
@property (nonatomic,copy) NSNumber *type1;
@property (nonatomic,copy) NSNumber *type2;
@property (nonatomic,copy) NSNumber *label_x;
@property (nonatomic,copy) NSNumber *label_y;

/** 记录位置点 */
@property (nonatomic, assign) CGPoint point;
/** 记录位置点在父视图中的比例 */
@property (nonatomic, assign) ZYPositionProportion proportion;
/** 方向 */
@property (nonatomic, assign) ZYTagDirection direction;
/** 标题 */
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detailTitle;

/** 其他需要存储的数据 */
@property (nonatomic, strong) id object;
/*标识是哪一个标签*/
@property (nonatomic, assign) NSInteger index;
/** 初始化 */
+ (ZYTagInfo *)tagInfo;

@end
