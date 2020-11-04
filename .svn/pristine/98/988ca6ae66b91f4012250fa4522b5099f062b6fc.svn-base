//
//  TFReviseAddressViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/22.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFReviseAddressViewController.h"
#import "CityModel.h"
#import "AreaModel.h"
#import "StateModel.h"

#import "TFReceivingAddressViewController.h"
@interface TFReviseAddressViewController () <UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, assign)BOOL isDefault;

//选择省市区
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UIPickerView *pickerView;
@property (nonatomic, copy)NSString *state; //省
@property (nonatomic, copy)NSString *city; //市
@property (nonatomic, copy)NSString *area; //区
@property (nonatomic, copy)NSString *street; //街道

@property (nonatomic, strong)NSNumber *stateID;
@property (nonatomic, strong)NSNumber *cityID;
@property (nonatomic, strong)NSNumber *areaID;
@property (nonatomic, strong)NSNumber *streetID;

@property (nonatomic, strong)UILabel *addressLabel;
@property (nonatomic, copy)NSString *addressStr;
@property (nonatomic, strong)UITextView *detailTextView;


@end

@implementation TFReviseAddressViewController
{
    NSString *_oldname;
    NSString *_oldphone;
    NSString *_oldpostage;
    
    NSString *_oldAddress;
    NSString *_oldDetailAddress;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:@"修改收货地址"];
    
    [self dataInit];
    
    [self createUI];
    
}
- (void)createUI
{
    //使用 通知  监听键盘出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    CGFloat Margin_lr = ZOOM(62);
    CGFloat H_textField = ZOOM(112);
    CGFloat Margin_ud = ZOOM(45);
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar)];
    [self.view addSubview:_backgroundScrollView = scrollView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.view addGestureRecognizer:tap];
    
    for (int i = 0; i<2; i++) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(Margin_lr, ZOOM(10)+i*H_textField+i*Margin_ud, kScreenWidth-2*Margin_lr, H_textField)];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.font=[UIFont systemFontOfSize:ZOOM(48)];
        tf.tag = 200+i;
        tf.delegate = self;
        if (i == 0) {
            tf.text = self.model.consignee;
            tf.returnKeyType = UIReturnKeyNext;
            _oldname = [NSString stringWithFormat:@"%@",self.model.consignee];
            
        } else if (i == 1) {
            tf.text = self.model.phone;
            tf.returnKeyType = UIReturnKeyNext;
            _oldphone = [NSString stringWithFormat:@"%@",self.model.phone];
        }
//        else if (i == 2) {
//            tf.text = self.model.postcode;
//            tf.returnKeyType = UIReturnKeyDone;
//            _oldpostage = [NSString stringWithFormat:@"%@",self.model.postcode];
//        }
        [self.backgroundScrollView addSubview:tf];
    }
    
    UITextField *tf = (UITextField *)[self.view viewWithTag:201];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(Margin_lr,  tf.bottom+Margin_ud, kScreenWidth-2*Margin_lr, H_textField)];
    view.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
    view.layer.borderWidth = 1;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 2.5;
    [self.backgroundScrollView addSubview:view];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(15), 0, view.frame.size.width-2*ZOOM(15), view.frame.size.height)];
    self.addressLabel.text = self.addressStr;
    _oldAddress = [NSString stringWithFormat:@"%@",self.addressStr];
    self.addressLabel.font=[UIFont systemFontOfSize:ZOOM(48)];
    [view addSubview:self.addressLabel];
    self.addressLabel.adjustsFontSizeToFitWidth = YES;
    
    UIButton *bbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bbtn.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    [bbtn addTarget:self action:@selector(addressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:bbtn];
    
    self.detailTextView = [[UITextView alloc] initWithFrame:CGRectMake(Margin_lr,  view.bottom+ZOOM(45), view.frame.size.width, ZOOM(270))];
    self.detailTextView.text = self.model.address;
    _oldDetailAddress = [NSString stringWithFormat:@"%@",self.model.address];
    self.detailTextView.scrollEnabled = YES;
    self.detailTextView.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.detailTextView.layer.borderWidth = 1;
    self.detailTextView.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
    self.detailTextView.showsVerticalScrollIndicator = NO;
    self.detailTextView.layer.masksToBounds = YES;
    self.detailTextView.delegate = self;
    self.detailTextView.layer.cornerRadius = 2.5;
    [self.backgroundScrollView addSubview:self.detailTextView];
    
    CGFloat Margin_lr_btn = ZOOM(62);

//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(Margin_lr_btn,CGRectGetMaxY(self.detailTextView.frame)+150, self.view.frame.size.width-2*Margin_lr_btn, ZOOM(120));
//    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
//    [btn setTitle:@"保存" forState:UIControlStateNormal];
//    btn.titleLabel.font = kFont6px(32);
//    [btn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.backgroundScrollView addSubview:btn];
    
    self.backgroundScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.detailTextView.frame)+20);
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [self.navigationView addSubview:btn];
    [btn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_ROSERED forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    ESWeak(self, weakSelf);
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.navigationView).offset(10);
        make.right.equalTo(weakSelf.navigationView.mas_right).offset(-5);
        make.size.mas_equalTo(CGSizeMake(80, 44));
    }];
}

- (void)dataInit
{
    if ([self.model.is_default intValue] == 1) {
        self.isDefault = YES;
    } else {
        self.isDefault = NO;
    }
    
    
    NSArray *array = self.model.addressArray;
    if (array.count == 4) {
        self.addressStr = [NSString stringWithFormat:@"%@%@%@%@",array[0],array[1],array[2],array[3]];
    } else if (array.count == 3) {
        self.addressStr = [NSString stringWithFormat:@"%@%@%@",array[0],array[1],array[2]];
    } else if (array.count == 2) {
        self.addressStr = [NSString stringWithFormat:@"%@%@",array[0],array[1]];
    }
    
    self.stateID = self.model.province;
    self.cityID = self.model.city;
    self.streetID = self.model.street;
    self.areaID = self.model.area;
}

#pragma mark - 按钮
//选中省市区
- (void)addressBtnClick
{
    [self.view endEditing:YES];
    [self createPickView];
    
}
//保存
- (void)saveBtnClick:(UIButton *)sender
{
    UITextField *tf1 = (UITextField *)[self.view viewWithTag:200];
    UITextField *tf2 = (UITextField *)[self.view viewWithTag:201];
//    UITextField *tf3 = (UITextField *)[self.view viewWithTag:202];
    
    BOOL phoneBl = [self isString:tf2.text toCompString:@"1234567890"]; //检查手机号
//    BOOL postBl = [self isString:tf3.text toCompString:NUMBER]&&(tf3.text.length==6);
//    BOOL beginEdBl = self.isBeginEdit;             //检查是否输入详细地址
    BOOL adressBl = ![self.detailTextView.text isEqualToString:@""]; //输入了详细地址
    BOOL adressLengthBl = [MyMD5 asciiLengthOfString:self.detailTextView.text]<=50;
    BOOL nameBl = (![tf1.text isEqualToString:@""])&&([MyMD5 asciiLengthOfString:tf1.text]<=8);
    
    NSString *newaddress = [NSString stringWithFormat:@"%@%@%@%@",tf1.text,tf2.text,self.addressLabel.text,self.detailTextView.text];
    NSString *oldaddress = [NSString stringWithFormat:@"%@%@%@%@",_oldname,_oldphone,_oldAddress,_oldDetailAddress];
    
//    MyLog(@"newaddress = %@  oldaddress=%@",newaddress ,oldaddress);
    
    if ([TFPublicClass stringContainsEmoji:tf1.text] || [TFPublicClass stringContainsEmoji:tf2.text]||  [TFPublicClass stringContainsEmoji:self.detailTextView.text]) {
        [MBProgressHUD showError:@"不支持Emoji表情符号!"];
        return;
    }
    
    if (nameBl&&phoneBl&&adressBl&&self.addressStr!=nil&&adressLengthBl) {
        if(![oldaddress isEqualToString:newaddress])
        {
            [self httpReviseAddress];
        }else{
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"你还没有修改内容，暂不能提交" Controller:self];
        }
    } else if (!nameBl) {
        if([tf1.text isEqualToString:@""]||tf1.text.length==0){
            [MBProgressHUD showError:@"收货人姓名不能为空"];
        }else
            [MBProgressHUD showError:@"收货人姓名不得超过8个字符"];
    } else if (!phoneBl) {
        if([tf2.text isEqualToString:@""]||tf2.text.length==0){
            [MBProgressHUD showError:@"手机号码不能为空"];
        }else
            [MBProgressHUD showError:@"请输入正确的手机号!"];
    }
//    else if (!postBl) {
//        [MBProgressHUD showError:@"邮编为6位数字!"];
//    }
    else if (!adressBl) {
        [MBProgressHUD showError:@"请输入详细地址!"];
    } else if (!adressLengthBl) {
        [MBProgressHUD showError:@"详细地址大于50字符,保存失败"];
    } else if (self.addressStr ==nil) {
        [MBProgressHUD showError:@"请选择省-市-区"];
    } else {
        [MBProgressHUD showError:@"请正确输入!"];
    }
    
    
    /**
             [self httpReviseAddress];
     */

}
//完成按钮
- (void)barButton
{
    self.state = nil;
    self.city = nil;
    self.area = nil;
    self.street = nil;
    
    self.stateID = nil;
    self.cityID = nil;
    self.streetID = nil;
    self.areaID = nil;
    
    NSInteger com0Row = [self.pickerView selectedRowInComponent:0]; //获取0列点行
    NSInteger com1Row = [self.pickerView selectedRowInComponent:1];
    NSInteger com2Row = [self.pickerView selectedRowInComponent:2];
    NSInteger com3Row = [self.pickerView selectedRowInComponent:3];
    
    StateModel *model;
    CityModel *model1;
    AreaModel *model2;
    StreetModel *model3;
    
    if (self.dataArr.count>com0Row) {
        model = self.dataArr[com0Row];
        self.state = model.state;
        self.stateID = model.ID;
    }
    if (model.CITIES.count>com1Row) {
        model1 = model.CITIES[com1Row];
        self.city = model1.city;
        self.cityID = model1.ID;
    }
    if (model1.AREAS.count>com2Row) {
        model2 = model1.AREAS[com2Row];
        self.area = model2.area;
        self.areaID = model2.ID;
    }
    if (model2.STREETS.count>com3Row) {
        model3 = model2.STREETS[com3Row];
        self.street = model3.street;
        self.streetID = model3.ID;
    }
    
    //判断
    if (self.areaID == nil) {
        self.areaID = @0;
    }
    if (self.streetID == nil) {
        self.streetID = @0;
    }
    
    
    if (self.area!=nil&&self.street!=nil) {
        self.addressStr = [NSString stringWithFormat:@"%@-%@-%@-%@",self.state,self.city,self.area,self.street];
    } else if (self.street == nil&&self.area!=nil) {
        self.addressStr = [NSString stringWithFormat:@"%@-%@-%@",self.state,self.city,self.area];
    } else if (self.area == nil) {
        self.addressStr = [NSString stringWithFormat:@"%@-%@",self.state,self.city];
    }
    self.addressLabel.text = self.addressStr;
    [self.bgView removeFromSuperview];
}


- (void)createPickView
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.bgView.backgroundColor = RGBACOLOR_F(0.5,0.5,0.5,0.6);
    [window addSubview:self.bgView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bgView.frame.size.height-216, kScreenWidth, 216)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:bottomView];
    
    //创建PickView
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    self.pickerView = pickerView;
    [bottomView addSubview:self.pickerView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(barButton)];
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar.items = @[spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,item,spaceItem];
    [bottomView addSubview:toolBar];
}


#pragma mark - PickView相关
//返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

//返回某一列多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {           //第0列
        return [self.dataArr count];
    } else if (component == 1) {    //第1列
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];         //第0列选择的行
        if (self.dataArr.count>zeroRow) {
            StateModel *model = self.dataArr[zeroRow];
            return [model.cities count];
        }
    } else if (component == 2) {
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];         //第0列选中的行
        NSInteger firstRow = [self.pickerView selectedRowInComponent:1];        //第1列选中的行
        if (self.dataArr.count>zeroRow) {
            StateModel *model = self.dataArr[zeroRow];
            if (model.CITIES.count>firstRow) {
                CityModel *sModel = model.CITIES[firstRow];
                return [sModel.areas count];
            }
        }
    } else if (component == 3) {
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];         //第0列选中的行
        NSInteger firstRow = [self.pickerView selectedRowInComponent:1];        //第1列选中的行
        NSInteger twoRow = [self.pickerView selectedRowInComponent:2];          //第2列选中的行
        if (self.dataArr.count>zeroRow) {
            StateModel *sModel = self.dataArr[zeroRow];
            if (sModel.CITIES.count>firstRow) {
                CityModel *cModel = sModel.CITIES[firstRow];
                if (cModel.AREAS.count>twoRow) {
                    AreaModel *aModel = cModel.AREAS[twoRow];
                    return [aModel.streets count];
                }
            }
        }
    } else {
        return 0;
    }
    return 0;
}
//某一行显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        StateModel *model = self.dataArr[row];
        return model.state;
    } else if (component == 1) {
        //第0列选择的行
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];
        if (self.dataArr.count>zeroRow) {
            StateModel *model = self.dataArr[zeroRow];
            if (model.CITIES.count>row) {
                CityModel *sModel = model.CITIES[row];
                return sModel.city;
            }
        }
    } else if (component == 2) {
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];
        NSInteger firstRow = [self.pickerView selectedRowInComponent:1];
        
        if (self.dataArr.count>zeroRow) {
            StateModel *model = self.dataArr[zeroRow];
            if (model.CITIES.count>firstRow) {
                CityModel *sModel = model.CITIES[firstRow];
                if (sModel.AREAS.count>row) {
                    AreaModel *ssModel = sModel.AREAS[row];
                    return ssModel.area;
                }
            }
        }
    } else if (component == 3) {
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];         //第0列选中的行
        NSInteger firstRow = [self.pickerView selectedRowInComponent:1];        //第1列选中的行
        NSInteger twoRow = [self.pickerView selectedRowInComponent:2];          //第2列选中的行
        
        if (self.dataArr.count>zeroRow) {
            StateModel *model = self.dataArr[zeroRow];
            if (model.CITIES.count>firstRow) {
                CityModel *sModel = model.CITIES[firstRow];
                if (sModel.AREAS.count>twoRow) {
                    AreaModel *ssModel = sModel.AREAS[twoRow];
                    if (ssModel.STREETS.count>row) {
                        StreetModel *stModel = ssModel.STREETS[row];
                        return stModel.street;
                    }
                }
            }
        }
        
    }
    return nil;
}

//调整字体
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:ZOOM(50)]];
    }
    // Fill the label text here
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

//滑动事件
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //%ld = %ld",component,row);
    if (component == 0) { //第0列
        [self.pickerView selectRow:0 inComponent:1 animated:NO];
        [self.pickerView selectRow:0 inComponent:2 animated:NO];
        [self.pickerView selectRow:0 inComponent:3 animated:NO];
        [self.pickerView reloadComponent:1];
        [self.pickerView reloadComponent:2];
        [self.pickerView reloadComponent:3];
    } else if (component == 1) {
        [self.pickerView selectRow:0 inComponent:2 animated:NO];
        [self.pickerView selectRow:0 inComponent:3 animated:NO];
        [self.pickerView reloadComponent:2];
        [self.pickerView reloadComponent:3];
    } else if (component == 2) {
        [self.pickerView selectRow:0 inComponent:3 animated:NO];
        [self.pickerView reloadComponent:3];
    }
}

#pragma mark - 网路更改地址
- (void)httpReviseAddress
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    UITextField *tf1 = (UITextField *)[self.view viewWithTag:200];
    UITextField *tf2 = (UITextField *)[self.view viewWithTag:201];

    
    NSString *address = self.detailTextView.text; //详细地址
    NSString *consignee = tf1.text;               //收货人
    NSString *phone = tf2.text;                   //号码
    
    NSString *urlStr;
    if (!self.isDefault) {
        urlStr = [NSString stringWithFormat:@"%@address/update?token=%@&version=%@&id=%@&province=%@&city=%@&area=%@&street=%@&address=%@&consignee=%@&phone=%@",[NSObject baseURLStr],token,VERSION,self.model.ID,self.stateID,self.cityID,self.areaID,self.streetID,address,consignee,phone];
    } else {
        urlStr = [NSString stringWithFormat:@"%@address/update?token=%@&version=%@&id=%@&province=%@&city=%@&area=%@&street=%@&address=%@&consignee=%@&phone=%@&is_default=1",[NSObject baseURLStr],token,VERSION,self.model.ID,self.stateID,self.cityID,self.areaID,self.streetID,address,consignee,phone];
    }
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                [MBProgressHUD showSuccess:@"修改成功"];
                
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[TFReceivingAddressViewController class]]) {
                        
                        TFReceivingAddressViewController *tfRe = (TFReceivingAddressViewController *)controller;
                        [tfRe httpReceivingAddress];
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络请求失败,请检查网络设置"];
    }];
}

#pragma mark - 懒加载数据
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"areatbl" ofType:@"plist"]];
        for (NSDictionary *dic in array) { //存储模型
            StateModel *model = [[StateModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            model.ID = dic[@"id"];
            [_dataArr addObject:model];
        }
    }
    return _dataArr;
}

#pragma mark - textView相关
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (kDevice_Is_iPhone4) {
        [UIView animateWithDuration:0.8 animations:^{
            [self.backgroundScrollView setContentOffset:CGPointMake(0, 80)];
        }];
    } else if (kDevice_Is_iPhone5) {
        [UIView animateWithDuration:0.8 animations:^{
            [self.backgroundScrollView setContentOffset:CGPointMake(0, 0)];
        }];
    } else if (kDevice_Is_iPhone6) {
        [UIView animateWithDuration:0.8 animations:^{
            [self.backgroundScrollView setContentOffset:CGPointMake(0, 0)];
        }];
    } else if (kDevice_Is_iPhone6Plus) {
        [UIView animateWithDuration:0.8 animations:^{
            [self.backgroundScrollView setContentOffset:CGPointMake(0, 0)];
        }];
    }
    return YES;
}

#pragma mark - textField相关

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 201) {
        if (range.location>=11) {
            return NO;
        }
    } else if (textField.tag == 202) {
        if (range.location>=6) {
            return NO;
        }
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag < 202) {
        //注销当前文本为第一响应者 (此时无文本编辑，键盘会自动收起)
        //        [textField resignFirstResponder];
        //成为第一响应者，（让键盘出来）
        //        [textField becomeFirstResponder];
        UITextField *tf = (UITextField *)[self.view viewWithTag:textField.tag+1];

        //再让其成为第一响应者 , (此时自动弹出键盘)
        [tf becomeFirstResponder];
    } else if (textField.tag == 202){
        [self.view endEditing:YES];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.8 animations:^{
        [self.backgroundScrollView setContentOffset:CGPointMake(0, 0)];
    }];
    return YES;
}

#pragma mark - 键盘出现和消失
//键盘出现
- (void)keyboardWillShow:(NSNotification *)noti
{
    //键盘高度
    //    CGFloat keyboardHeight = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
}

//键盘消失,其他坐标归位
- (void)keyboardWillHide:(NSNotification *)noti
{
    [UIView animateWithDuration:0.8 animations:^{
        self.backgroundScrollView.contentOffset = CGPointMake(0, 0);
    }];
}


//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//    [UIView animateWithDuration:0.8 animations:^{
//        self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//    }];
//
//}
- (void)tapClick:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.8 animations:^{
        self.backgroundScrollView.contentOffset = CGPointMake(0, 0);
    }];
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
