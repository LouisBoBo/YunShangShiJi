//
//  CFPopView.m
//  YunShangShiJi
//
//  Created by yssj on 2016/12/15.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "CFPopView.h"
#import "GlobalTool.h"

#define kYellowColor RGBA(255, 207, 0, 1)
#define kRedColor RGBA(255, 0, 76, 1)

@interface CFPopView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UIView *popView;

@end

@implementation CFPopView
- (instancetype)initWithFrame:(CGRect)frame textStrs:(NSString *)textStrs {
    self=[super initWithFrame:frame];
    if (self) {
        UIButton *btn=[[UIButton alloc]initWithFrame:self.bounds];
        [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [self setInviteFriendsWithReward:textStrs];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame newFriend:(NSString *)newfriend oldFriend:(NSString *)oldfriend reward:(NSString *)reward {
    self=[super initWithFrame:frame];
    if (self) {
        UIButton *btn=[[UIButton alloc]initWithFrame:self.bounds];
        [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        
        [self creatDayViewWithNewFriend:newfriend?newfriend:@"0" oldFriend:oldfriend?oldfriend:@"0" reward:reward?reward:@"0.00"];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame textStr:(NSString *)textStr  popType:(CFPopType)popType {
    self=[super initWithFrame:frame];
    if (self) {
        UIButton *btn=[[UIButton alloc]initWithFrame:self.bounds];
        [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _textStr=textStr;
        _popType=popType;
        
        [self createNoBtnPopView];
    }
    return self;
}
- (void)setInviteFriendsWithReward:(NSString *)strs {
    NSArray *arr = [strs componentsSeparatedByString:@"-"];
    //弹框内容
    _popView = [[UIButton alloc]initWithFrame:CGRectMake(ZOOM(120), ZOOM(460)-(IMGSIZEW(@"icon-guanbi")/2), kScreenWidth-ZOOM(120)*2, ZOOM6(100)+ZOOM6(380))];
    _popView.center=self.center;
    _popView.backgroundColor = kRedColor;
    _popView.clipsToBounds = YES;
    _popView.layer.cornerRadius = 5;
    _popView.alpha = 0.5;
    [self addSubview:_popView];
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(20), CGRectGetWidth(_popView.frame), ZOOM6(80))];
    titlelabel.textColor = kYellowColor;
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.text = @"今日共有";
    [_popView addSubview:titlelabel];
    
    //关闭按钮
    CGFloat btnwidth = ZOOM6(80);
    
    UIButton *canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    canclebtn.frame=CGRectMake(CGRectGetWidth(_popView.frame)-btnwidth, (CGRectGetHeight(titlelabel.frame)-btnwidth)/2, btnwidth, btnwidth);
    canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    canclebtn.layer.cornerRadius=btnwidth/2;
    [canclebtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [_popView addSubview:canclebtn];
    
    NSString *cancleImgStr=@"icon-guanbi";
    CGFloat cancleimagewidth = IMAGEW(cancleImgStr);
    UIImageView *cancleimage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_popView.frame)-cancleimagewidth-ZOOM6(30), (CGRectGetHeight(titlelabel.frame)-cancleimagewidth)/2, cancleimagewidth, cancleimagewidth)];
    cancleimage.image = [UIImage imageNamed:cancleImgStr];
    [_popView addSubview:cancleimage];
    
    
    cancleimage.image = [UIImage imageNamed:@"luck-icon_close-"];
    
    UILabel *firstLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(titlelabel.frame), CGRectGetWidth(titlelabel.frame), ZOOM6(50))];
    firstLabel.textAlignment=NSTextAlignmentCenter;
    firstLabel.font=kFont6px(30);
    firstLabel.textColor=[UIColor whiteColor];
//    [firstLabel setAttributedText: [NSString getOneColorInLabel:[NSString stringWithFormat:@"%@位新朋友为我点赞",newfriend] ColorString:newfriend Color:kYellowColor fontSize:ZOOM6(48)]];
    NSString *str1 = [NSString stringWithFormat:@"%@位好友赢得%@元余额",arr[0],arr[1]];
    [firstLabel setAttributedText:[NSString getOneColorInLabel:str1 strs:@[arr[0],[NSString stringWithFormat:@"%@元",arr[1]]] Color:kYellowColor fontSize:ZOOM6(48)]];
    [_popView addSubview:firstLabel];
    
    UILabel *secondLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(firstLabel.frame), CGRectGetWidth(titlelabel.frame), ZOOM6(50))];
    secondLabel.textAlignment=NSTextAlignmentCenter;
    secondLabel.font=kFont6px(30);
    secondLabel.textColor=[UIColor whiteColor];
//    [secondLabel setAttributedText: [NSString getOneColorInLabel:[NSString stringWithFormat:@"%@位老朋友为我点赞",oldfriend] ColorString:oldfriend Color:kYellowColor fontSize:ZOOM6(48)]];
    NSString *str2 = [NSString stringWithFormat:@"%@位好友赢得%@元提现",arr[2],arr[3]];
    [secondLabel setAttributedText:[NSString getOneColorInLabel:str2 strs:@[arr[2],[NSString stringWithFormat:@"%@元",arr[3]]] Color:kYellowColor fontSize:ZOOM6(48)]];
    [_popView addSubview:secondLabel];
    
    UILabel *thirdLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(secondLabel.frame)+ZOOM6(60), CGRectGetWidth(titlelabel.frame), ZOOM6(50))];
    thirdLabel.textAlignment=NSTextAlignmentCenter;
    thirdLabel.font=kFont6px(36);
    thirdLabel.text=@"我拿到好友奖励";
    thirdLabel.textColor=kYellowColor;
    [_popView addSubview:thirdLabel];
    
    UILabel *fourLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(thirdLabel.frame)+ZOOM6(10), CGRectGetWidth(titlelabel.frame)/2, ZOOM6(60))];
    fourLabel.textAlignment=NSTextAlignmentCenter;
    fourLabel.font=kFont6px(36);
//    [fourLabel setAttributedText: [NSString getOneColorInLabel:[NSString stringWithFormat:@"%@元",reward] ColorString:reward Color:kYellowColor fontSize:ZOOM6(60)]];
    [fourLabel setAttributedText: [NSString getOneColorInLabel:[NSString stringWithFormat:@"%@元",arr[4]] ColorString:arr[4] Color:kYellowColor fontSize:ZOOM6(60)]];
    fourLabel.textColor=kYellowColor;
    [_popView addSubview:fourLabel];
    
    UILabel *fiveLabel=[[UILabel alloc]initWithFrame:CGRectMake(fourLabel.x,CGRectGetMaxY(fourLabel.frame)+ZOOM6(10), fourLabel.width, ZOOM6(50))];
    fiveLabel.textAlignment=NSTextAlignmentCenter;
    fiveLabel.font=kFont6px(36);
    fiveLabel.text=@"余额";
    fiveLabel.textColor=kYellowColor;
    [_popView addSubview:fiveLabel];
    
    UILabel *sixLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(titlelabel.frame)/2,CGRectGetMaxY(thirdLabel.frame)+ZOOM6(10), CGRectGetWidth(titlelabel.frame)/2, ZOOM6(60))];
    sixLabel.textAlignment=NSTextAlignmentCenter;
    sixLabel.font=kFont6px(36);
    [sixLabel setAttributedText: [NSString getOneColorInLabel:[NSString stringWithFormat:@"%@元",arr[5]] ColorString:arr[5] Color:kYellowColor fontSize:ZOOM6(60)]];
    sixLabel.textColor=kYellowColor;
    [_popView addSubview:sixLabel];
    
    UILabel *sevenLabel=[[UILabel alloc]initWithFrame:CGRectMake(sixLabel.x,CGRectGetMaxY(fourLabel.frame)+ZOOM6(10), sixLabel.width, ZOOM6(50))];
    sevenLabel.textAlignment=NSTextAlignmentCenter;
    sevenLabel.font=kFont6px(36);
    sevenLabel.text=@"提现";
    sevenLabel.textColor=kYellowColor;
    [_popView addSubview:sevenLabel];
    
    
}
- (void)creatDayViewWithNewFriend:(NSString *)newfriend oldFriend:(NSString *)oldfriend reward:(NSString *)reward  {
    //弹框内容
    _popView = [[UIButton alloc]initWithFrame:CGRectMake(ZOOM(120), ZOOM(460)-(IMGSIZEW(@"icon-guanbi")/2), kScreenWidth-ZOOM(120)*2, ZOOM6(100)+ZOOM6(380))];
    _popView.center=self.center;
    _popView.backgroundColor = kRedColor;
    _popView.clipsToBounds = YES;
    _popView.layer.cornerRadius = 5;
    _popView.alpha = 0.5;
    [self addSubview:_popView];
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(20), CGRectGetWidth(_popView.frame), ZOOM6(80))];
    titlelabel.textColor = kYellowColor;
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.text = @"今日共有";
    [_popView addSubview:titlelabel];
    
    //关闭按钮
    CGFloat btnwidth = ZOOM6(80);
    
    UIButton *canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    canclebtn.frame=CGRectMake(CGRectGetWidth(_popView.frame)-btnwidth, (CGRectGetHeight(titlelabel.frame)-btnwidth)/2, btnwidth, btnwidth);
    canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    canclebtn.layer.cornerRadius=btnwidth/2;
    [canclebtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [_popView addSubview:canclebtn];
    
    NSString *cancleImgStr=@"icon-guanbi";
    CGFloat cancleimagewidth = IMAGEW(cancleImgStr);
    UIImageView *cancleimage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_popView.frame)-cancleimagewidth-ZOOM6(30), (CGRectGetHeight(titlelabel.frame)-cancleimagewidth)/2, cancleimagewidth, cancleimagewidth)];
    cancleimage.image = [UIImage imageNamed:cancleImgStr];
    [_popView addSubview:cancleimage];
    
  
        cancleimage.image = [UIImage imageNamed:@"luck-icon_close-"];
    
    UILabel *firstLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(titlelabel.frame), CGRectGetWidth(titlelabel.frame), ZOOM6(50))];
    firstLabel.textAlignment=NSTextAlignmentCenter;
    firstLabel.font=kFont6px(30);
    firstLabel.textColor=[UIColor whiteColor];
    [firstLabel setAttributedText: [NSString getOneColorInLabel:[NSString stringWithFormat:@"%@位新朋友为我点赞",newfriend] ColorString:newfriend Color:kYellowColor fontSize:ZOOM6(48)]];
    [_popView addSubview:firstLabel];
    
    UILabel *secondLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(firstLabel.frame), CGRectGetWidth(titlelabel.frame), ZOOM6(50))];
    secondLabel.textAlignment=NSTextAlignmentCenter;
    secondLabel.font=kFont6px(30);
    secondLabel.textColor=[UIColor whiteColor];
    [secondLabel setAttributedText: [NSString getOneColorInLabel:[NSString stringWithFormat:@"%@位老朋友为我点赞",oldfriend] ColorString:oldfriend Color:kYellowColor fontSize:ZOOM6(48)]];
    [_popView addSubview:secondLabel];
    
    UILabel *thirdLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(secondLabel.frame)+ZOOM6(60), CGRectGetWidth(titlelabel.frame), ZOOM6(50))];
    thirdLabel.textAlignment=NSTextAlignmentCenter;
    thirdLabel.font=kFont6px(36);
    thirdLabel.text=@"今日获得奖励";
    thirdLabel.textColor=kYellowColor;
    [_popView addSubview:thirdLabel];
    
    UILabel *fourLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(thirdLabel.frame)+ZOOM6(10), CGRectGetWidth(titlelabel.frame), ZOOM6(60))];
    fourLabel.textAlignment=NSTextAlignmentCenter;
    fourLabel.font=kFont6px(36);
    [fourLabel setAttributedText: [NSString getOneColorInLabel:[NSString stringWithFormat:@"%@元",reward] ColorString:reward Color:kYellowColor fontSize:ZOOM6(60)]];
    fourLabel.textColor=kYellowColor;
    [_popView addSubview:fourLabel];
    
    UILabel *fiveLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(fourLabel.frame)+ZOOM6(10), CGRectGetWidth(titlelabel.frame), ZOOM6(50))];
    fiveLabel.textAlignment=NSTextAlignmentCenter;
    fiveLabel.font=kFont6px(36);
    fiveLabel.text=@"提现额度";
    fiveLabel.textColor=kYellowColor;
    [_popView addSubview:fiveLabel];
}
- (void)createNoBtnPopView {
    //弹框内容
    _popView = [[UIButton alloc]initWithFrame:CGRectMake(ZOOM(120), ZOOM(460)-(IMGSIZEW(@"icon-guanbi")/2), kScreenWidth-ZOOM(120)*2, kScreenHeight-ZOOM(460)*2+IMGSIZEW(@"icon-guanbi")+ZOOM6(50))];
    _popView.backgroundColor = _popType==CFPopTypeWhite?[UIColor whiteColor]:kRedColor;
    _popView.clipsToBounds = YES;
    _popView.layer.cornerRadius = 5;
    _popView.alpha = 0.5;
    [self addSubview:_popView];
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(20), CGRectGetWidth(_popView.frame), ZOOM6(80))];
    titlelabel.textColor = _popType==CFPopTypeWhite ? kMainTitleColor : kYellowColor;
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.text = _textStr?_textStr:@"text";
    [_popView addSubview:titlelabel];
    
    //关闭按钮
    CGFloat btnwidth = ZOOM6(80);
    
    UIButton *canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    canclebtn.frame=CGRectMake(CGRectGetWidth(_popView.frame)-btnwidth, (CGRectGetHeight(titlelabel.frame)-btnwidth)/2, btnwidth, btnwidth);
    canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    canclebtn.layer.cornerRadius=btnwidth/2;
    [canclebtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [_popView addSubview:canclebtn];
    
    NSString *cancleImgStr=_popType==CFPopTypeWhite?@"icon_close":@"icon-guanbi";
    CGFloat cancleimagewidth = IMAGEW(cancleImgStr);
    UIImageView *cancleimage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_popView.frame)-cancleimagewidth-ZOOM6(30), (CGRectGetHeight(titlelabel.frame)-cancleimagewidth)/2, cancleimagewidth, cancleimagewidth)];
    cancleimage.image = [UIImage imageNamed:cancleImgStr];
    [_popView addSubview:cancleimage];
    
    if(_popType == CFPopTypeRed)
    {
        cancleimage.image = [UIImage imageNamed:@"luck-icon_close-"];
    }
    

    
    _MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titlelabel.frame), CGRectGetWidth(titlelabel.frame), CGRectGetHeight(_popView.frame)-CGRectGetHeight(titlelabel.frame)-ZOOM6(50)-ZOOM6(20)) style:UITableViewStylePlain];
    _MytableView.backgroundColor=_popType==CFPopTypeWhite?[UIColor whiteColor]:kRedColor;
    _MytableView.delegate = self;
    _MytableView.dataSource = self;
    _MytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _MytableView.showsVerticalScrollIndicator = YES;
    [_popView addSubview:_MytableView];
}
- (instancetype)initWithFrame:(CGRect)frame textStr:(NSString *)textStr leftBtnStr:(NSString *)leftBtnStr rightBtnStr:(NSString *)rightBtnStr popType:(CFPopType)popType {
    self=[super initWithFrame:frame];
    if (self) {
        UIButton *btn=[[UIButton alloc]initWithFrame:self.bounds];
        [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _textStr=textStr;
        _leftBtnStr=leftBtnStr;
        _rightBtnStr=rightBtnStr;
        _popType=popType;
        
        self.discriptionData=
        [textStr isEqualToString:@"如何获得衣豆?"]
        ?@[@"1.衣豆可以通过平台购买下单获得平台消费1元(不足1元将按1元计算)可获得1个衣豆；",
          @"2.用户下单成功后，相应衣豆将会冻结在衣豆账户中，订单签收7天后(订单完结)，订单产生的衣豆将会解冻；如果发生退款退货，冻结衣豆将会被扣除；",
          @"3.参与送衣豆任务，也可获得相应衣豆奖励。"]
        :@[@"1、完成每天的赚钱小任务可赢得账户余额。",
           @"2、账户余额用来抽取1分-50元不等的提现现金。每次消耗10元余额。",
           @"3、完成赚钱小任务里的惊喜提现任务可直接赢得提现现金。",
           @"4、单独购买美衣每消耗1元获得一个衣豆，衣豆用来抽取1分-50元不等的提现现金，交易成功后方可提现。"];
        
//        @[@"1、衣蝠余额分为账户余额与可提现额度。可提现额度指可以提取现金的金额。",
//          @"2、账户余额能用来抵扣购衣款，抽提现额度，并且余额不足就不能提现呢。",
//          @"3、可提现额度可通过完成惊喜提现任务，用账户余额或衣豆抽1-1000元不等的提现额度，两种方式获得。",
//          @"4、每次抽提现额度需要消耗10元余额或10个衣豆。",
//          @"5、可通过完成每日赚钱任务，参加0元购美衣获得账户余额。购买美衣每消费1元获得1个衣豆。",
//          @"6、下单成功后，返还的余额及衣豆会冻结。订单交易成功后将会解冻。可用冻结的衣豆抽奖，抽中的提现额度在订单完结前被冻结。如发生退货退款，该提现额度将会扣除。",
//          @"7、衣蝠“疯狂新衣节”活动中，购买美衣获得的抽奖机会及中奖率翻倍哦。(苹果不是赞助商)"]

        [self creatPopView];
    }
    return self;
}

- (NSArray *)discriptionData
{
    if (_discriptionData == nil) {
        _discriptionData = [[NSArray alloc] init];
//         _discriptionData = @[@"什么是优惠券和抵用券？_优惠券和抵用券都是衣蝠发行和认可的购物券，可以在衣蝠消费付款时用来抵扣相应商品的价格（特价商品除外）。优惠券和抵用券可以叠加使用。",@"如何获取优惠券和抵用券？_优惠券可以通过参与相关活动获取，抵用券系统会每天发放给用户。",@"如何使用优惠券和抵用券？_用户选好商品，进入付款页面，系统会自动使用满足条件的抵用券和优惠券，为用户计算好最大额度的优惠。"];
    }
    return _discriptionData;
}

-(void)creatPopView
{
    //弹框内容
    if([_textStr isEqualToString:@"提现额度说明"]){
        _popView = [[UIButton alloc]initWithFrame:CGRectMake(ZOOM6(100), ZOOM6(490)-(IMGSIZEW(@"icon-guanbi")/2), kScreenWidth-ZOOM6(100)*2, kScreenHeight-ZOOM6(490)*2+IMGSIZEW(@"icon-guanbi")+ZOOM6(50))];
    }else{
        _popView = [[UIButton alloc]initWithFrame:CGRectMake(ZOOM6(100), ZOOM6(460)-(IMGSIZEW(@"icon-guanbi")/2), kScreenWidth-ZOOM6(100)*2, kScreenHeight-ZOOM6(460)*2+IMGSIZEW(@"icon-guanbi")+ZOOM6(50))];
    }
    
    _popView.backgroundColor = _popType==CFPopTypeWhite?[UIColor whiteColor]:kRedColor;
    _popView.clipsToBounds = YES;
    _popView.layer.cornerRadius = 5;
    _popView.alpha = 0.5;
    [self addSubview:_popView];
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(20), CGRectGetWidth(_popView.frame), ZOOM6(80))];
    titlelabel.textColor = _popType==CFPopTypeWhite ? kMainTitleColor : kYellowColor;
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.text = _textStr?_textStr:@"text";
    [_popView addSubview:titlelabel];
    
    //关闭按钮
    CGFloat btnwidth = ZOOM6(80);
    
    UIButton *canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    canclebtn.frame=CGRectMake(CGRectGetWidth(_popView.frame)-btnwidth, (CGRectGetHeight(titlelabel.frame)-btnwidth)/2, btnwidth, btnwidth);
    canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    canclebtn.layer.cornerRadius=btnwidth/2;
    [canclebtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [_popView addSubview:canclebtn];
    
    NSString *cancleImgStr=_popType==CFPopTypeWhite?@"icon_close":@"icon-guanbi";
    CGFloat cancleimagewidth = IMAGEW(cancleImgStr);
    UIImageView *cancleimage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_popView.frame)-cancleimagewidth-ZOOM6(30), (CGRectGetHeight(titlelabel.frame)-cancleimagewidth)/2, cancleimagewidth, cancleimagewidth)];
    cancleimage.image = [UIImage imageNamed:cancleImgStr];
    [_popView addSubview:cancleimage];
    
    if(_popType == CFPopTypeRed)
    {
        cancleimage.image = [UIImage imageNamed:@"luck-icon_close-"];
    }
    
    UIColor *normalImgColor = _popType==CFPopTypeWhite ? [UIColor whiteColor] :[UIColor whiteColor];
    UIColor *selectedImgColor = _popType==CFPopTypeWhite ? tarbarrossred :kYellowColor;
    UIColor *titleColor= _popType==CFPopTypeWhite ? [UIColor whiteColor] :kRedColor;
    
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(ZOOM6(40), CGRectGetHeight(_popView.frame)-ZOOM6(40)-ZOOM6(80), (CGRectGetWidth(_popView.frame)-ZOOM6(120))/2, ZOOM6(80));
    [leftBtn setTitle:_leftBtnStr ?_leftBtnStr : @"leftBtn" forState:UIControlStateNormal];
    [leftBtn setTitleColor:_popType==CFPopTypeWhite ? tarbarrossred :kRedColor forState:UIControlStateNormal];
    [leftBtn setTitleColor:titleColor forState:UIControlStateSelected];
    [leftBtn setTitleColor:titleColor forState:UIControlStateHighlighted];
    [leftBtn setBackgroundImage:[UIImage imageWithColor:normalImgColor] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageWithColor:selectedImgColor] forState:UIControlStateHighlighted];
    leftBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM6(32)];
    leftBtn.layer.masksToBounds = YES;
    leftBtn.layer.cornerRadius=5;
    leftBtn.layer.borderColor=tarbarrossred.CGColor;
    leftBtn.layer.borderWidth=1;
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_popView addSubview:leftBtn];
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(CGRectGetWidth(_popView.frame)/2+ZOOM6(20), leftBtn.frame.origin.y, (CGRectGetWidth(_popView.frame)-ZOOM6(120))/2, CGRectGetHeight(leftBtn.frame));
    [rightBtn setTitle:_rightBtnStr ?_rightBtnStr : @"rightBtn" forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageWithColor:selectedImgColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:selectedImgColor forState:UIControlStateSelected];
    [rightBtn setTitleColor:titleColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM6(32)];
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.cornerRadius=5;
    rightBtn.layer.borderColor=selectedImgColor.CGColor;
    rightBtn.layer.borderWidth=1;
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_popView addSubview:rightBtn];
    
    _MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titlelabel.frame), CGRectGetWidth(titlelabel.frame), CGRectGetHeight(_popView.frame)-CGRectGetHeight(titlelabel.frame)-ZOOM6(140)-ZOOM6(50)) style:UITableViewStylePlain];
    _MytableView.backgroundColor=_popType==CFPopTypeWhite?[UIColor whiteColor]:kRedColor;
    _MytableView.delegate = self;
    _MytableView.dataSource = self;
    _MytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _MytableView.showsVerticalScrollIndicator = YES;
    [_popView addSubview:_MytableView];
    
}

#pragma mark UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat Heigh = [self getRowHeight:_discriptionData[indexPath.row] fontSize:ZOOM6(34)];
    return Heigh+8;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.discriptionData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.backgroundColor=[UIColor clearColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSMutableString *str = _discriptionData[indexPath.row];
//    NSArray *arr = [str componentsSeparatedByString:@"_"];
    
//    UIFont *titlefont = [UIFont systemFontOfSize:ZOOM6(32)];
//    NSString *titlestr = [NSString stringWithFormat:@"%@",arr[0]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",str];
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.textColor=_popType==CFPopTypeWhite ? kTextColor : [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
    
    //lable的行间距
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:cell.detailTextLabel.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:4];
    
    
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [cell.detailTextLabel.text length])];
//    [attributedString1 addAttribute:NSForegroundColorAttributeName value: tarbarrossred range:NSMakeRange(0, titlestr.length)];
    
//    [attributedString1 addAttribute:NSFontAttributeName value:titlefont range:NSMakeRange(0, titlestr.length)];
    
    [cell.detailTextLabel setAttributedText:attributedString1];
    [cell.detailTextLabel sizeToFit];
    
    return cell;

}

- (void)setLeftBlock:(dispatch_block_t)letfBlock withRightBlock:(dispatch_block_t)rightBlock {
    self.leftBlock=letfBlock;
    self.rightBlock=rightBlock;
}

- (void)leftBtnClick {
    if (self.leftBlock) {
        self.leftBlock();
    }
    [self dismiss];
}
- (void)rightBtnClick {
    if (self.rightBlock) {
        self.rightBlock();
    }
    [self dismiss];
}
- (void)show {
    if (self.showView) {
        [self.showView addSubview:self];
    }else {
        UIViewController *topVC = [self appRootViewController];
        [topVC.view addSubview:self];
    }
    _popView.transform = CGAffineTransformMakeScale(0.3, 0.3);

    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        _popView.transform = CGAffineTransformMakeScale(1, 1);
        _popView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)close {
    [self dismiss];
}
- (void)dismiss {
    [UIView animateWithDuration:0.5 animations:^{
        
        self.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _popView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        _popView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [self removeFromSuperview];
    }];
}
- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(ceil(CGRectGetWidth(_MytableView.frame)), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    
    return height;
}
@end
