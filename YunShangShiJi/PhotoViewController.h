//
//  PhotoViewController.h
//  CollectionViewPhoto
//
//  Created by Mac on 16/4/19.
//  Copyright © 2016年 jyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrameModel.h"

#import "BaseModel.h"

@interface PersonPhoto : BaseModel
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *pic;
@property (nonatomic,strong)NSNumber *theme_id;
@property (nonatomic,strong)NSNumber *theme_type;//1.精选推荐  2.穿搭   3.普通话题
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSNumber *user_id;
@property (nonatomic,strong)NSDictionary *shop_list;
@end

@interface  PersonPhotosModel: BaseModel

@property (nonatomic,strong)NSString *pics;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong)NSArray *data;

+ (void)httpGetPersonPhotosModelSuccess:(void(^)(id data))success;
+ (void)httpGetPersonPhotoDetail:(NSString *)pic Success:(void(^)(id data))success;

@end

typedef void(^FootBtnClick)(NSInteger);
typedef void(^CurrentIndexBlock)(NSInteger);
typedef void(^AnimationCompleted)(void);

@interface PhotoViewController : UIViewController

@property (nonatomic, assign) CGRect imgFrame;
@property (nonatomic ,strong) NSData *imgData;
//@property (nonatomic, strong) NSArray *frameArray;
//@property (nonatomic, strong) NSArray *urlArray;
//@property (nonatomic, strong) NSArray *imgArray;
//@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *modelArray;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic,copy) FootBtnClick footBtnClick;
@property (nonatomic, copy) CurrentIndexBlock indexBlock;
@property (nonatomic, copy) AnimationCompleted completedBlock;

@end
