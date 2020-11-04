//
//  TopicdetailsViewController.h
//  TestStickHeader
//
//  Created by ios-1 on 2017/2/15.
//  Copyright © 2017年 liqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntimateCircleModel.h"
#import "YFDPImageView.h"
#import "FaceBoard.h"
@interface TopicdetailsViewController : UIViewController<UITextViewDelegate,FaceBoardDelegate>
@property (strong, nonatomic) UIImageView *tabheadview;            //导航条
//评论回复
@property (nonatomic , strong) UIView *popBackView;               //底视图
@property (nonatomic , strong) UIView *Keyboardview;              //输入弹框
@property (nonatomic , strong) UIView *replyView;                 //回复框
@property (nonatomic , strong) UIButton *replyButton;             //回复按钮
@property (nonatomic , strong) UITextView *textview;              //回复框
@property (nonatomic , strong) UILabel * placeHolder;             //回复框提示
@property (nonatomic , strong) UIView *distapview;                //弹框消失
@property (nonatomic , strong) NSString *theme_id;                //帖子ID
@property (nonatomic , strong) NSMutableArray *remenComments;     //热门评论
@property (nonatomic , strong) NSMutableArray *newestComments;    //最新评论
@property (nonatomic , strong) NSMutableArray *relatedrecommended;//相关推荐
@property (nonatomic , strong) UIImageView *SlideView;            //滑动浏览
@property (nonatomic , assign) BOOL browseFlag;                   //是否出现弹框

@property (nonatomic , assign) NSInteger currPage;              //评论当前页
@property (nonatomic , assign) NSInteger alltotalPage;          //评论总页数
@property (nonatomic , assign) NSInteger landlordPage;          //楼主评论总页数
@property (nonatomic , assign) NSInteger landlordcurrPage;      //评论当前页
@property (nonatomic , strong) NSString *comefrom;              //列表评论来
@property (nonatomic , assign) NSInteger recommentPage;         //相关推荐当前页
@property (nonatomic , assign) NSInteger recommentAllPage;      //相关推荐总页
@property (nonatomic , strong) NSMutableArray *recommendData;   //相关推荐数据
@property (nonatomic , strong) YFDPImageView * heardImgView;

@end
