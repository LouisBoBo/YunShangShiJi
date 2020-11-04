//
//  FashionBuyInfoVC.m
//  YunShangShiJi
//
//  Created by yssj on 2016/11/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//1.2 你时尚我买单活动页  

#import "FashionBuyInfoVC.h"
#import "GlobalTool.h"
#import "TaskCollectionVC.h"

#define BackgroundColor RGBA(170, 7, 246, 1)

static NSString *CellNormolName = @"FashionCellNormol";
static NSString *CellInfoName = @"FashionCellInfo";

static NSString *k_Api_Order_freeUse = @"order/freeUse?";

typedef NS_ENUM(NSUInteger, FashionCellType) {
    FashionCellNormol = 0,
    FashionCellInfo = 1,
};

@interface FashionBuyInfoVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_infoArr;
    NSNumber *numCount;              //当前有几次机会
    NSString *order_code;       //订单编号
    NSString *order_price;               //订单价格
    
    UIButton *FootBtn;
}
@property (nonatomic,strong)UITableView *tableView;
@end

@interface MyFashionCell : UITableViewCell
@property (nonatomic,strong)UIView *bottomline;
+ (instancetype)cellWithType:(FashionCellType)type tableView:(UITableView *)tableView;
- (void)receiveData:(NSString*)str;
@end
@interface MyFashionInfoCell : MyFashionCell
@property (nonatomic,strong)UIView *topline;
@property (nonatomic,strong)UIView *leftline;
@property (nonatomic,strong)UIView *rightline;
@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UILabel *labelOne;
@property (nonatomic,strong)UILabel *labelTwo;
@property (nonatomic,strong)UILabel *labelThree;
@property (nonatomic,strong)UILabel *labelFour;
@property (nonatomic,strong)UILabel *labelFive;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end

@implementation FashionBuyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    _infoArr = _fashionType==1 ?
    [NSMutableArray arrayWithObjects:@[
                                       @"1.免单资格是衣蝠为了答谢新老用户赠送的一次超级福利；",
                                       @"2.免单只适用于购买衣蝠平台所有实付金额50元以上或100元以上的商品（扣除积分、抵用券、优惠券、金币、金券后），支付订单包含多件商品时，单件商品价格不低于30元，且系统会根据供应商的不同进行拆单，只有拆单后金额满足条件才可参与免单；",
                                       @"3.下单后平台将分5个月返还50元或者是100元现金，具体返还时间节点如下图："],
     @[@"返还周期,第一次,第二次,第三次,第四次,第五次",@"返还时间,签收后,签收后\n一个月,签收后\n二个月,签收后\n三个月,签收后\n四个月",@"50以上,10元,10元,10元,10元,10元",@"100以上,20元,20元,20元,20元,20元"],
     @[@"4.本次活动名额有限，所以请及时选购心仪美衣下单，以免浪费免单资格；",
       @"5.退货退款处理：用户在使用免单资格后，发生退货退款，默认已使用该免单资格，将不再重新赠送；",
       @"6.本次活动解释权归衣蝠所有。"],nil]
    :
    [NSMutableArray arrayWithObjects:@[
                                       @"1.免单资格是衣蝠为了答谢新老用户赠送的一次超级福利；",
                                       @"2.免单只适用于购买衣蝠平台所有实付金额50元以上的商品（扣除积分、抵用券、优惠券、金币、金券后），支付订单包含多件商品时，单件商品价格不低于30元，且系统会根据供应商的不同进行拆单，只有拆单后金额满足条件才可参与免单；",
                                       @"3.下单后平台将分5个月返还50元现金，具体返还时间节点如下图："],
     @[@"返还周期,第一次,第二次,第三次,第四次,第五次",@"返还时间,签收后,签收后\n一个月,签收后\n二个月,签收后\n三个月,签收后\n四个月",@"50以上,10元,10元,10元,10元,10元"],
     @[@"4.本次活动名额有限，所以请及时选购心仪美衣下单，以免浪费免单资格；",
       @"5.退货退款处理：用户在使用免单资格后，发生退货退款，默认已使用该免单资格，将不再重新赠送；",
       @"6.本次活动解释权归衣蝠所有。"],nil]
    ;


    [self setNavigationItemLeft:@"你时尚我买单"];
    [self setFootView];

    [self.view addSubview:self.tableView];

    [self httpGetData];
    
    
    
}

#pragma mark --懒加载
- (UITableView *)tableView {
    if (nil==_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar-ZOOM(200)) style:UITableViewStylePlain];
        _tableView.backgroundColor=BackgroundColor;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView=[self tableHeader];
        _tableView.tableFooterView=[self tableFooter];
    }
    return _tableView;
}
- (UIView *)tableHeader {
    const CGFloat tableHeaderHeight = ZOOM6(440);
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, tableHeaderHeight)];
    
    UIImageView *headerIMG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, tableHeaderHeight-ZOOM6(140))];
    headerIMG.backgroundColor=[UIColor clearColor];
    [headerIMG setImage:[UIImage imageNamed:@"topBG"]];
    [header addSubview:headerIMG];
    
    UIImageView *changeImg=[[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(640))/2, ZOOM6(100), ZOOM6(640), ZOOM6(200))];
    [headerIMG addSubview:changeImg];
    
    UILabel *changeLable=[[UILabel alloc]init];
    changeLable.frame=CGRectMake(ZOOM6(40), 0, changeImg.width-ZOOM6(80), changeImg.height);
    changeLable.textAlignment=NSTextAlignmentCenter;
    changeLable.textColor=[UIColor redColor];
    changeLable.font=[UIFont boldSystemFontOfSize:ZOOM6(40)];
    changeLable.numberOfLines=2;
    [changeImg addSubview:changeLable];

    if (numCount.integerValue==0) {
        NSString *string=[NSString stringWithFormat:@"订单：%@  %.2f元",order_code,order_price.floatValue];
        changeLable.text=[NSString stringWithFormat:@"资格已使用\n%@",string];
        changeLable.textAlignment=NSTextAlignmentLeft;
        changeLable.textColor=kSubTitleColor;
        [changeLable setAttributedText:[NSString attributedSourceString:changeLable.text targetString:string addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM6(30)]}]];
        [changeImg setImage:[UIImage imageNamed:@"fashionIMG_used"]];
        
    }else{
        changeLable.text=[NSString stringWithFormat:@"剩余%@次资格",numCount];
        [changeImg setImage:[UIImage imageNamed:@"fashionIMG"]];
    }
    UILabel *remind=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(260))/2, CGRectGetMaxY(headerIMG.frame)+ZOOM6(90), ZOOM6(260), ZOOM6(50))];
    remind.text=@"免单资格说明";
    remind.font=[UIFont boldSystemFontOfSize:ZOOM6(40)];
    remind.textColor=[UIColor whiteColor];
    remind.textAlignment=NSTextAlignmentCenter;
    remind.backgroundColor=BackgroundColor;
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(ZOOM6(42), CGRectGetMidY(remind.frame), kScreenWidth-ZOOM6(42)*2, 2)];
    line.backgroundColor=[UIColor whiteColor];
    [header addSubview:line];
    
    [header addSubview:remind];
    
    return header;
}
- (UIView *)tableFooter {
    UIImageView *footer = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(100))];
    [footer setImage:[UIImage imageNamed:@"fashionbottomBG"]];
    return footer;
}
- (void)setFootView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-ZOOM(200), kScreenWidth, ZOOM(200))];
    [self.view addSubview:view];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line.backgroundColor=kNavLineColor;
    [view addSubview:line];
    
    FootBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    FootBtn.frame=CGRectMake(kZoom6pt(15), ZOOM(32), kScreenWidth-kZoom6pt(15)*2, view.frame.size.height-ZOOM(32)*2);
    [FootBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [FootBtn setTitle:@"去免单" forState:UIControlStateNormal];
    [FootBtn setBackgroundImage:[UIImage imageWithColor:tarbarrossred] forState:UIControlStateNormal];
    FootBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOMPT(18)];
    [FootBtn addTarget:self action:@selector(FootBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    FootBtn.layer.cornerRadius = 3;
    FootBtn.layer.masksToBounds = YES;
    [view addSubview:FootBtn];
}
- (void)FootBtnClick:(UIButton *)sender {
    MyLog(@"去免单");
    TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
    vc.typeID = [NSNumber numberWithInt:6];
    vc.typeName = @"热卖";
    vc.title = @"热卖";
    vc.is_jingxi = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)httpGetData {
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:k_Api_Order_freeUse caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        if (response.status==1) {
            numCount=data[@"num"];
            order_code=data[@"order_code"];
            order_price=data[@"op"];
            
            self.tableView.tableHeaderView=[self tableHeader];
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _infoArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_infoArr[section]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FashionCellType type = FashionCellNormol;
    if (indexPath.section==1) {
        type=FashionCellInfo;
    }
    MyFashionCell *cell = [MyFashionCell cellWithType:type tableView:tableView];
    [cell receiveData:_infoArr[indexPath.section][indexPath.row]];
    
    if (indexPath.section==1) {
        cell.bottomline.hidden=!(indexPath.row==[_infoArr[indexPath.section]count]-1);
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return
    indexPath.section==1 ? 40 : [NSString heightWithString:_infoArr[indexPath.section][indexPath.row] font:[UIFont systemFontOfSize:ZOOM6(32)] constrainedToWidth:kScreenWidth]+20;
}


@end

#pragma mark - ************************** MyFashionCell **************************

@implementation MyFashionCell
- (UIView *)bottomline {
    if (_bottomline==nil) {
        CGFloat leftSpace=ZOOM6(42);
        _bottomline=[[UIView alloc]initWithFrame:CGRectMake(leftSpace, self.frame.size.height-0.5, kScreenWidth-leftSpace*2, 0.5)];
        _bottomline.backgroundColor=[UIColor whiteColor];
        _bottomline.hidden=YES;
    }
    return _bottomline;
}
+ (instancetype)cellWithType:(FashionCellType)type tableView:(UITableView *)tableView {
    MyFashionCell *cell = nil;
    
    switch (type) {
        case FashionCellNormol:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CellNormolName];
            if (cell == nil) {
                cell = [[MyFashionCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellNormolName];
            }
        }
            break;
        case FashionCellInfo:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CellInfoName];
            if (cell == nil) {
                cell = [[MyFashionInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellInfoName];
            }
        }
            break;
        default:
            break;
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)receiveData:(NSString *)str {
    

//    self.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@",arr[0],arr[1]];
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.textColor=[UIColor whiteColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
    
    
    //lable的行间距
//    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSMutableAttributedString * attributedString1 = [NSString getOneColorInLabel:str strs:@[@"实付金额50元以上",@"100元以上"] Color:[UIColor yellowColor] fontSize:ZOOM6(28)];

    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:4];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str length])];
    
//    [attributedString1 addAttribute:NSForegroundColorAttributeName value: tarbarrossred range:NSMakeRange(0, titlestr.length)];
//    
//    [attributedString1 addAttribute:NSFontAttributeName value:titlefont range:NSMakeRange(0, titlestr.length)];
//    NSRange stringRange = [allstring rangeOfString:string];
//    NSMutableDictionary *stringDict = [NSMutableDictionary dictionary];
//    [stringDict setObject:color forKey:NSForegroundColorAttributeName];
//    [stringDict setObject:[UIFont systemFontOfSize:size] forKey:NSFontAttributeName];
    
    [self.detailTextLabel setAttributedText:attributedString1];
   
    [self.detailTextLabel sizeToFit];
}
@end

@implementation MyFashionInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}
- (void)receiveData:(NSString *)str {
    NSArray *arr=[str componentsSeparatedByString:@","];
    self.leftLabel.text=arr[0];
    self.labelOne.text=arr[1];
    self.labelTwo.text=arr[2];
    self.labelThree.text=arr[3];
    self.labelFour.text=arr[4];
    self.labelFive.text=arr[5];
}
- (void)setUI {
    [self addSubview:self.topline];
    [self addSubview:self.bottomline];
    [self addSubview:self.leftline];
    [self addSubview:self.rightline];
    [self addSubview:self.leftLabel];
    [self addSubview:self.labelOne];
    [self addSubview:self.labelTwo];
    [self addSubview:self.labelThree];
    [self addSubview:self.labelFour];
    [self addSubview:self.labelFive];
}
- (UIView *)topline {
    if (_topline==nil) {
        CGFloat leftSpace=ZOOM6(42);
        _topline=[[UIView alloc]initWithFrame:CGRectMake(leftSpace, 0, kScreenWidth-leftSpace*2, 0.5)];
        _topline.backgroundColor=[UIColor whiteColor];
    }
    return _topline;
}
- (UIView *)leftline {
    if (_leftline==nil) {
        CGFloat leftSpace=ZOOM6(42);
        _leftline=[[UIView alloc]initWithFrame:CGRectMake(leftSpace, 0, 0.5, self.frame.size.height)];
        _leftline.backgroundColor=[UIColor whiteColor];
    }
    return _leftline;
}
- (UIView *)rightline {
    if (_rightline==nil) {
        CGFloat leftSpace=ZOOM6(42);
        _rightline=[[UIView alloc]initWithFrame:CGRectMake( kScreenWidth-leftSpace, 0, 0.5, self.frame.size.height)];
        _rightline.backgroundColor=[UIColor whiteColor];
    }
    return _rightline;
}
- (UILabel *)leftLabel {
    if (_leftLabel==nil) {
        CGFloat leftSpace=ZOOM6(42);
        _leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(leftSpace, 0, ZOOM6(160), self.frame.size.height)];
        _leftLabel.textAlignment=NSTextAlignmentCenter;
        _leftLabel.font=[UIFont systemFontOfSize:ZOOM6(30)];
        _leftLabel.textColor=[UIColor whiteColor];
    }
    return _leftLabel;
}
- (UILabel *)labelOne {
    if (_labelOne==nil) {
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftLabel.frame), 0, 0.5, self.frame.size.height)];
        line.backgroundColor=[UIColor whiteColor];
        [self addSubview:line];
        _labelOne=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), 0, ZOOM6(100), self.frame.size.height)];
        _labelOne.textAlignment=NSTextAlignmentCenter;
        _labelOne.font=[UIFont systemFontOfSize:ZOOM6(24)];
        _labelOne.textColor=[UIColor whiteColor];
        _labelOne.numberOfLines=2;
    }
    return _labelOne;
}
- (UILabel *)labelTwo {
    if (_labelTwo==nil) {
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelOne.frame), 0, 0.5, self.frame.size.height)];
        line.backgroundColor=[UIColor whiteColor];
        [self addSubview:line];
        _labelTwo=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), 0, ZOOM6(100), self.frame.size.height)];
        _labelTwo.textAlignment=NSTextAlignmentCenter;
        _labelTwo.font=[UIFont systemFontOfSize:ZOOM6(24)];
        _labelTwo.textColor=[UIColor whiteColor];
        _labelTwo.numberOfLines=2;
    }
    return _labelTwo;
}
- (UILabel *)labelThree {
    if (_labelThree==nil) {
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelTwo.frame), 0, 0.5, self.frame.size.height)];
        line.backgroundColor=[UIColor whiteColor];
        [self addSubview:line];
        _labelThree=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), 0, ZOOM6(100), self.frame.size.height)];
        _labelThree.textAlignment=NSTextAlignmentCenter;
        _labelThree.font=[UIFont systemFontOfSize:ZOOM6(24)];
        _labelThree.textColor=[UIColor whiteColor];
        _labelThree.numberOfLines=2;
    }
    return _labelThree;
}
- (UILabel *)labelFour {
    if (_labelFour==nil) {
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelThree.frame), 0, 0.5, self.frame.size.height)];
        line.backgroundColor=[UIColor whiteColor];
        [self addSubview:line];
        _labelFour=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), 0, ZOOM6(100), self.frame.size.height)];
        _labelFour.textAlignment=NSTextAlignmentCenter;
        _labelFour.font=[UIFont systemFontOfSize:ZOOM6(24)];
        _labelFour.textColor=[UIColor whiteColor];
        _labelFour.numberOfLines=2;
    }
    return _labelFour;
}
- (UILabel *)labelFive {
    if (_labelFive==nil) {
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelFour.frame), 0, 0.5, self.frame.size.height)];
        line.backgroundColor=[UIColor whiteColor];
        [self addSubview:line];
        _labelFive=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), 0, ZOOM6(100), self.frame.size.height)];
        _labelFive.textAlignment=NSTextAlignmentCenter;
        _labelFive.font=[UIFont systemFontOfSize:ZOOM6(24)];
        _labelFive.textColor=[UIColor whiteColor];
        _labelFive.numberOfLines=2;
    }
    return _labelFive;
}
@end
