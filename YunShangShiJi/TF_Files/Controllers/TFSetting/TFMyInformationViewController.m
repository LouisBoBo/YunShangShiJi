//
//  TFMyInformationViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/6/30.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFMyInformationViewController.h"
#import "VPImageCropperViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "TFNickNameViewController.h"
#import "AccountAddressViewController.h"
#import "TFReceivingAddressViewController.h"
#import "PersonalizedViewController.h"
#import "AddAdressViewController.h"
#import "TFCellView.h"
#import "NavgationbarView.h"
#import "LoginViewController.h"
#import "UpYun.h"
#import "HZAreaPickerView.h"
#import "SubmitViewController.h"
#import "MemberNumberViewController.h"
#import "SelectHobbyViewController.h"
#import "MyselfQRcodeViewController.h"
#import "MyselfInvitCodeViewController.h"
#import "MemberRawardsViewController.h"
#define ORIGINAL_MAX_WIDTH 640.0f

#import "SettingCell.h"
#import "YFUserModel.h"
#import "AddressModel.h"

@interface CFPersonCenterInfoHeaderCell : UITableViewCell
@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UIImageView *personPic;
@end
@implementation CFPersonCenterInfoHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.leftLabel];
        [self addSubview:self.personPic];
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return self;
}
- (UILabel *)leftLabel {
    if (_leftLabel==nil) {
        _leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(30), 0, kScreenWidth, ZOOM6(160))];
        _leftLabel.font=[UIFont systemFontOfSize:ZOOM6(30)];
        _leftLabel.textColor=kMainTitleColor;

    }
    return _leftLabel;
}
- (UIImageView *)personPic {
    if (_personPic==nil) {
        _personPic=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM6(160), ZOOM6(30), ZOOM6(100), ZOOM6(100))];
        _personPic.layer.cornerRadius=ZOOM6(50);
        _personPic.clipsToBounds=YES;
        _personPic.backgroundColor=[UIColor lightGrayColor];
       
    }
    return _personPic;
}

@end
@interface CFPersonCenterInfoCell : UITableViewCell
@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UILabel *rightLabel;
@end
@implementation CFPersonCenterInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightLabel];
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}
- (UILabel *)leftLabel {
    if (_leftLabel==nil) {
        _leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(30), 0, kScreenWidth, ZOOM6(100))];
        _leftLabel.font=[UIFont systemFontOfSize:ZOOM6(30)];
        _leftLabel.textColor=kMainTitleColor;
    }
    return _leftLabel;
}
- (UILabel *)rightLabel {
    if (_rightLabel==nil) {
        _rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3-ZOOM6(60), 0, kScreenWidth/3*2, ZOOM6(100))];
        _rightLabel.font=[UIFont systemFontOfSize:ZOOM6(24)];
        _rightLabel.textColor=kSubTitleColor;
        _rightLabel.textAlignment=NSTextAlignmentRight;
    }
    return _rightLabel;
}
@end

@interface TFMyInformationViewController () <UIActionSheetDelegate,UIImagePickerControllerDelegate,VPImageCropperDelegate,UINavigationControllerDelegate,HZAreaPickerDelegate,UIPickerViewDataSource,UIPickerViewDelegate, SubmitViewControllerDelegate,UITableViewDataSource, UITableViewDelegate>
{
    UIView *bottomView;
    NSArray *_titleArr;
    NSString *_oldaddress;
    NSString *_oldbirthday;
}

@property (nonatomic, strong)UIView *tableViewHeadView;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@property (nonatomic, strong)NSMutableArray *rightTextArray;

@property (nonatomic, strong)NSString *addressString;
@property (nonatomic, strong)NSString *birthdayString;

@property (strong, nonatomic) HZAreaPickerView *locatePicker;
@property (strong, nonatomic)UILabel *addressLabel;
@property (strong, nonatomic)UILabel *birthDayLabel;
@property (strong, nonatomic)UIDatePicker *datePicker;
@property (strong, nonatomic)UIView *bgView;
@property (strong, nonatomic)NSString *provinceID;
@property (strong, nonatomic)NSString *cityID;
//记录是保存地区还是生日
@property (strong, nonatomic)NSString *isAddressOrbirthday;

@end

@implementation TFMyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    [super setNavigationItemLeft:@"个人资料"];
    

    [self getCityAndProvince];
    [self httpReceivingAddress];
    
    [self createNewUI];
//    [self createUI];
}
- (void)getCityAndProvince {
    [YFUserModel getUserInfoWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID] success:^(id data) {
        YFUserModel *model=data;
        if (model.status==1) {
            if (![model.userinfo.province isEqual:[NSNull null]] && ![model.userinfo.city isEqual:[NSNull null]]) {
                NSArray *array=[self getAddressStateID:model.userinfo.province withCityID:model.userinfo.city witAreaID:nil withStreetID:nil];
                if(array.count >= 2) {
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@%@",array[0],array[1]] forKey:USER_ARRER];
                    [self.rightTextArray replaceObjectAtIndex:3 withObject:[[NSUserDefaults standardUserDefaults] objectForKey:USER_ARRER]];
                    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                }
            }else
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@""] forKey:USER_ARRER];
        }
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    Myview.hidden=YES;

    NSString *username = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME]];
    (username!=nil &&![username isEqualToString:@"(null)"])?[self.rightTextArray replaceObjectAtIndex:1 withObject:username]:nil;
    NSString *sign = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_PERSON_SIGN]];
    (sign!=nil && ![sign isEqualToString:@"(null)"])?[self.rightTextArray replaceObjectAtIndex:self.rightTextArray.count-4 withObject:sign]:nil;
    
    NSString *address = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ADDRESS];
    if (address) {
        [self.rightTextArray replaceObjectAtIndex:2 withObject:[[NSUserDefaults standardUserDefaults] objectForKey:USER_ADDRESS]];
    }

    MyLog(@"%@",self.rightTextArray);
    [self.tableView reloadData];
}
- (void)createNewUI{
    
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
}

#pragma mark - tableHeadView
- (UIView *)tableViewHeadView
{
    if (_tableViewHeadView == nil) {
        CGFloat lr_Margin = ZOOM(62);
        CGFloat iv_W_H = ZOOM(100);
        
        CGFloat ud_Margin = ZOOM(36);
        
        CGFloat iv_WH = ZOOM(200);
        CGFloat HH = ud_Margin*2+iv_WH;
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HH)];
        
        TFCellView *tcv = [[TFCellView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HH)];
        tcv.tag = 200;
        tcv.headImageView.frame = CGRectMake(lr_Margin, (HH-iv_W_H)/2, iv_W_H, iv_W_H);
        tcv.headImageView.image = [UIImage imageNamed:@"头像"];
        tcv.titleLabel.frame = CGRectMake( tcv.headImageView.right+lr_Margin, 0, kScreenWidth-tcv.titleLabel.frame.origin.x-lr_Margin-iv_WH, HH);
        tcv.titleLabel.text = @"头像";
        tcv.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
        tcv.titleLabel.textColor = RGBCOLOR_I(34,34,34);
        tcv.detailImageView.frame = CGRectMake(kScreenWidth-lr_Margin-iv_WH, (HH-iv_WH)/2, iv_WH, iv_WH);
        
        tcv.detailImageView.layer.cornerRadius = iv_WH/2;
        tcv.detailImageView.layer.masksToBounds = YES;
        
        //关于头像
        //1.先从沙盒里面取，如果没有，用替代
        //先判断用户是否登录
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        NSString *User_id = [ud objectForKey:USER_ID];
        NSString *defaultPic = [ud objectForKey:USER_HEADPIC];
        
        NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),User_id];
        UIImage *imgFromUrl=[[UIImage alloc] initWithContentsOfFile:aPath];
        if (imgFromUrl!=nil) { //判断用户是否登陆
            tcv.detailImageView.image = imgFromUrl;
        } else {
            if ([defaultPic hasPrefix:@"http"]) {
                [tcv.detailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",defaultPic]]];
            }else
                [tcv.detailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy],defaultPic]]];
            
            
        }
        
        tcv.cellBtn.tag = 100;
        [tcv.cellBtn addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:tcv];
        
        _tableViewHeadView = headView;
    }
    
    
    
    return _tableViewHeadView;
}

#pragma mark - tableView
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"SettingCell" bundle:nil] forCellReuseIdentifier:@"SETTINGCELLID"];
        [_tableView registerClass:[CFPersonCenterInfoHeaderCell class] forCellReuseIdentifier:@"CFPersonCenterInfoHeaderCell"];
        [_tableView registerClass:[CFPersonCenterInfoCell class] forCellReuseIdentifier:@"CFPersonCenterInfoCell"];

        //        _tableView.backgroundColor = COLOR_ROSERED;
        _tableView.tableFooterView = [[UIView alloc] init];
//        _tableView.tableHeaderView = self.tableViewHeadView;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
        view.backgroundColor = COLOR_ROSERED;
        

//        _tableView.tableHeaderView = self.tableViewHeadView;
//        _tableView.tableHeaderView = view;
        
    }
    return _tableView;
}

#pragma mark - dataSource
- (NSMutableArray *)rightTextArray {
    if (_rightTextArray==nil) {
        NSString *hobby = [[NSUserDefaults standardUserDefaults] objectForKey:USER_HOBBY];
        if (hobby.length!=0) {
            _rightTextArray=[NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
        }else
            _rightTextArray=[NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];

//        [_rightTextArray replaceObjectAtIndex:_rightTextArray.count-1 withObject:[[NSUserDefaults standardUserDefaults] objectForKey:USER_BIRTHDAY]];

    }
    return _rightTextArray;
}
- (NSMutableArray *)dataSourceArray
{
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *ismember = [userdefaul objectForKey:USER_MEMBER];
    
    NSString *hobby = [userdefaul objectForKey:USER_HOBBY];
    
    //    NSArray *titleArr;
    
    if (_dataSourceArray == nil) {
        
        if(hobby.length !=0)
        {
            _titleArr = [NSArray arrayWithObjects:
                         @"头像",
                         @"昵称",
                         @"收货地址",
                         @"地区",
                         @"我的喜好",
                         @"个性签名",
                         @"邀请码",
                         @"我的二维码",
                         @"好友奖励",nil];
        }else{
            _titleArr = [NSArray arrayWithObjects:
                         @"头像",
                         @"昵称",
                         @"收货地址",
                         @"地区",
                         @"个性签名",
                         @"邀请码",
                         @"我的二维码",
                         @"好友奖励",nil];
        }
        _dataSourceArray = [NSMutableArray arrayWithArray:_titleArr];

    }
    /*
    if (_dataSourceArray == nil) {
        if(ismember.intValue == 2)
        {
            if(hobby.length !=0)
            {
                _titleArr = [NSArray arrayWithObjects:
                                                    @"昵称",
                                                    @"收货地址",
                                                    @"我的喜好",
                                                    @"地区",
//                                                    @"生日",
                                                    @"个性签名",
                                                    @"会员卡", nil];
            } else{
                _titleArr = [NSArray arrayWithObjects:
                                                    @"昵称",
                                                    @"收货地址",
                                                    @"地区",
//                                                    @"生日",
                                                    @"个性签名",
                                                    @"会员卡", nil];
            }
        } else{
            
            if(hobby.length !=0)
            {
                _titleArr = [NSArray arrayWithObjects:
                                                    @"昵称",
                                                    @"收货地址",
                                                    @"我的喜好",
                                                    @"地区",
//                                                    @"生日",
                                                    @"个性签名", nil];
            }else{
                _titleArr = [NSArray arrayWithObjects:
                                                    @"昵称",
                                                    @"收货地址",
                                                    @"地区",
//                                                    @"生日",
                                                    @"个性签名", nil];
            }
            
        }
        _dataSourceArray = [NSMutableArray arrayWithArray:_titleArr];
    }
    */
    return _dataSourceArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSourceArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return ZOOM(172);
    return indexPath.row==0?ZOOM6(160):ZOOM6(100);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        CFPersonCenterInfoHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CFPersonCenterInfoHeaderCell"];
        cell.leftLabel.text=self.dataSourceArray[indexPath.row];
        //关于头像
        //1.先从沙盒里面取，如果没有，用替代
        //先判断用户是否登录
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        NSString *User_id = [ud objectForKey:USER_ID];
        NSString *defaultPic = [ud objectForKey:USER_HEADPIC];
        
        NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),User_id];
        UIImage *imgFromUrl=[[UIImage alloc] initWithContentsOfFile:aPath];
        if (imgFromUrl!=nil) { //判断用户是否登陆
            cell.personPic.image = imgFromUrl;
        } else {
            if ([defaultPic hasPrefix:@"http"]) {
                [cell.personPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",defaultPic]]];
            }else
                [cell.personPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy],defaultPic]]];
        }
        return cell;
    }else{
        CFPersonCenterInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CFPersonCenterInfoCell"];
        cell.leftLabel.text=self.dataSourceArray[indexPath.row];
        cell.rightLabel.text=self.rightTextArray[indexPath.row];
        return cell;
    }
    /*
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SETTINGCELLID"];
    
    NSString *st = self.dataSourceArray[indexPath.row];
    cell.headImageView.image = [UIImage imageNamed:st];
    cell.titleLabel.text = st;
    
    cell.M_l_headImageView.constant = ZOOM(62);
    cell.W_H_headImageView.constant = ZOOM(100);
    cell.M_l_titleLabel.constant = cell.W_H_headImageView.constant+cell.M_l_headImageView.constant*2;
    cell.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *arrea=[ud objectForKey:USER_ARRER];
    NSString *birthday =[ud objectForKey:USER_BIRTHDAY];
    
    if ([st isEqualToString:@"地区"]) {
        if (arrea) {
            //arrea = %@", arrea);
            cell.subTitleLabel.frame = CGRectMake(CGRectGetMaxX(cell.titleLabel.frame)+ZOOM6(20), cell.frame.origin.y, cell.frame.size.width-CGRectGetMaxX(cell.titleLabel.frame), cell.frame.size.height);
            cell.subTitleLabel.textColor = COLOR_ROSERED;
            cell.subTitleLabel.text = [NSString stringWithFormat:@"%@", arrea];
            cell.subTitleLabel.font = kFont6px(32);
        }
    } else if ([st isEqualToString:@"生日"]) {
        if (birthday) {
            //birthday = %@", birthday);
            cell.subTitleLabel.textColor = COLOR_ROSERED;
            cell.subTitleLabel.text = [NSString stringWithFormat:@"%@", birthday];
            cell.subTitleLabel.font = kFont6px(32);
        }
    }
    
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    //    cell.contentView.backgroundColor = COLOR_RANDOM;
    */
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *st = self.dataSourceArray[indexPath.row];
    if ([st isEqualToString:@"头像"]) {
        [self selectFromPhotos];
    }else if ([st isEqualToString:@"昵称"]) {
        TFNickNameViewController *tnvc = [[TFNickNameViewController alloc] init];
        [self.navigationController pushViewController:tnvc animated:YES];
    } else if ([st isEqualToString:@"收货地址"]) {
        TFReceivingAddressViewController *adress = [[TFReceivingAddressViewController alloc] init];
        [self.navigationController pushViewController:adress animated:YES];
    } else if ([st isEqualToString:@"我的喜好"]) {
//        SubmitViewController *sbVC = [[SubmitViewController alloc] init];
//        sbVC.delegate = self;
//        [self.navigationController pushViewController:sbVC animated:YES];
        
        SelectHobbyViewController *hobby = [[SelectHobbyViewController alloc]init];
        hobby.hidesBottomBarWhenPushed = YES;
        hobby.is_change = YES;
        [self.navigationController pushViewController:hobby animated:YES];
        
    } else if ([st isEqualToString:@"地区"]) {
        [self cancelLocatePicker];
        
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAddress delegate:self];
        
        [self.locatePicker showInView:self.view];
    } else if ([st isEqualToString:@"生日"]) {
        [self createPickView];
        
    } else if ([st isEqualToString:@"个性签名"]) {
        PersonalizedViewController *person =[[PersonalizedViewController alloc]init];
        [self.navigationController pushViewController:person animated:YES];
    } else if ([st isEqualToString:@"会员卡"]) {
        MemberNumberViewController *memnumber = [[MemberNumberViewController alloc]init];
        
        [self.navigationController pushViewController:memnumber animated:YES];
    } else if ([st isEqualToString:@"邀请码"]){
        
        MyselfInvitCodeViewController *memnumber = [[MyselfInvitCodeViewController alloc]init];
        
        [self.navigationController pushViewController:memnumber animated:YES];
    } else if ([st isEqualToString:@"我的二维码"]){
        MyselfQRcodeViewController *memnumber = [[MyselfQRcodeViewController alloc]init];
        
        [self.navigationController pushViewController:memnumber animated:YES];
    } else if ([st isEqualToString:@"好友奖励"]){
        
        MemberRawardsViewController *memnumber = [[MemberRawardsViewController alloc]init];
        [self.navigationController pushViewController:memnumber animated:YES];
    }
}
/*
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
*/





- (void)submitSuccess:(SubmitViewController *)submitController
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    [nv showLable:@"喜好修改成功" Controller:self];
}

- (void)submitFailure:(SubmitViewController *)submitController
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    [nv showLable:@"喜好修改失败,请重新尝试!" Controller:self];

}

- (void)cellBtnClick:(UIButton *)sender
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    if (token!=nil) {   //如果用户处于登录状态
        if (sender.tag == 100) { //头像
            
            [self selectFromPhotos];
            /*
            UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                     delegate:self
                                                            cancelButtonTitle:@"取消"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"拍照", @"从相册中选取", nil];
            [choiceSheet showInView:self.view];
            */
        }
    }
}
- (void)createPickView
{
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgView.backgroundColor = RGBACOLOR_F(0.5,0.5,0.5,0.6);
    [self.view addSubview:_bgView];
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _bgView.frame.size.height-216, kScreenWidth, 216)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:bottomView];
    
    //创建PickView
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 35, kApplicationWidth, 216)];
    
    _datePicker.datePickerMode = UIDatePickerModeDate;
    //设置日期为中文
    _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [_datePicker addTarget:self action:@selector(dateClick:) forControlEvents:UIControlEventValueChanged];
    
    //设置最大日期
    NSDate *maxDate = [NSDate date];
    [_datePicker setMaximumDate:maxDate];
    
    [bottomView addSubview:_datePicker];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(barButton:)];
    item.tintColor=[UIColor blackColor];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnClick:)];
    item2.tintColor=[UIColor blackColor];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar.items = @[spaceItem,item2,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,item,spaceItem];
    
    [bottomView addSubview:toolBar];
    
}
- (void)cancelBtnClick:(UIBarButtonItem *)sender
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         bottomView.frame = CGRectMake(0, bottomView.frame.origin.y+bottomView.frame.size.height, bottomView.frame.size.width, bottomView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self.bgView removeFromSuperview];
                         
                     }];
}
//完成按钮
- (void)barButton:(UIBarButtonItem *)sender
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         bottomView.frame = CGRectMake(0, bottomView.frame.origin.y+bottomView.frame.size.height, bottomView.frame.size.width, bottomView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self.bgView removeFromSuperview];
                         
                     }];
    
    NSDate *date = _datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
//    NSString *string = [formatter stringFromDate:date];
//    _birthDayLabel.text=[string stringByReplacingOccurrencesOfString:@"-" withString:<#(nonnull NSString *)#>]

    self.birthdayString = [formatter stringFromDate:date];
    

    _isAddressOrbirthday = @"保存生日";
    [self saveHttp];
}
-(void)dateClick:(UIButton *)sender
{
    /*
     NSDate *date = _datePicker.date;
     //转成字符串
     NSString *dateStr = date.description;
     NSArray *dateArr = [dateStr componentsSeparatedByString:@" "];
     _birthDayLabel.text = dateArr[0];
     */
    UIDatePicker *dataPicker_one = (UIDatePicker *)sender;
    NSDate *date_one = dataPicker_one.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    //++++++++++++++++
    self.birthdayString = [formatter stringFromDate:date_one];
    
    
}
-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}
#pragma mark - HZAreaPicker delegate
-(void)doneClick:(HZAreaPickerView *)picker
{
    /************  改变地址   **********/
    _addressLabel.text = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
    
    //++++++++++++++++
    self.addressString = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
    
    _provinceID = picker.locate.stateID;
    _cityID = picker.locate.cityID;
    

    _isAddressOrbirthday = @"保存地区";
        
    
    [self saveHttp];
    
    
}

-(void)saveHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *userID = [user objectForKey:USER_ID];
    
    NSString *birthDayString = [NSMutableString stringWithFormat:@"%@",self.birthdayString];

    birthDayString=[birthDayString stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
    birthDayString= [birthDayString stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    birthDayString= [birthDayString stringByReplacingOccurrencesOfString:@"日" withString:@""];

    //%@  ",birthDayString);
    
    NSString *url;
    
    if([_isAddressOrbirthday isEqualToString:@"保存地区"])
    {
        url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&user_id=%@&province=%@&city=%@",[NSObject baseURLStr],VERSION,token,userID,_provinceID,_cityID];
    } else{
        url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&user_id=%@&birthday=%@",[NSObject baseURLStr],VERSION,token,userID,birthDayString];
    }
    
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        //responseObject is %@",responseObject);
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
           
            
            if(str.intValue==1)
            {
                message=@"保存成功";
                
                if([_isAddressOrbirthday isEqualToString:@"保存地区"])
                {
                    [user setObject:self.addressString forKey:USER_ARRER];
                } else{
                    [user setObject:self.birthdayString forKey:USER_BIRTHDAY];
                }
                [_rightTextArray replaceObjectAtIndex:3 withObject:[[NSUserDefaults standardUserDefaults] objectForKey:USER_ARRER]];

                
                [self.tableView reloadData];
            }
            else if(str.intValue == 10030){//没登录状态
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }

            else{
                message=@"保存失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"保存失败,请重试!" Controller:self];
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }];
    
    
}






-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
//    _addressLabel.text = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
    
    self.addressString = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
    
    
}
- (void)login
{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *User_id = [ud objectForKey:USER_ID];
    
    [ud removeObjectForKey:USER_TOKEN];
    [ud removeObjectForKey:USER_PHONE];
    [ud removeObjectForKey:USER_PASSWORD];
    [ud removeObjectForKey:USER_NAME];
    [ud removeObjectForKey:USER_EMAIL];
    [ud removeObjectForKey:USER_INFO];
    [ud removeObjectForKey:USER_ID];
    [ud removeObjectForKey:USER_REALM];
    [ud removeObjectForKey:USER_BIRTHDAY];
    [ud removeObjectForKey:USER_ARRER];
    //删除头像
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),User_id];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:aPath error:nil];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    //回到登陆页面
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag= 1000;
    [self.navigationController pushViewController:login animated:YES];
    
}
#pragma mark - 代理方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 MyLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        [self selectFromPhotos];
    }
}
- (void)selectFromPhotos {
    // 从相册中选取
    if ([self isPhotoLibraryAvailable]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self presentViewController:controller
                           animated:YES
                         completion:^(void){
                             MyLog(@"Picker View Controller is presented");
                         }];
    }
}
#pragma mark - 上传到又拍云
- (void)uploadData:(UIImage *)image
{

    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *User_id = [ud objectForKey:USER_ID];
    NSString *token = [ud objectForKey:USER_TOKEN];
    UpYun *uy = [[UpYun alloc] init];
    
    uy.successBlocker = ^(id data){
        MyLog(@"data = %@",data);
        NSString *picUrl = data[@"url"];
        
        MyLog(@"picUrl=%@",picUrl);

        NSString *urlStr = [NSString stringWithFormat:@"%@user/update_userinfo?token=%@&version=%@&pic=%@",[NSObject baseURLStr],token,VERSION,picUrl];
        NSString *URL = [MyMD5 authkey:urlStr];
        //
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

            responseObject = [NSDictionary changeType:responseObject];
            [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
            
            if (responseObject!=nil) {
                if ([responseObject[@"status"] intValue] == 1) {
                    [MBProgressHUD showSuccess:@"上传成功"];
                    
                    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),User_id];
                    NSData *imgData = UIImagePNGRepresentation(image);
                    [imgData writeToFile:aPath atomically:YES];

//                    TFCellView *tvc = (TFCellView *)[self.tableViewHeadView viewWithTag:200];
//                    
//                    tvc.detailImageView.image = image;
                    
                    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    
                    NSNotification *noti = [NSNotification notificationWithName:@"imagenote" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:noti];
                    
                } else {
                    [MBProgressHUD showError:responseObject[@"message"]];
                }

            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //修改失败
            [MBProgressHUD showError:@"网络请求失败,请检查网络设置"];
        }];
        
    };
    uy.failBlocker = ^(NSError * error) //上传失败
    {
        NSString *message = [error.userInfo objectForKey:@"message"];
        [MBProgressHUD showError:message];
        //error = %@",error);
    };
    uy.progressBlocker = ^(CGFloat percent, long long requestDidSendBytes) //上传进度
    {
        
    };
    NSLog(@"%@", [self getSaveKey]);
    
    [uy uploadFile:image saveKey:[self getSaveKey]];
}

#pragma mark - 保存名字
- (NSString *)getSaveKey
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *User_id = [ud objectForKey:USER_ID];

    NSLog(@"User_id: %@", User_id);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateTime = [dateFormatter stringFromDate:[NSDate date]];
    //%@",dateTime);
    return [NSString stringWithFormat:@"/userinfo/head_pic/headImgae%@%@.png",User_id,dateTime]; // 上传头像
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    
    //1.++++++++++++存到服务器++++++++++++
    
    [MBProgressHUD showMessage:@"正在上传头像" afterDeleay:0 WithView:self.view];
    
    UIImage *newImg = [self imageWithImage:editedImage scaledToSize:CGSizeMake(200, 200)];
    UIImage *img = [self compressImage:newImg toMaxFileSize:30];
    [self uploadData:img];
    
    [super dismissViewControllerAnimated:YES completion:^{
//        [cropperViewController dismissViewControllerAnimated:YES completion:^{
//            // TO DO
//        }];
    }];


}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    //点击了取消的按钮后
    [cropperViewController dismissViewControllerAnimated:YES completion:^{

    }];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //选择照片
//    [picker dismissViewControllerAnimated:NO completion:^() {
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        //裁剪照片
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.view.backgroundColor = [UIColor whiteColor];
        imgEditorVC.delegate = self;
        [picker presentViewController:imgEditorVC animated:NO completion:^{
            // TO DO
        }];
    }else{
        [MBProgressHUD showMessage:@"正在上传头像" afterDeleay:0 WithView:self.view];
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        UIImage *newImg = [self imageWithImage:portraitImg scaledToSize:CGSizeMake(200, 200)];
        UIImage *img = [self compressImage:newImg toMaxFileSize:30];
        [self uploadData:img];
        
        [super dismissViewControllerAnimated:YES completion:^{

        }];
    }
//    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //点击了取消按钮
    [picker dismissViewControllerAnimated:YES completion:^(){

    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) MyLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - 对图片尺寸进行压缩
- (UIImage *)compressionImage:(UIImage *)img
{
    CGSize imagesize = img.size;
    //设置图片尺寸
    imagesize.height = imagesize.height/kImageSizeCompression;
    imagesize.width = imagesize.width/kImageSizeCompression;
    //对图片大小进行压缩--
    UIImage *newImg = [self imageWithImage:img scaledToSize:imagesize];
    NSData *imageData = UIImageJPEGRepresentation(newImg, 0.25);
    return [UIImage imageWithData:imageData];
}

//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize

{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

//将图片进行大小 和 质量进行压缩
- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    
//    NSData *oldImageData = UIImageJPEGRepresentation(image, 1);
//    //old = %ld", [oldImageData length]);
    
    CGFloat compression = 1;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
//    //new = %ld", [imageData length]);
    
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

#pragma mark - 获取收获地址
- (void)httpReceivingAddress
{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@address/queryall?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                
                if ([responseObject[@"listdt"] count]) {
                    
                    NSDictionary *dic=responseObject[@"listdt"][0];
                    AddressModel *model = [[AddressModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    model.ID = dic[@"id"];
//                    model.addressArray = [self getAddressStateID:model.province withCityID:model.city witAreaID:model.area withStreetID:model.street];
                    NSArray *array =  [self getAddressStateID:model.province withCityID:model.city witAreaID:model.area withStreetID:model.street];
                    NSString *addressStr=model.address?:@"";
                    if (array.count == 4) {
                        addressStr = [NSString stringWithFormat:@"%@%@%@%@%@",array[0],array[1],array[2],array[3],model.address];
                    } else if (array.count == 3) {
                        addressStr = [NSString stringWithFormat:@"%@%@%@%@",array[0],array[1],array[2],model.address];
                    } else if (array.count == 2) {
                        addressStr = [NSString stringWithFormat:@"%@%@%@",array[0],array[1],model.address];
                    }
                     [self.rightTextArray replaceObjectAtIndex:2 withObject:addressStr];
                    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];

                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark - 获取地址
- (NSArray *)getAddressStateID:(NSNumber *)stateNum withCityID:(NSNumber *)cityNum witAreaID:(NSNumber *)areaNum withStreetID:(NSNumber *)streetNum
{
    NSString *state;
    NSString *city;
    NSString *area;
    NSString *street;
    
    NSArray *stateArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"areatbl" ofType:@"plist"]];
    if ([stateNum intValue]!=0) { //查询省
        for (NSDictionary *dic in stateArr) {
            if ([dic[@"id"] intValue] == [stateNum intValue]) { //找到省
                state = dic[@"state"];
                if ([cityNum intValue]!=0) {
                    NSArray *citiesArr = dic[@"cities"];
                    for (NSDictionary *dic in citiesArr) {
                        if ([dic[@"id"] intValue] == [cityNum intValue]) { //找到市
                            city = dic[@"city"];
                            if ([areaNum intValue]!=0) {
                                NSArray *areasArr = dic[@"areas"];
                                for (NSDictionary *dic in areasArr) {
                                    if ([dic[@"id"] intValue] == [areaNum intValue]) { //找到区
                                        area = dic[@"area"];
                                        if ([streetNum intValue]!=0) {
                                            NSArray *streetsArr = dic[@"streets"];
                                            for (NSDictionary *dic in streetsArr) {
                                                if ([streetNum intValue] == [dic[@"id"] intValue]) { //找到街道
                                                    street = dic[@"street"];
                                                    break;
                                                }
                                            }
                                        }
                                        break;
                                    }
                                }
                            }
                            break;
                        }
                    }
                }
                break;
            }
        }
    }
    if (area!=nil&&street!=nil) {
        return [NSArray arrayWithObjects:state,city,area,street, nil];
    } else if (area!=nil&&street == nil) {
        return [NSArray arrayWithObjects:state,city,area, nil];
    } else if (area ==nil&&street == nil) {
        return [NSArray arrayWithObjects:state,city, nil];
    } else
        return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
