//
//  OneIndianaDetailViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/25.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
#import "CustomTitleView.h"
#import "WaterFLayout.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "TYSlidePageScrollView.h"

#import "TFScreenViewController.h"
#import "TFScreeningBackgroundView.h"
#import "TFSearchViewController.h"
#import "TreasureRecordsModel.h"
@interface OneIndianaDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate,UIAlertViewDelegate, TYSlidePageScrollViewDelegate>

//滑动视图

@property (nonatomic, assign)NSInteger currPage;
@property (nonatomic, copy) NSString *shop_se_price;
@property (weak, nonatomic) IBOutlet UIScrollView *Myscrollview;
//计时器
@property (weak, nonatomic) IBOutlet UILabel *Timelable;
//当前选中的按钮
@property (strong , nonatomic)UIButton *slectbtn;
//当前选中的尺码按钮
@property (strong , nonatomic)UIButton *sizeslectbtn;
//当前选中的是 联系买家/加入购物车/购买 按钮
@property (assign , nonatomic)NSInteger tag;
//商品编号
@property (strong , nonatomic)NSString *shop_code;
//包邮商品编号
@property (strong , nonatomic)NSString * baoyou_shop_code;

@property (strong , nonatomic)UIScrollView *photoscrollview;

//记录是哪一类型进入详情页 （是积分兑换 还是。。。。）
@property (strong , nonatomic)NSString *typestring;

//购物车商品数量
@property (strong , nonatomic)UILabel *marklable;
//积分商城生成订单编号
@property (strong , nonatomic)NSString *order_code;
//积分商品库存数据源
@property (strong , nonatomic)NSMutableArray *JifenshopArray;

//购物车是从什么地方进去的
//详情类型
@property (strong , nonatomic)NSString * stringtype;
//大图
@property (strong , nonatomic)UIImage *bigimage;

//列表视图
@property (strong , nonatomic)UITableView *MyBigtableview;
@property (strong , nonatomic)NSMutableArray *BigDataArray;
//加喜欢按钮
@property (strong , nonatomic)UIButton *likebtn;
@property (weak, nonatomic) IBOutlet UILabel *priceline;

@property (weak, nonatomic) IBOutlet UIImageView *Headimage;
@property (weak, nonatomic) IBOutlet UILabel *shopname;
@property (weak, nonatomic) IBOutlet UILabel *se_price;
@property (weak, nonatomic) IBOutlet UILabel *oldprice;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *discount;
@property (weak, nonatomic) IBOutlet UILabel *posttage;
@property (weak, nonatomic) IBOutlet UIView *startview;
@property (weak, nonatomic) IBOutlet UIView *backview;
@property (weak, nonatomic) IBOutlet UILabel *huiyong;

@property (weak, nonatomic) IBOutlet UILabel *line1;
@property (weak , nonatomic)OrderDetailModel *orderdetailModel;

//图片数据源
@property (strong , nonatomic)NSMutableArray *ImageArray;
//图片高度数据源
@property (strong , nonatomic)NSMutableArray *ImageHeighArray;

@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *title3;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;

//商品列表
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *collectionDataArr;
@property (nonatomic, strong)NSMutableArray *heighArray;
@property (nonatomic, strong)CustomTitleView *customTitleView;
@property (nonatomic, strong)CustomTitleView *collectTitleView;
@property (nonatomic, assign)int index;


//商品属性
@property (nonatomic , strong)NSString *shuxing_id;
@property (nonatomic , strong)NSString *attr_name;
@property (nonatomic , strong)NSString *attr_Parent_id;
@property (nonatomic , strong)NSString *is_show;


@property (nonatomic, strong) NSString *sharestr;
@property (nonatomic, strong)UIImageView *animationView;
@property (nonatomic, strong)NSString *invitCode;

//数据源
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *sizeArray;
@property (nonatomic, strong)NSMutableArray *SizeDataArray;
@property (nonatomic, strong)NSMutableArray *colorArray;
@property (nonatomic, strong)NSMutableArray *commentArray;
@property (nonatomic, strong)NSMutableArray *commentDataArray;
@property (nonatomic, strong)NSMutableArray *stocktypeArray;
@property (nonatomic, strong)NSMutableArray *stock_colorArray;
@property (nonatomic, strong)NSMutableArray *stock_sizeArray;
//@property (nonatomic, strong)NSMutableArray *JifenshopArray;
//@property (nonatomic, strong)NSMutableArray *ImageArray;
@property (nonatomic, strong)NSMutableArray *ImageDataArray;
//@property (nonatomic, strong)NSMutableArray *ImageHeighArray;
//@property (nonatomic, strong)NSMutableArray *BigDataArray;
@property (nonatomic, strong)NSMutableArray *shopAirveIDArr;
@property (nonatomic, strong)NSMutableArray *shopDirvelArr;
@property (nonatomic, strong)NSMutableArray *DeliverArray;
@property (nonatomic, strong)NSMutableArray *tagNameArray;
@property (nonatomic, strong)NSMutableArray *sequenceArray;
@property (nonatomic, strong)NSMutableArray *IDArray;
@property (nonatomic, strong)NSMutableDictionary *sequenceDictionary;


#pragma mark - +++++++++++++++++++++++++++++++++++
@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, strong)UITableView *searchTableView;
@property (nonatomic, strong)UIView *leftHandView;
@property (nonatomic, strong)UIView *searchRightView;
@property (nonatomic, strong)UIButton *searchBtn;
@property (nonatomic, strong)UIButton *screenBtn;


@property (strong, nonatomic) IBOutlet UIView *leftBackgroundView;
@property (strong, nonatomic) IBOutlet UIView *contentBackgroundView;

@property (strong, nonatomic)UIView *screenView;
@property (nonatomic, strong)TFScreeningBackgroundView *screeningScrollView;

@property (nonatomic, assign)BOOL isScreenAnimationFinished;  
@property (nonatomic, assign)BOOL isOpen;
@property (nonatomic, strong)NSMutableArray *searchDataArr;
@property (nonatomic, strong)NSMutableArray *searchCateArr;

@property (nonatomic, strong)NSMutableArray *screenDataArr;
@property (nonatomic, strong)NSMutableArray *screenCateArr;

//夺宝规则数据源
@property (nonatomic, strong)NSMutableArray *ruleDataArray;
//夺宝参与者数据源
@property (nonatomic, strong)NSMutableArray *participateArray;

//虚拟参与人数
@property (nonatomic, strong)NSNumber *virtual_num;

@property (nonatomic , strong)NSString *typeName;
@property (nonatomic , strong)NSNumber *typeID;

@property (nonatomic, copy)void (^addLikeBlock)();
@property (nonatomic, copy)void (^cancelLikeBlock)();
@property (nonatomic, copy)void (^addShopCartBlock)();

@property (nonatomic, copy)void (^paySuccessBlock)(NSString*);
@property (nonatomic, strong)TreasureRecordsModel *recordsModel;

@property (nonatomic, strong) UIButton *AnnouncedBtn;     //往期揭晓
@property (nonatomic, strong) UIButton *RecordBtn;        //夺宝记录

@property (nonatomic, assign) NSInteger httpPage;         //往期幸运星页数
@property (nonatomic, assign) NSInteger winnerStatue;     //我参与夺宝的状态
@end
