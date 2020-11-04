//
//  ComboShopDetailViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/12/1.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
#import "CustomTitleView.h"
#import "WaterFLayout.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "TYSlidePageScrollView.h"

@interface ComboShopDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate,UIAlertViewDelegate, TYSlidePageScrollViewDelegate>

//滑动视图

@property (nonatomic, assign)NSInteger currPage;

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
//夺宝商品编号
@property (strong , nonatomic)NSString * duobao_shop_code;
@property (strong , nonatomic)UIScrollView *photoscrollview;

//记录是哪一类型进入详情页 （是积分兑换 还是。。。。）
@property (strong , nonatomic)NSString *typestring;
@property (nonatomic, strong) NSNumber *p_status;
//购物车商品数量
@property (strong , nonatomic)UILabel *marklable;
//积分商城生成订单编号
@property (strong , nonatomic)NSString *order_code;
//积分商品库存数据源
@property (strong , nonatomic)NSMutableArray *JifenshopArray;

//详情类型
@property (strong , nonatomic)NSString * stringtype;
//大图
@property (strong , nonatomic)UIImage *bigimage;

//列表视图
@property (strong , nonatomic)UITableView *MyBigtableview;
@property (strong , nonatomic)NSMutableArray *BigDataArray;
//加喜欢按钮
@property (strong , nonatomic)UIButton *likebtn;
//是会员列表
@property (strong , nonatomic)NSString *detailType;
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
@property (weak, nonatomic) IBOutlet UILabel *discountCount;

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
@property (nonatomic, strong)UIView *contentBackgroundView;
@property (nonatomic, assign)int index;


//商品属性
@property (nonatomic , strong)NSString *shuxing_id;
@property (nonatomic , strong)NSString *attr_name;
@property (nonatomic , strong)NSString *attr_Parent_id;
@property (nonatomic , strong)NSString *is_show;
@property (nonatomic , strong)NSNumber *r_num;


@property (nonatomic, strong) NSString *sharestr;
@property (nonatomic, strong)UIImageView *animationView;
@property (nonatomic, strong)NSString *invitCode;
@property (nonatomic, copy)NSString *flag;

//数据源
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *sizeArray;
@property (nonatomic, strong)NSMutableArray *SizeDataArray;
@property (nonatomic, strong)NSMutableArray *colorArray;
@property (nonatomic, strong)NSMutableArray *pubcolorArray;
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

//套餐商品数据源

@property (nonatomic, strong)NSMutableArray *hostDataArray;
@property (nonatomic, strong)NSMutableArray *selectColorArray;
@property (nonatomic, strong)NSMutableArray *selectIDarray;
@property (nonatomic, strong)NSMutableArray *selectSizeArray;
@property (nonatomic, strong)NSMutableArray *comobDataArray;
@property (nonatomic, strong)NSMutableArray *comboSizeArray;
@property (nonatomic, strong)NSMutableArray *tagDataArray1;
@property (nonatomic, strong)NSMutableArray *tagDataArray2;
@property (nonatomic, strong)NSMutableArray *tagDataArray3;

@property (nonatomic, strong)NSMutableArray *atrrListArray;
@property (nonatomic, strong)NSMutableArray *attrDataArray;
@property (nonatomic, assign)BOOL isSaleOut;
@property (nonatomic, copy) void (^paysuccessBlock)(NSString *);

@end
