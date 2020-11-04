//
//  DPAddShopVC.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/17.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "DPAddShopVC.h"
#import "GlobalTool.h"
#import "MBProgressHUD+NJ.h"
#import "YFDPAddShopCell.h"
#import "YFAddShopBottomView.h"

#import "TFLoginView.h"
#import "LoginViewController.h"
#import "AddShopModel.h"
#import "AddShopCarModel.h"
#import "ShopCarCountModel.h"
#import "CollocationDetailModel.h"
#import "FMDatabase.h"
#import "ShopDetailModel.h"
#import "OrderTableViewController.h"
#import "NewShoppingCartViewController.h"

@interface DPAddShopVC ()<UITableViewDataSource, UITableViewDelegate, YFAddShopBottomViewDelegate>
{
    NSString *_shopCodes;       //商品编号（多个用“，”隔开）
    NSString *_pairedCode;      //联合商品编号
    CollocationDetailModel *_detailmodel; //颜色尺码
    
    NSArray *_datas;            //数据源
    NSArray *_stocktype;        //库存
    NSInteger _timeout;         //倒计时
    NSInteger _time;            //60秒提示
    NSString *_savePriceStr;    //节省
}
@property (nonatomic, strong) UITableView *mainTableView;       //主界面
@property (nonatomic, strong) YFAddShopBottomView *bottomView;  //底部
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DPAddShopVC

- (instancetype)initWithShopCodes:(NSString *)shopCodes pairedCode:(NSString *)pairedCode detaiModel:(CollocationDetailModel *)model{
    self = [super init];
    if (self) {
        _shopCodes = [shopCodes copy];
        _pairedCode = [pairedCode copy];
        _detailmodel = model;
        _timeout = 0;
        _time = 61;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%@释放了",[self class]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //加载数据
//    [self loadShopCarCount:YES];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [DataManager sharedManager].outAppStatistics=@"搭配购立即结算页";

    //创建UI
    [self setUI];
    [NSObject findCachefileExistsAtPath:@""];
}

#pragma mark - UI
- (void)setUI {
    [self setNavigationBackWithTitle:@"搭配购"];
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.bottomView];

    __weak typeof(self) weakSelf = self;
    // 加载失败重新加载
    [self loadFailBtnBlock:^{
        [weakSelf loadData];
    }];

}

#pragma mark - 加载数据
- (void)loadData {
    if (_datas.count == 0) {
        [MBProgressHUD showHUDAddTo:self.view animated:YES];
    }
    [AddShopModel getAddShopModelWithShopCodes:_shopCodes success:^(id data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        AddShopModel *model = data;
        if (model.status == 1) {
            if (model.stocktype.count > 0) {
                [self dataProcessingModel:model];
            } else {
                if (_datas.count == 0) {
                    [self loadingDataBackgroundView:self.mainTableView img:nil text:nil];
                }
            }
        } else {
            [MBProgressHUD showError:model.message];
            if (_datas.count == 0) {
               [self loadingDataBackgroundView:self.mainTableView img:[UIImage imageNamed:@"哭脸"] text:@"亲,没网了"];
            }
        }
    }];
}

/// 数据处理
- (void)dataProcessingModel:(AddShopModel *)model {
    _stocktype = [model.stocktype copy];//库存
    NSArray *shopAttr = [_shopCodes componentsSeparatedByString:@","];//商品编号
    
    NSMutableArray *array = [NSMutableArray array];//处理后数据
    for (int i = 0; i < shopAttr.count; i++) {
        NSString *key = shopAttr[i];
        NSArray *colors = nil;
        NSArray *sizes = nil;
        
        //颜色尺寸
        NSString *colorSize = [model.shop_attr objectForKey:key];
        if ([[NSNull null] isEqual:colorSize])
            continue;
        //取前两个（颜色，尺码）
        NSArray *colorOrSize = [colorSize isKindOfClass:[NSNull class]]?nil:[colorSize componentsSeparatedByString:@"_"];
        if (colorOrSize.count > 2) {
            colorOrSize = [colorOrSize subarrayWithRange:NSMakeRange(0, 2)];
        }
        
        for (NSString *str in colorOrSize) {
            NSRange rangeC = [str rangeOfString:@"500,"];//颜色
            NSRange rangeS = [str rangeOfString:@"502,"];//尺码
            //颜色
            if (rangeC.location != NSNotFound) {
                NSUInteger location = rangeC.location + rangeC.length;
                NSString *colorStr = [str substringWithRange:NSMakeRange(location, str.length - location)];
                colors = [[colorStr componentsSeparatedByString:@","] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
                    return obj1.intValue > obj2.intValue;
                }];
            }
            //尺码
            if (rangeS.location != NSNotFound) {
                NSUInteger location = rangeS.location + rangeS.length;
                NSString *colorStr = [str substringWithRange:NSMakeRange(location, str.length - location)];
                sizes = [[colorStr componentsSeparatedByString:@","] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
                    return obj1.intValue > obj2.intValue;
                }];
            }
        }
        
        DPShopModel *dsModel = [[DPShopModel alloc] init];
        dsModel.shop_code = key;
        dsModel.colors = [self namesByIds:colors shopCode:key];
        dsModel.sizes = [self namesByIds:sizes shopCode:key];
        NSInteger sidx = 0;
        NSInteger cidx = 0;
        BOOL isCode = NO;
        for (int j = 0; j < dsModel.colors.count; j++) {
            for (int k = 0; k < dsModel.sizes.count; k++) {
                BOOL isStock = [self isStockWithModel:dsModel cidx:j sidx:k isNoStock:NO];
                NSDictionary *dicC = dsModel.colors[j];
                NSMutableArray *cAry = [dicC objectForKey:@"isSelect"];
                if (isStock) {
                    [cAry addObject:@(k)];
                    sidx = isCode?sidx:k;
                    cidx = isCode?cidx:j;
                    isCode = YES;
                }
            }
        }
        
        if (isCode) {
            if (_datas.count > 0) {
                for (DPShopModel *model in _datas) {
                    if ([model.shop_code isEqualToString:key]) {
                        dsModel.shopNumber = model.shopNumber;
                        dsModel.isSelect = model.isSelect;
                        [self isStockWithModel:dsModel cidx:model.colorIndex sidx:model.sizeIndex isNoStock:NO];
                    }
                }
            } else {
                [self isStockWithModel:dsModel cidx:cidx sidx:sidx isNoStock:NO];
            }
            [array addObject:dsModel];
        }
    }
    _datas = [array copy];
    if (_datas.count <= 0) {
        //无数据
        [self loadingDataBackgroundView:self.mainTableView img:nil text:nil];
    } else {
        [self loadingDataSuccess];
        [self.mainTableView reloadData];
    }
    [self dataCalculation];
}

/// 是否存在库存并且修改当前源数据
- (BOOL)isStockWithModel:(DPShopModel *)model cidx:(NSInteger)cidx sidx:(NSInteger)sidx isNoStock:(BOOL)isNoStock{
    NSDictionary *dicC = model.colors.count > cidx?model.colors[cidx]:nil;
    NSDictionary *dicS = model.sizes.count > sidx?model.sizes[sidx]:nil;
    NSString *color = [dicC objectForKey:@"id"];
    NSString *size = [dicS objectForKey:@"id"];
    for (DPShopModel *sModel in _stocktype) {
        NSString *colorSize = [NSString stringWithFormat:@"%@:%@",color, size];
        if ([sModel.shop_code isEqualToString:model.shop_code]&&[sModel.color_size isEqualToString:colorSize]&&((sModel.stock > 0)||isNoStock)) {
            model.sID = sModel.sID;
            model.pic = sModel.pic;
            model.shop_name = sModel.shop_name;
            model.price = sModel.price;
            model.shop_price = sModel.shop_price;
            model.stock = sModel.stock;
            model.color_size = sModel.color_size;
            model.shop_code = sModel.shop_code;
            model.kickback = sModel.kickback;
            model.three_kickback = sModel.three_kickback;
            model.two_kickback = sModel.two_kickback;
            model.original_price = sModel.original_price;
            model.core = sModel.core;
            model.supp_id = sModel.supp_id;
            model.colorIndex = cidx;
            model.sizeIndex = sidx;
            model.shopNumber = model.shopNumber > model.stock?model.stock:model.shopNumber?:1;
            return YES;
        }
    }
    model.colorIndex = cidx;
    model.sizeIndex = sidx;
    model.shopNumber = 0;
    model.stock = 0;
    return NO;
}

/// 是否存在当前属性的商品
- (BOOL)isNameWithShopCode:(NSString *)shopCode name:(NSString *)name{
    for (DPShopModel *model in _stocktype) {
        if ([shopCode isEqualToString:model.shop_code] && ([model.color_size rangeOfString:name].location != NSNotFound)) {
            return YES;
        }
    }
    return NO;
}

/// 从数组中取出id对应的名称
- (NSArray *)namesByIds:(NSArray *)ids shopCode:(NSString *)shopCode{
    NSMutableArray* array = [NSMutableArray array];
    for (NSString *sID in ids) {
        if ([self isNameWithShopCode:shopCode name:sID]) {
            for (NSDictionary *dic in _detailmodel.attrList) {
                if ([sID isEqualToString:[dic objectForKey:@"id"]]) {
                    NSString *name = [dic objectForKey:@"attr_name"];
                    NSMutableDictionary *dicC = [NSMutableDictionary dictionary];
                    [dicC setObject:sID forKey:@"id"];
                    [dicC setObject:name forKey:@"name"];
                    [dicC setObject:[NSMutableArray array] forKey:@"isSelect"];
                    [array addObject:dicC];
                }
            }
        }
    }
    return [array copy];
}

/// 购物车数量
- (void)loadShopCarCount:(BOOL)isTime {
    [ShopCarCountModel getShopCarCountWithSuccess:^(id data) {
        ShopCarCountModel *model = data;
        if (model.status == 1&&model.cart_count>0) {
            _bottomView.carBtn.markNumber = model.cart_count;
            if (isTime) {
                NSInteger time = (NSInteger)(model.s_deadline - model.s_time)/1000;
                if (time > 0) {
                    if (_timeout <= 0) {
                        _timeout = time;
                        [self timer];
                    } else {
                        _timeout = time;
                    }
                } else {
                    _timeout = 0;
                }
            }
        } else {
            _timeout = 0;
            _bottomView.carBtn.markNumber = 0;
        }
    }];
}

/// 立即结算
- (void)addShopCar {
    NSMutableArray *array = [NSMutableArray array];
    CGFloat allPrice = 0;

    NSString *dpZheKou = [[NSUserDefaults standardUserDefaults]objectForKey:@"dpZheKou"];

    for (DPShopModel *model in _datas) {
        ShopDetailModel *dmodel=[[ShopDetailModel alloc] init];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *size = model.sizes.count>model.sizeIndex?[((NSDictionary *)model.sizes[model.sizeIndex]) objectForKey:@"name"]:@"";
        NSString *color = model.colors.count>model.colorIndex?[((NSDictionary *)model.colors[model.colorIndex]) objectForKey:@"name"]:@"";
        NSNumber *userId = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
        NSString *storeCode = [[NSUserDefaults standardUserDefaults] objectForKey:STORE_CODE];
        
        dmodel.user_id = userId?[userId copy ]:[@"" copy];
        dmodel.shop_size = size?:@"";
        dmodel.shop_color = color?:@"";
        dmodel.stock_type_id = @(model.sID).stringValue;
        dmodel.shop_num = @(model.shopNumber).stringValue;
        dmodel.shop_name = model.shop_name?:@"";
        dmodel.shop_price = model.shop_price?:@"";
        dmodel.shop_se_price = model.price?:@"";
        dmodel.def_pic = model.pic?:@"";
        dmodel.shop_code = model.shop_code?:@"";
        dmodel.supp_id = model.supp_id?:@"";
        dmodel.kickback = model.kickback?:@"";
        dmodel.core = model.core?:@"";
        dmodel.original_price = model.original_price?:@"";
        dmodel.store_code = storeCode?:@"";
        dmodel.ID = @(model.sID).stringValue;
        dmodel.shop_from=@"0";
        [array addObject:dmodel];

        
        allPrice += [model.price floatValue]*model.shopNumber*(1-dpZheKou.floatValue);//0.05
    }
    
    OrderTableViewController *view = [[OrderTableViewController alloc]init];
    view.sortArray = [array copy];
    view.haveType=YES;
    view.coutTime=-1;
    view.allResavePrice= allPrice;
    [self.navigationController pushViewController:view animated:YES];
    
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"搭配购页面”立即结算“" success:^(id data, Response *response) {
    } failure:^(NSError *error) {
    }];
    
#if 0
    NSString *comID = nil;
    for (int i = 0; i < _datas.count; i++) {
        DPShopModel *model = _datas[i];
        if (model.isSelect&&model.stock>0) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            NSString *size = model.sizes.count>model.sizeIndex?[((NSDictionary *)model.sizes[model.sizeIndex]) objectForKey:@"name"]:@"";
            NSString *color = model.colors.count>model.colorIndex?[((NSDictionary *)model.colors[model.colorIndex]) objectForKey:@"name"]:@"";
            NSNumber *userId = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
            NSString *storeCode = [[NSUserDefaults standardUserDefaults] objectForKey:STORE_CODE];
            
            [dic setObject:userId?:@"" forKey:@"user_id"];
            [dic setObject:size?:@"" forKey:@"size"];
            [dic setObject:color?:@"" forKey:@"color"];
            [dic setObject:@(model.sID) forKey:@"stock_type_id"];
            [dic setObject:@(model.shopNumber) forKey:@"shop_num"];
            [dic setObject:model.shop_name?:@"" forKey:@"shop_name"];
            [dic setObject:model.shop_price?:@"" forKey:@"shop_price"];
            [dic setObject:model.price?:@"" forKey:@"shop_se_price"];
            [dic setObject:model.pic?:@"" forKey:@"def_pic"];
            [dic setObject:model.shop_code?:@"" forKey:@"shop_code"];
            [dic setObject:model.supp_id?:@"" forKey:@"supp_id"];
            [dic setObject:model.kickback?:@"" forKey:@"kickback"];
            [dic setObject:model.original_price?:@"" forKey:@"original_price"];
            [dic setObject:storeCode?:@"" forKey:@"store_code"];
            
            [array addObject:dic];
        }
    }
    
    [AddShopCarModel getAddShopCarModelWithPairedCode:_pairedCode cartJson:array success:^(id data) {
        AddShopCarModel *model = data;
        if (model.status == 1) {
            [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"RFTCart"];//用于刷新tabbar的购物车

                [self addShopCarAnimate];
        } else {
            _bottomView.addBtn.userInteractionEnabled = YES;
            [MBProgressHUD showError:model.message];
        }
    }];
#endif
}

#pragma mark - 点击事件
/// 跳转购物车
- (void)shopcartClick:(UIButton *)sender {
    [self loginVerifySuccess:^{
//        WTFCartViewController *shoppingcart =[[WTFCartViewController alloc]init];
//        shoppingcart.segmentSelect = CartSegment_NormalType;
//        shoppingcart.CartType = Cart_NormalType;
//        shoppingcart.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:shoppingcart animated:YES];
        
        NewShoppingCartViewController *shoppingcart =[[NewShoppingCartViewController alloc]init];
        shoppingcart.ShopCart_Type = ShopCart_NormalType;
        shoppingcart.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shoppingcart animated:YES];
    }];
}

/// 跳转登录注册页面
- (void)ToLogin :(NSInteger)tag {
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag = tag;
    login.loginStatue=@"toBack";
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:YES];
}

/// 1分钟倒计时完成
- (void)shopTimeout {
    [_bottomView setTopIsHidden:YES];
    _bottomView.top = self.view.height - kZoom6pt(90);
    _bottomView.height = kZoom6pt(90);
}

/// 加入购物车成功动画
- (void)addShopCarAnimate {
    //商品图片飞入购物车动画
    [_bottomView.carBtn animationCar];
    [self loadShopCarCount:YES];
    [self loadData];
    //更新购物车数量
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //调整frame
        _bottomView.top = self.view.height - kZoom6pt(130);
        _bottomView.height = kZoom6pt(130);
        //显示30分钟提示
        [_bottomView setTopIsHidden:NO];
        _time = 0;
        _bottomView.addBtn.userInteractionEnabled = YES;
    });
}

/// 全选
- (void)selectAllShop {
    for (DPShopModel *model in _datas) {
        if (model.stock>0) {
            model.isSelect = !_bottomView.isAllSelect;
        }
    }
    [_mainTableView reloadData];
    [self dataCalculation];
}

#pragma mark - 数据计算
/// 金额计算
- (void)dataCalculation {
    BOOL isAll = _datas.count;
    BOOL isNoShop = NO;
    NSUInteger number = 0;
    CGFloat allPrice = 0.;
    CGFloat savePrice = 0.;
    for (DPShopModel *model in _datas) {
        if (model.isSelect && model.stock > 0) {
            number += model.shopNumber;
            allPrice += [model.price floatValue]*model.shopNumber;
            isNoShop = YES;
        } else {
            isAll = NO;
        }
    }

    NSString *dpZheKou = [[NSUserDefaults standardUserDefaults]objectForKey:@"dpZheKou"];
    if (isAll&&_datas.count>1) {
        savePrice = allPrice;
        allPrice *= dpZheKou.floatValue;//0.95
        savePrice *= (1-dpZheKou.floatValue);//0.05;
    }
    
    NSString *allPriceStr = [NSString stringWithFormat:@"¥%.2f",allPrice];// [self notRounding:allPrice afterPoint:2];
    NSString *savePriceStr = [NSString stringWithFormat:@"¥%.2f",savePrice];//[self notRounding:savePrice afterPoint:2];
    NSString *str = [NSString stringWithFormat:@"%lu件商品共%@,搭配购为您节省%@",(unsigned long)number,allPriceStr,savePriceStr];
    _bottomView.centerLabel.attributedText = [NSString getOneColorInLabel:str strs:@[allPriceStr,savePriceStr] Color:tarbarrossred fontSize:kZoom6pt(12)];

    _bottomView.isAllSelect = isAll;
    _bottomView.addBtn.selected = isNoShop;
}

/// price:需要处理的数字，position：保留小数点第几位
- (NSString *)notRounding:(CGFloat)price afterPoint:(int)position {
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];;
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"¥%@",roundedOunces];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [YFDPAddShopCell cellHeightWithModel:_datas[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"DPAddShopCell";
    YFDPAddShopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[YFDPAddShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    DPShopModel *model = _datas[indexPath.row];
    __weak typeof(self) weakSelf = self;
    //选择颜色与尺码
    cell.colorSizeBlock = ^(NSInteger cidx, NSInteger sidx){
        [weakSelf isStockWithModel:model cidx:cidx sidx:sidx isNoStock:YES];
        [weakSelf.mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [weakSelf dataCalculation];
    };
    //勾选／取消商品
    cell.selectBlock = ^(BOOL select){
        model.isSelect = select;
        [weakSelf dataCalculation];
    };
    //商品数量
    cell.numberBlock = ^(NSInteger number){
        model.shopNumber = number;
        [weakSelf dataCalculation];
    };
    [cell receiveDataModel:model];
    return cell;
}

#pragma mark - YFAddShopBottomViewDelegate
- (void)buttonClickType:(YFAddAddShopBtnType)type {
    switch (type) {
        case YFAddAddShopBtnBuynow:     //立即购买
            [self shopcartClick:nil];
            break;
        case YFAddAddShopBtnAllSelect:  //全选
            [self selectAllShop];
            break;
        case YFAddAddShopBtnShop:       //购物车
            [self shopcartClick:nil];
            break;
        case YFAddAddShopBtnAdd:        //立即结算
        {
//            _bottomView.addBtn.userInteractionEnabled = NO;
            [self loginVerifySuccess:^{
                [self addShopCar];
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - getter
- (UITableView *)mainTableView {
    if (nil == _mainTableView) {
        CGRect frame = self.view.bounds;
        frame.size = CGSizeMake(frame.size.width, frame.size.height - kNavigationBarHeight - kStatusBarHeight - kZoom6pt(80));
        frame.origin = CGPointMake(0, 64);
        _mainTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.tableFooterView = [UIView new];
        _mainTableView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

- (YFAddShopBottomView *)bottomView {
    if (nil == _bottomView) {
        _bottomView = [[YFAddShopBottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - kZoom6pt(90), self.view.frame.size.width, kZoom6pt(90))];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

- (NSTimer *)timer {
    if (nil == _timer) {
        _timer = [NSTimer weakTimerWithTimeInterval:1.0 target:self userInfo:nil repeats:YES block:^(DPAddShopVC *target, NSTimer *timer) {
            if(target -> _timeout <= 0){ //倒计时结束，关闭
                [target.timer invalidate];
                target.timer = nil;
                target.bottomView.carBtn.time = @"";
                [target loadShopCarCount:NO];
            } else {
                NSInteger minute = target -> _timeout/60;
                NSInteger seconds = target -> _timeout%60;
                NSString *strTime = [NSString stringWithFormat:@"%02ld:%02ld", (long)minute, (long)seconds];
                target.bottomView.carBtn.time = strTime;
                if (target -> _time >= 60) {
                    [target shopTimeout];
                }
                target -> _timeout--;
                target -> _time++;
            }
        }];
    }
    return _timer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
