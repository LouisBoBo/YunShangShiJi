//
//  ChangeSpecialShopPopview.m
//  YunShangShiJi
//
//  Created by hebo on 2018/8/30.
//  Copyright © 2018年 ios-1. All rights reserved.
//

#import "ChangeSpecialShopPopview.h"
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
@implementation ChangeSpecialShopPopview
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
        self.shop_pic = model.def_pic;
        
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
        
//        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
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
                [self SpecialdataProcessingModel:model];
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
    cell.colorSizeOtherBlock = ^(NSInteger cidx, NSInteger sidx, NSInteger oidx) {
        [weakSelf SpecialisStockWithModel:model cidx:cidx sidx:sidx oidx:oidx isNoStock:YES];
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
    
    [cell receiveSpecialDataModel:model MiniShare:self.miniShareSuccess];
    return cell;
}

- (void)getcolorAndsize:(DPShopModel*)model
{
    NSString *color; NSString *size;NSString *other;
    NSMutableString *color_size = [NSMutableString stringWithString:model.color_size];
    NSArray *colorsizearr = [color_size componentsSeparatedByString:@":"];
    
    if(colorsizearr.count == 3)
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
        
        for(NSDictionary *otherdic in model.others)
        {
            if([otherdic[@"id"] isEqualToString:colorsizearr[2]])
            {
                other = otherdic[@"name"];
                break;
            }
        }
    }
    else if(colorsizearr.count == 2)
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
    }else if (colorsizearr.count == 1)
    {
        for(NSDictionary *colordic in model.colors)
        {
            if([colordic[@"id"] isEqualToString:colorsizearr[0]])
            {
                color = colordic[@"name"];
                break;
            }
        }
    }
    self.shopdetailModel.shop_color = color;
    self.shopdetailModel.shop_size  = size;
    self.shopdetailModel.shop_other = other;
}

- (void)SpecialdataProcessingModel:(AddShopModel *)model {
    _stocktype = [model.stocktype copy];//库存
    NSArray *shopAttr = [self.shopdetailModel.shop_code componentsSeparatedByString:@","];//商品编号
    
    NSMutableArray *array = [NSMutableArray array];//处理后数据
    for (int i = 0; i < shopAttr.count; i++) {
        NSString *key = shopAttr[i];
        NSArray *others = nil;
        
        //颜色尺寸
        NSString *colorSize = [model.shop_attr objectForKey:key];
        if ([[NSNull null] isEqual:colorSize])
            continue;
        //取前两个（颜色，尺码）
        NSArray *colorOrSize = [colorSize isKindOfClass:[NSNull class]]?nil:[colorSize componentsSeparatedByString:@"_"];
        
        NSMutableArray *othersArray = [NSMutableArray array];
        
        for (NSString *str in colorOrSize) {

            NSRange rangeO = [str rangeOfString:@"0,"];//其它
            
            //其它
            if (rangeO.location != NSNotFound) {
                NSUInteger location = rangeO.location + rangeO.length;
                NSString *colorStr = [str substringWithRange:NSMakeRange(location, str.length - location)];
                others = [[colorStr componentsSeparatedByString:@","] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
                    return obj1.intValue > obj2.intValue;
                }];
            }
            
            [othersArray addObject:others];
        }
        
        DPShopModel *dsModel = [[DPShopModel alloc] init];
        dsModel.shop_code = key;
        if(othersArray.count == 1)
        {
            dsModel.colorTitle = [self titleNamesByIds:othersArray[0][0] shopCode:key];
            dsModel.colors = [self namesByIds:othersArray[0] shopCode:key];
        }else if (othersArray.count == 2)
        {
            dsModel.colorTitle = [self titleNamesByIds:othersArray[0][0] shopCode:key];
            dsModel.sizeTitle = [self titleNamesByIds:othersArray[1][0] shopCode:key];
            dsModel.colors = [self namesByIds:othersArray[0] shopCode:key];
            dsModel.sizes = [self namesByIds:othersArray[1] shopCode:key];
        }else if (othersArray.count == 3)
        {
            dsModel.colorTitle = [self titleNamesByIds:othersArray[0][0] shopCode:key];
            dsModel.sizeTitle = [self titleNamesByIds:othersArray[1][0] shopCode:key];
            dsModel.otherTitle = [self titleNamesByIds:othersArray[2][0] shopCode:key];
            dsModel.colors = [self namesByIds:othersArray[0] shopCode:key];
            dsModel.sizes = [self namesByIds:othersArray[1] shopCode:key];
            dsModel.others = [self namesByIds:othersArray[2] shopCode:key];
        }
        
        NSInteger sidx = 0;
        NSInteger cidx = 0;
        NSInteger oidx = 0;
        BOOL isCode = NO;
        if(colorOrSize.count >2)
        {
            for (int j = 0; j < dsModel.colors.count; j++) {
                for (int k = 0; k < dsModel.sizes.count; k++) {
                    for(int l =0; l < dsModel.others.count; l++){
                        BOOL isStock = [self SpecialisStockWithModel:dsModel cidx:j sidx:k oidx:l isNoStock:NO];
                        NSDictionary *dicC = dsModel.colors[j];
                        NSMutableArray *cAry = [dicC objectForKey:@"isSelect"];
                        if (isStock) {
                            [cAry addObject:@(k)];
                            sidx = isCode?sidx:k;
                            cidx = isCode?cidx:j;
                            oidx = isCode?oidx:l;
                            isCode = YES;
                        }
                    }
                }
            }
        }
        else if(colorOrSize.count > 1)
        {
            for (int j = 0; j < dsModel.colors.count; j++) {
                for (int k = 0; k < dsModel.sizes.count; k++) {
                    BOOL isStock = [self SpecialisStockWithModel:dsModel cidx:j sidx:k oidx:0 isNoStock:NO];
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
        }else{
            for (int j = 0; j < dsModel.colors.count; j++) {
                
                BOOL isStock = [self SpecialisStockWithModel:dsModel cidx:0 sidx:0 oidx:0 isNoStock:NO];
                NSDictionary *dicC = dsModel.colors[j];
                NSMutableArray *cAry = [dicC objectForKey:@"isSelect"];
                if (isStock) {
                    [cAry addObject:@(0)];
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

                        [self SpecialisStockWithModel:dsModel cidx:model.colorIndex sidx:model.sizeIndex oidx:model.otherIndex isNoStock:NO];
                    }
                }
            } else {
                [self SpecialisStockWithModel:dsModel cidx:cidx sidx:sidx oidx:oidx isNoStock:NO];
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
/// 从数组中取出id对应的名称
- (NSString *)titleNamesByIds:(NSString*)sID shopCode:(NSString *)shopCode{
    NSString *title = @"";
    
    for (NSDictionary *dic in self.dataDictionaryArray) {
        if ([sID isEqualToString:[dic objectForKey:@"id"]]) {
            NSString *name = [dic objectForKey:@"attr_name"];
            NSMutableDictionary *dicC = [NSMutableDictionary dictionary];
            [dicC setObject:sID forKey:@"id"];
            [dicC setObject:name forKey:@"name"];
            [dicC setObject:[NSMutableArray array] forKey:@"isSelect"];
            title = name;
        }
    }
    
    return title;
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
- (BOOL)SpecialisStockWithModel:(DPShopModel *)model cidx:(NSInteger)cidx sidx:(NSInteger)sidx oidx:(NSUInteger)oidx isNoStock:(BOOL)isNoStock{
    NSDictionary *dicC = model.colors.count > cidx?model.colors[cidx]:nil;
    NSDictionary *dicS = model.sizes.count > sidx?model.sizes[sidx]:nil;
    NSDictionary *dicO = model.others.count > oidx?model.others[oidx]:nil;

    NSString *color = [dicC objectForKey:@"id"];
    NSString *size = [dicS objectForKey:@"id"];
    NSString *other = [dicO objectForKey:@"id"];
    
    NSString *colorSize = [NSString stringWithFormat:@"%@",color];
    if(size)
    {
        colorSize = [NSString stringWithFormat:@"%@:%@",color,size];
    }
    if(other)
    {
        colorSize = [NSString stringWithFormat:@"%@:%@:%@",color,size,other];
    }
    
    for (DPShopModel *sModel in _stocktype) {
        
        if ([sModel.shop_code isEqualToString:model.shop_code]&&[sModel.color_size isEqualToString:colorSize]&&((sModel.stock > 0)||isNoStock)) {
            model.sID = sModel.sID;
            model.pic = sModel.pic != nil?sModel.pic:self.shop_pic;
            model.shop_name = sModel.shop_name;
            
            CGFloat discountMoney = sModel.price.floatValue - [DataManager sharedManager].one_not_use_price;
            NSString *price = [NSString stringWithFormat:@"%.1f",self.isActive?sModel.price.floatValue:(discountMoney>0?discountMoney:0)];
            
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
            model.otherIndex = oidx;
            model.shopNumber = model.shopNumber > model.stock?model.stock:model.shopNumber?:1;
            return YES;
        }
    }
    model.colorIndex = cidx;
    model.sizeIndex = sidx;
    model.otherIndex = oidx;
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
        
//        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        
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
