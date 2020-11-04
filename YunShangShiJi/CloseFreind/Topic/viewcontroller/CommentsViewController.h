//
//  CommentsViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/18.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHContentCollectionView.h"
#import "TopicdetailsModel.h"
@interface CommentsViewController : UIViewController
@property (nonatomic , strong) HHContentCollectionView *collectionView;
@property (nonatomic , strong) HHContentCollectionView *collectionView1;
@property (nonatomic , strong) HHContentCollectionView *collectionView2;

@property (strong, nonatomic) UIImageView *tabheadview;           //导航条
@property (strong, nonatomic) NSString *theme_id;                 //帖子ID
@property (strong, nonatomic) TopicdetailsModel *detailmodel;     //详情数据
//评论回复
@property (nonatomic , strong) UIView *popBackView;               //底视图
@property (nonatomic , strong) UIView *Keyboardview;              //输入弹框
@property (nonatomic , strong) UIView *replyView;                 //回复框
@property (nonatomic , strong) UIButton *replyButton;             //回复按钮
@property (nonatomic , strong) UITextView *textview;              //回复框
@property (nonatomic , strong) UILabel * placeHolder;             //回复框提示
@property (nonatomic , strong) UIView *distapview;                //弹框消失

@end
