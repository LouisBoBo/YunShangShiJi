//
//  ChangeShopPopview.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/1/18.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "ChangeShopPopview.h"
#import "ShopDetailModel.h"
#import "UIImageView+WebCache.h"
#import "DefaultImgManager.h"
#import "YFDPAddShopCell.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "AddShopModel.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "MBProgressHUD.h"
#import "CollocationDetailModel.h"
#import "ChangShopTableViewCell.h"
#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]
@implementation ChangeShopPopview
{
    CGFloat shareimageYY ;
    
    CGFloat invitcodeYY;                  //弹框初始y坐标
    CGFloat PopViewHeigh;                 //弹框的高度
    CGFloat PopViewWidth;                 //弹框的宽度
    
    NSArray *_datas;                      //数据源
    NSArray *_stocktype;                  //商品库存
    CollocationDetailModel *_detailmodel; //颜色尺码
    
    int changeCount ;
    
}
- (instancetype)initWithFrame:(CGRect)frame ShopModel:(ShopDetailModel*)model;
{
    if(self = [super initWithFrame:frame])
    {
        self.shopdetailModel = model;
        [self requestHttp];
        
        [self creaPopview];
    }
    return self;
}

- (void)creaPopview
{
    _Popview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    _Popview.userInteractionEnabled = YES;
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick)];
//    [_Popview addGestureRecognizer:tap];

    [self addSubview:_Popview];
    
    PopViewWidth = kScreenWidth;
    PopViewHeigh = ZOOM6(800);
    invitcodeYY  = kScreenHeight - PopViewHeigh;
    
    //底视图
    _BackView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, PopViewWidth, PopViewHeigh)];
    _BackView.userInteractionEnabled = YES;
    _BackView.backgroundColor = [UIColor whiteColor];
    [_Popview addSubview:_BackView];

    //主视图
    [_BackView addSubview:self.mainTableView];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _BackView.frame = CGRectMake(0, invitcodeYY, PopViewWidth, PopViewHeigh);
    } completion:^(BOOL finish) {
        
    }];

}

-(void)requestHttp
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    manager.requestSerializer.timeoutInterval = 10;
    
    
    NSString *url;
    if(token == nil)
    {
        url=[NSString stringWithFormat:@"%@shop/queryUnLogin?version=%@&code=%@",[NSObject baseURLStr],VERSION,self.shopdetailModel.shop_code];
    }else{
        
        url=[NSString stringWithFormat:@"%@shop/query?version=%@&code=%@&token=%@",[NSObject baseURLStr],VERSION,self.shopdetailModel.shop_code,token];
        
    }
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                if([responseObject[@"attrList"]count])
                {
                    self.dataDictionaryArray = [NSMutableArray arrayWithArray:responseObject[@"attrList"]];
                    [self loadData];
                }
            }
        
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - 加载数据
- (void)loadData {
    
    [AddShopModel getAddShopModelWithShopCodes:self.shopdetailModel.shop_code success:^(id data) {
        
        AddShopModel *model = data;
        if (model.status == 1) {
            if (model.stocktype.count > 0) {
                [self dataProcessingModel:model];
            } else {
                if (_datas.count == 0) {
                    
                }
            }
        } else {
            
            if (_datas.count == 0) {
               
            }
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ChangShopTableViewCell cellHeightWithModel:_datas[indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"ChangShopTableViewCell";
    ChangShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[ChangShopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    DPShopModel *model = _datas[indexPath.row];
    model.shopNumber = [self.shopdetailModel.shop_num integerValue];
    cell.isNewbie = self.isNewbie;
 
    __weak typeof(self) weakSelf = self;
    //选择颜色与尺码
    cell.colorSizeBlock = ^(NSInteger cidx, NSInteger sidx){
        
        [weakSelf isStockWithModel:model cidx:cidx sidx:sidx isNoStock:YES];
        [weakSelf.mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    //勾选／取消商品
    cell.selectBlock = ^(BOOL select){
        model.isSelect = select;
    };
    //商品数量
    cell.numberBlock = ^(NSInteger number){
        
        if(number >=2)
        {
            changeCount++;
        }else{
            changeCount=0;
        }
        
        if(self.tag == 989898)
        {
            [MBProgressHUD show:@"拼团商品只能选择1件哦~" icon:nil view:self];
            
        }else if (self.miniShareSuccess)
        {
            [MBProgressHUD show:@"1元购单次只能选择1件哦~" icon:nil view:self];
        }
        else{
            if(changeCount>=2)
            {
                [MBProgressHUD show:@"抱歉,数量有限,最多只能购买2件噢!" icon:nil view:self];
                changeCount --;
            }
        }
        model.shopNumber = number;
    };
    //关闭视图
    cell.dismissModalView = ^{
        [self hidePopview];
    };
    //确定按钮
    cell.okchange = ^{
        if(self.okChangeBlock)
        {
            self.shopdetailModel.shop_num =model.shopNumber>0?[NSString stringWithFormat:@"%d",(int)model.shopNumber]:@"1";
            self.shopdetailModel.stock_type_id = [NSString stringWithFormat:@"%d",(int)model.sID];
            self.shopdetailModel.pic = model.pic;
            [self getcolorAndsize:model];
            self.okChangeBlock(self.shopdetailModel);
        }
    };
    
    if(self.tag == 989898)
    {
        model.isFight = YES;
    }
    [cell receiveDataModel:model MiniShare:self.miniShareSuccess];
    return cell;

}

- (void)getcolorAndsize:(DPShopModel*)model
{
    NSString *color; NSString *size;
    NSMutableString *color_size = [NSMutableString stringWithString:model.color_size];
    NSArray *colorsizearr = [color_size componentsSeparatedByString:@":"];
    if(colorsizearr.count == 2)
    {
        for(NSDictionary *colordic in model.colors)
        {
            if([colordic[@"id"] isEqualToString:colorsizearr[0]])
            {
                color = colordic[@"name"];
                break;
            }
        }
        
        for(NSDictionary *sizedic in model.sizes)
        {
            if([sizedic[@"id"] isEqualToString:colorsizearr[1]])
            {
                size = sizedic[@"name"];
                break;
            }
        }
    }
    self.shopdetailModel.shop_color = color;
    self.shopdetailModel.shop_size  = size;
}
/// 数据处理
- (void)dataProcessingModel:(AddShopModel *)model {
    _stocktype = [model.stocktype copy];//库存
    NSArray *shopAttr = [self.shopdetailModel.shop_code componentsSeparatedByString:@","];//商品编号
    
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
        }else{
            colorOrSize = [colorOrSize subarrayWithRange:NSMakeRange(0, 1)];
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
        
    } else {
    
        [self.mainTableView reloadData];
    }
}

/// 从数组中取出id对应的名称
- (NSArray *)namesByIds:(NSArray *)ids shopCode:(NSString *)shopCode{
    NSMutableArray* array = [NSMutableArray array];
    for (NSString *sID in ids) {
        if ([self isNameWithShopCode:shopCode name:sID]) {
            for (NSDictionary *dic in self.dataDictionaryArray) {
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
/// 是否存在当前属性的商品
- (BOOL)isNameWithShopCode:(NSString *)shopCode name:(NSString *)name{
    for (DPShopModel *model in _stocktype) {
        if ([shopCode isEqualToString:model.shop_code] && ([model.color_size rangeOfString:name].location != NSNotFound)) {
            return YES;
        }
    }
    return NO;
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
            CGFloat newprice = sModel.price.floatValue - [DataManager sharedManager].one_not_use_price;
            NSString *price = [NSString stringWithFormat:@"%.1f",self.isActive?sModel.price.floatValue:newprice>0?newprice:0.01];
            
            model.price = self.shopdetailModel.app_shop_group_price.floatValue>0?self.shopdetailModel.app_shop_group_price:price;
            model.price = self.isfreeLingClick ? @"-9999":model.price;
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

- (void)tapclick
{
    [self hidePopview];
}

- (void)dismissSemiModalView
{
    [self hidePopview];
}
- (void)hidePopview
{
    [UIView animateWithDuration:0.5 animations:^{
        
        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        
        _BackView.frame = CGRectMake(0, kScreenHeight, PopViewWidth, PopViewHeigh);
    } completion:^(BOOL finish) {
        [self removeFromSuperview];
    }];

}

- (UITableView *)mainTableView {
    if (nil == _mainTableView) {

        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, PopViewWidth, PopViewHeigh) style:UITableViewStylePlain];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.tableFooterView = [UIView new];
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}
- (NSMutableArray*)dataDictionaryArray
{
    if(_dataDictionaryArray == nil)
    {
        _dataDictionaryArray = [NSMutableArray array];
    }
    
    return _dataDictionaryArray;
}
@end
