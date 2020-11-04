//
//  AddMemberCardViewController.m
//  YunShangShiJi
//
//  Created by hebo on 2019/2/14.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "AddMemberCardViewController.h"
#import "MKJMainPopoutView.h"
#import "MKJConstant.h"
#import "MKJItemModel.h"
#import "GlobalTool.h"
#import "YFStepperView.h"
#import "MemberViewModel.h"
#import "MemberModel.h"
#import "vipDataModel.h"
#import "uservipDataModel.h"
#import "MemberPayTableViewCell.h"
#import "MemberPayStyleTableViewCell.h"
#import "InvitFriendFreeLingView.h"
#import "TFPayStyleViewController.h"
#import "OneLuckdrawViewController.h"
#import "HBmemberViewController.h"
#import "InviteFriendFreelingViewController.h"
#import "MemberPayRuleTableViewCell.h"
#import "MemberDiscriptionViewController.h"
@interface AddMemberCardViewController ()<MKJMainPopoutViewDelegate>
@property (nonatomic,strong) MKJMainPopoutView *popView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) YFStepperView *StepperView;

@property (nonatomic,assign) NSInteger selectIndex;  //选择会员卡的下标
@property (nonatomic,assign) NSInteger selectNum;    //选择会员卡的数量
@property (nonatomic,strong) UIImage *invitimage;
@property (nonatomic,assign) CGFloat inviteImageHeigh;

@property (nonatomic,strong) MemberViewModel *viewModel;
@end

@implementation AddMemberCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectIndex = 0;
    self.selectNum   = 1;
    [self setNavigationItemLeft:@"选择会员卡类型"];
    
    [self creatManiview];
    
    [self setData];
    
    //如果是失效的会员卡进来 提示信息
    [self performSelector:@selector(showToast) withObject:nil afterDelay:1.0];
    
    //监听购买会员卡支付成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyVipCardSuccess) name:@"buyVipCardSuccess" object:nil];
}

//购买会员卡成功 刷新会员卡列表
- (void)buyVipCardSuccess
{
    vipDataModel *model = self.viewModel.vipList[self.selectIndex];
    if(model.arrears_price.floatValue > 0)
    {
        [MBProgressHUD show:@"已补齐会员卡费，会员权益已恢复，会员期已相应顺延，祝您购物愉快。" icon:nil view:self.view];
    }else{
        [MBProgressHUD show:@"购买成功，会员卡权益已开通，祝您购物愉快。" icon:nil view:self.view];
    }
    kWeakSelf(self);
    [self.viewModel getVipData:^{
        [weakself.dataSource removeAllObjects];
        [weakself.popView refreshSelectIndex:self.selectIndex];
        [weakself.MytableView reloadData];
    }];
}

- (void)showToast
{
    if(self.vip_type.integerValue == -1)
    {
//        [MBProgressHUD show:@"尊敬的衣蝠会员，您的会员卡费已被用于购买商品，补足会员卡费即可继续免费领。" icon:nil view:self.view];
        [MBProgressHUD show:@"因会员卡费不足会员资格已失效，现在开通新卡立即赠送一件399元的美衣哦。" icon:nil view:self.view];

    }else if (self.vip_type.integerValue == -2)
    {
        [MBProgressHUD show:@"尊敬的衣蝠会员，您今日的会员卡免费领次数已使用完，购买新的会员卡即可继续免费领。" icon:nil view:self.view];
    }else if (self.vip_type.integerValue == -3)
    {
        [MBProgressHUD show:@"尊敬的衣蝠会员，您的会员卡费已被全额用于购买商品，请重新购买会员卡。" icon:nil view:self.view];
    }
}
- (void)setData
{
    self.viewModel = [[MemberViewModel alloc]init];
    
    kWeakSelf(self);
    [self.viewModel getVipData:^{
        //如果办过会员卡就切换到最高级别的会员卡
        if(weakself.viewModel.vipList.count)
        {
            if([weakself.from_vipType isEqualToString:@"-1003"])
            {
                weakself.selectIndex = weakself.viewModel.max_vipTypeIndex;
            }else if ([weakself.from_vipType isEqualToString:@"-1001"])
            {
                weakself.selectIndex = weakself.viewModel.vipList.count - 1;
            }
            
            if(self.vip_type.integerValue == -4)
            {
                vipDataModel *model = self.viewModel.vipList[weakself.viewModel.vipList.count-1];
                [MBProgressHUD show:[NSString stringWithFormat:@"尊敬的衣蝠会员，您当前的会员卡只能免费领%@元以下商品，请购买高等级的会员卡免费领更多商品",model.price_section] icon:nil view:self.view];
            }
        }
        [weakself.popView refreshSelectIndex:weakself.selectIndex];
        [weakself refreshFootPayViewNum:1];
        
        [weakself.popView showInSuperView:weakself.TableHeadView];
        [weakself.MytableView reloadData];
    }];
}
- (void)creatManiview
{
    self.invitimage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/qingfengpic/InviteFriends_img2.jpg"]]]];
    self.inviteImageHeigh = self.invitimage.size.height*kScreen_Width/self.invitimage.size.width;
    self.inviteImageHeigh = 0;
    
    [self.view addSubview:self.MytableView];
    [self.view addSubview:self.PayFootView];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
 
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return UITableViewAutomaticDimension;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
     
    if(self.viewModel.vipList.count > 0)
    {
        vipDataModel *model = self.viewModel.vipList[self.selectIndex];
        
        NSString *vip_code = [NSString stringWithFormat:@"%@",model.vip_code];
        if(![vip_code isEqualToString:@"(null)"]){
            return model.equityYet.count +1;
        }else{
            return model.equity.count +1;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(indexPath.row == 0)
    {
        MemberPayTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MemberPayCell"];
        if(!cell)
        {
            cell=[[MemberPayTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MemberPayCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.bounsLabel.text = self.viewModel.bouns.floatValue>0?[NSString stringWithFormat:@"-￥%.2f",self.viewModel.bouns.floatValue]:@"-￥0.0";
        
//        [self.StepperView removeFromSuperview];
//        self.StepperView = [[YFStepperView alloc] initWithFrame:CGRectMake(kScreen_Width-kZoom6pt(100)-10, 75, kZoom6pt(100), kZoom6pt(25))];
//        self.StepperView.minimumValue = 1;
//        self.StepperView.maximumValue = 1000;
//        self.StepperView.stepValue = 1;
        
//        kWeakSelf(self);
//        self.StepperView.valueChangeBlock = ^(NSInteger value) {
//            [weakself refreshFootPayViewNum:value];
//        };
        
        if(self.viewModel.vipList.count > 0){
            vipDataModel *model = self.viewModel.vipList[self.selectIndex];
            [cell refreshData:self.selectIndex VipData:model];
            
//            if(model.arrears_price.floatValue == 0)//欠费先补卡再办卡所以不显示
//            {
//                [cell.contentView addSubview:self.StepperView];
//            }
        }
        kWeakSelf(self);
        cell.disblock = ^{
            [MBProgressHUD show:@"预存款将全额返还给您至您的衣蝠钱包，可用来以会员价购买任意商品。不支持退款哦。" icon:nil view:weakself.view];
        };
        cell.wenhaoblock = ^{
            MemberDiscriptionViewController *memdis = [[MemberDiscriptionViewController alloc]init];
            [weakself.navigationController pushViewController:memdis animated:YES];
        };
        return cell;
    }else {
        
        MemberPayRuleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MemberPayRuleCell"];
        if(!cell)
        {
            cell=[[MemberPayRuleTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MemberPayRuleCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if(self.viewModel.vipList.count > 0){
            vipDataModel *model = self.viewModel.vipList[self.selectIndex];
            [cell refreshData:model Price:[NSString stringWithFormat:@"%.2f",self.viewModel.raffle_money.floatValue] Count:[NSString stringWithFormat:@"%zd",indexPath.row-1]];
        }
        return cell;
    }
    return 0;
}

- (void)payClick:(UIButton*)sender
{
    NSLog(@"开通并支付");
    kWeakSelf(self);
    vipDataModel *vipmodel = self.viewModel.vipList[self.selectIndex];
    [self.viewModel addUserVipCard:self.selectNum VipType:vipmodel.vip_type.integerValue Success:^(id data) {
        MemberModel *model =data;
        if(model.status == 1)
        {
            NSString *actual_price = [NSString stringWithFormat:@"%@",model.actual_price];
            //actual_price为0不用支付
            if([actual_price isEqualToString:@"0"])
            {
                //发送购买会员成功的通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"buyVipCardSuccess" object:nil];
                
            }else{
                TFPayStyleViewController*paystyle=[[TFPayStyleViewController alloc]init];
                paystyle.price = vipmodel.vip_price.floatValue;
                paystyle.urlcount=@"2";
                paystyle.order_code=model.v_code;
                paystyle.shop_from = @"11";
                paystyle.fromType = @"购买会员";
                [weakself.navigationController pushViewController:paystyle animated:YES];
            }
        }
    }];
;
}
#pragma mark - 懒加载数据
- (MKJMainPopoutView *)popView
{
    if (_popView == nil) {
        _popView = [[MKJMainPopoutView alloc] initWithFrame:CGRectMake(0, self.inviteImageHeigh, SCREEN_WIDTH, 250)];
    }
    _popView.dataSource = self.dataSource;
    _popView.delegate = self;
    
    kWeakSelf(self);
    _popView.selectBlock = ^(NSInteger selectIndex) {

        weakself.selectIndex = selectIndex;
        [weakself.MytableView reloadData];
        [weakself refreshFootPayViewNum:1];
    };
    
    return _popView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource.count)
    {
        _dataSource = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i <
             self.viewModel.vipList.count; i ++) {
            vipDataModel *vipdataModel = self.viewModel.vipList[i];
            
            MKJItemModel *model = [[MKJItemModel alloc] init];
            model.imageName = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],vipdataModel.url];
            model.titleName = [NSString stringWithFormat:@"%@",vipdataModel.vip_name];
            if(vipdataModel.vip_num.integerValue >0)
            {
                //vipdataModel.arrears_price.floatValue >0 欠费
                NSInteger vip_num = vipdataModel.arrears_price.floatValue >0 ? 0 : vipdataModel.vip_num.integerValue;
        
                model.titleName = vip_num >0 ? [NSString stringWithFormat:@"已有%@X%zd",vipdataModel.vip_name,vip_num]:vipdataModel.vip_name;
            }
            
            if(vipdataModel.vip_balance)
            {
                model.cardFee = [NSString stringWithFormat:@"卡费￥%.1f",vipdataModel.vip_balance.floatValue];
            }
            
            model.context = vipdataModel.context?vipdataModel.context:@"";
            model.substance = vipdataModel.substance?vipdataModel.substance:@"";
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

- (UITableView*)MytableView
{
    if(_MytableView == nil)
    {
        _MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreen_Width, kScreen_Height-Height_NavBar-50)];
        _MytableView.backgroundColor = RGBCOLOR_I(247, 247, 247);
        _MytableView.separatorStyle = UITableViewCellEditingStyleNone;
        _MytableView.estimatedRowHeight = 50;
        _MytableView.rowHeight = UITableViewAutomaticDimension;
        _MytableView.delegate = self;
        _MytableView.dataSource = self;
        
        [_MytableView registerNib:[UINib nibWithNibName:@"MemberPayTableViewCell" bundle:nil] forCellReuseIdentifier:@"MemberPayCell"];
//        [_MytableView registerNib:[UINib nibWithNibName:@"MemberPayStyleTableViewCell" bundle:nil] forCellReuseIdentifier:@"MemberPayStyleCell"];
        [_MytableView registerNib:[UINib nibWithNibName:@"MemberPayRuleTableViewCell" bundle:nil] forCellReuseIdentifier:@"MemberPayRuleCell"];
        
    }
    _MytableView.tableHeaderView = self.TableHeadView;
    
    return _MytableView;
}
- (UIView*)TableHeadView
{
    if(_TableHeadView == nil)
    {
        kWeakSelf(self);
        InvitFriendFreeLingView *lingview = [[InvitFriendFreeLingView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, self.inviteImageHeigh)];
        lingview.invitFreeLingBlock = ^{
            InviteFriendFreelingViewController *friendraward = [[InviteFriendFreelingViewController alloc]init];
            friendraward.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:friendraward animated:YES];
        };
        __weak InvitFriendFreeLingView *vvself = lingview;
        vvself.closeFreeLingBlock = ^{
            [vvself removeFromSuperview];
            
            weakself.inviteImageHeigh = 0;
            weakself.TableHeadView.frame = CGRectMake(0, 0, kScreenWidth, 250);
            weakself.popView.frame = CGRectMake(0, 0, kScreenWidth, 250);
            [weakself.MytableView reloadData];
        };
        
        _TableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 250+self.inviteImageHeigh)];
        [_TableHeadView addSubview:lingview];
    }
    
    return _TableHeadView;
}
- (UIView *)TableFootView
{
    if(_TableFootView == nil)
    {
        _TableFootView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(200))];
        _TableFootView.backgroundColor = RGBCOLOR_I(247, 247, 247);;
        
        UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), ZOOM6(20), kScreenWidth-2*ZOOM6(20), ZOOM6(40))];
        titlelab.text = @"今日剩余免费领商品次数：";
        titlelab.textColor = RGBA(125,125,125,1);
        titlelab.font = [UIFont systemFontOfSize:ZOOM6(32)];
        [_TableFootView addSubview:titlelab];
        
        UILabel *discriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), ZOOM6(80), kScreenWidth-2*ZOOM6(20), ZOOM6(40))];
        discriptionlab.text = [NSString stringWithFormat:@"%@件任意价格商品，每件%@次",@"3",@"9"];
        discriptionlab.textColor = RGBA(125,125,125,1);
        discriptionlab.font = [UIFont systemFontOfSize:ZOOM6(28)];
        [_TableFootView addSubview:discriptionlab];
        
    }
    return _TableFootView;
}
- (UIView*)PayFootView
{
    if(_PayFootView == nil)
    {
        _PayFootView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreen_Height-50, kScreen_Width, 50)];
        _PayFootView.backgroundColor = tarbarrossred;
        
        UILabel *priceLab = [[UILabel alloc]init];
        priceLab.frame = CGRectMake(20, 5, kScreen_Width*0.43, 20);
        priceLab.textColor = kWiteColor;
        priceLab.text = @"预存39元升级钻石会员";
        priceLab.font = [UIFont boldSystemFontOfSize:ZOOM6(30)];
        [_PayFootView addSubview:self.PriceLab = priceLab];
        
        UILabel *markLabel = [[UILabel alloc]init];
        markLabel.frame = CGRectMake(20, 25, kScreen_Width*0.3, 20);
        markLabel.textColor = kWiteColor;
        markLabel.text = @"预存款全额返还";
        markLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(20)];
        [_PayFootView addSubview:markLabel];
        
        UILabel *oldpriceLab = [[UILabel alloc]init];
        oldpriceLab.frame = CGRectMake(CGRectGetMaxX(priceLab.frame)-ZOOM6(150), 25, ZOOM6(150), 20);
        oldpriceLab.textColor = kWiteColor;
        oldpriceLab.textAlignment = NSTextAlignmentRight;
        oldpriceLab.text = [NSString stringWithFormat:@"原价￥169"];
        oldpriceLab.font = [UIFont boldSystemFontOfSize:ZOOM6(20)];
        [_PayFootView addSubview:self.oldPriceLab = oldpriceLab];
        
        UILabel *priceLineLab = [[UILabel alloc]init];
        priceLineLab.frame = CGRectMake(CGRectGetMaxX(priceLab.frame), 0, kScreen_Width*0.3, 1);
        priceLineLab.backgroundColor = [UIColor clearColor];
        priceLineLab.centerY = oldpriceLab.centerY+1;
        priceLineLab.centerX = oldpriceLab.centerX;
        [_PayFootView addSubview:self.priceLineLab = priceLineLab];
        
        UIButton *paybutton = [UIButton buttonWithType:UIButtonTypeCustom];
        paybutton.frame = CGRectMake(kScreen_Width*0.65,10, kScreen_Width*0.3, 30);
        paybutton.backgroundColor = [UIColor redColor];
        paybutton.layer.masksToBounds = YES;
        paybutton.layer.cornerRadius = 15;
        [paybutton setTitle:@"预存并开通" forState:UIControlStateNormal];
        [paybutton setTitleColor:kWiteColor forState:UIControlStateNormal];
        paybutton.titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(32)];
        [paybutton addTarget:self action:@selector(payClick:) forControlEvents:UIControlEventTouchUpInside];
        [_PayFootView addSubview:self.PayButton = paybutton];
    }
    
    return _PayFootView;
}
- (void)refreshFootPayViewNum:(NSInteger)num
{
    
    vipDataModel *model = self.viewModel.vipList[self.selectIndex];
    self.selectNum = num;
    NSString *ptext = [NSString stringWithFormat:@"%.0f元",model.vip_price.floatValue];
    self.PriceLab.text =[NSString stringWithFormat:@"预存%@升级%@",ptext,model.vip_name];
    [self.PriceLab setAttributedText:[NSString getOneColorInLabel:self.PriceLab.text ColorString:ptext Color:[UIColor yellowColor] font:kFont6px(30)]];
    
    self.oldPriceLab.text = [NSString stringWithFormat:@"原价￥%.0f元",model.original_vip_price.floatValue*num];
    
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(32)];
    NSDictionary *attributes1 = @{NSFontAttributeName:font};
    CGSize textSize = [self.PriceLab.text boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes1 context:nil].size;
    
    UIFont *font1 = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(22)];
    NSDictionary *attributes11 = @{NSFontAttributeName:font1};
    CGSize lineSize = [self.oldPriceLab.text boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes11 context:nil].size;
    
    self.PriceLab.frame = CGRectMake(self.PriceLab.frame.origin.x, self.PriceLab.frame.origin.y, textSize.width, self.PriceLab.frame.size.height);
    self.oldPriceLab.frame = CGRectMake(CGRectGetMaxX(self.PriceLab.frame)-lineSize.width-6, self.oldPriceLab.frame.origin.y, lineSize.width, self.oldPriceLab.frame.size.height);
    self.priceLineLab.frame = CGRectMake(CGRectGetMaxX(self.PriceLab.frame), self.priceLineLab.frame.origin.y, lineSize.width, 1);
    self.priceLineLab.backgroundColor = kTextColor;
    self.priceLineLab.centerY = self.oldPriceLab.centerY+1;
    self.priceLineLab.centerX = self.oldPriceLab.centerX;
}
- (void)leftBarButtonClick
{
    UIViewController *vc = self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
    if([vc isKindOfClass:[OneLuckdrawViewController class]] || [vc isKindOfClass:[HBmemberViewController class]])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
