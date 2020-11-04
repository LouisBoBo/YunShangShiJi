//
//  CommentCollectionViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/18.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicdetailsModel.h"
#import "TopselectView.h"

@interface CommentCollectionViewController : UIViewController
@property (strong, nonatomic) UIImageView *tabheadview;           //导航条
@property (strong, nonatomic) TopselectView * topselectView;      //选择条
@property (strong, nonatomic) UICollectionView *collectionview;
@property (nonatomic , assign) NSInteger pageIndex;               //当前界面
@property (nonatomic , assign) NSInteger currPage;                //当前页
@property (nonatomic , strong) NSMutableArray *remenComments;     //热门评论
@property (nonatomic , strong) NSMutableArray *newestComments;    //最新评论

@property (nonatomic , copy)   NSString *theme_id;                //帖子ID
@property (nonatomic , strong) TopicdetailsModel *detailmodel;    //详情数据

//评论回复
@property (nonatomic , strong) UIView *popBackView;               //底视图
@property (nonatomic , strong) UIView *Keyboardview;              //输入弹框
@property (nonatomic , strong) UIView *replyView;                 //回复框
@property (nonatomic , strong) UIButton *replyButton;             //回复按钮
@property (nonatomic , strong) UITextView *textview;              //回复框
@property (nonatomic , strong) UILabel * placeHolder;             //回复框提示
@property (nonatomic , strong) UIView *distapview;                //弹框消失

@end
