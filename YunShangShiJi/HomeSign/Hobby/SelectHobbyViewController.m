//
//  SelectHobbyViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/26.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "SelectHobbyViewController.h"
#import "FJWaterfallFlowLayout.h"
#import "ImageCollectionViewCell.h"
#import "LabelCollectionViewCell.h"
#import "HobbyCollectionHeadView.h"
#import "HobbyCollectionFootView.h"
#import "TFBackgroundView.h"
#import "FinishTaskPopview.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "TaskSignModel.h"
#import "AFNetworking.h"
#import "KeyboardTool.h"
#import "GlobalTool.h"
#import "HobbyModel.h"
#import "MyMD5.h"
#import "MakeMoneyViewController.h"
@interface SelectHobbyViewController ()<FJWaterfallFlowLayoutDelegate,KeyboardToolDelegate>

@end

@implementation SelectHobbyViewController
{
    KeyboardTool *tool;            //键盘
    UITextField *_heighttextfild;  //身高
    UITextField *_weighttextfild;  //体重
    CGFloat     offset;            //键盘偏移量
    CGRect _keyboardFrame;         //键盘高度
    int currentSection;            //当前section

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatUI];
    
    [self creatData];

    //注册键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark *********************UI界面***********************
- (void)creatUI
{
    [self creatNavagationbar];
    
    [self creatCollectionView];
}

- (void)creatNavagationbar
{
    //导航条
    self.tabheadview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    [self.view addSubview:self.tabheadview];
    self.tabheadview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(self.tabheadview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.tabheadview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, self.tabheadview.frame.size.height/2+10);
    titlelable.text=@"我的喜好";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [self.tabheadview addSubview:titlelable];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];

}
- (void)creatCollectionView
{
    FJWaterfallFlowLayout *fjWaterfallFlowLayout = [[FJWaterfallFlowLayout alloc] init];
    fjWaterfallFlowLayout.itemSpacing = 15;
    fjWaterfallFlowLayout.lineSpacing = 15;
    fjWaterfallFlowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    fjWaterfallFlowLayout.colCount = 3;
    fjWaterfallFlowLayout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) collectionViewLayout:fjWaterfallFlowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"LabelCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HobbyCollectionHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HobbyCollectionFootView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sectionFooter"];
}

#pragma mark collectionViewDatasouce
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.viewModel.titleArry.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if([self.viewModel.dataArray count] > 0)
    {
        return [self.viewModel.dataArray[section] count];
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        HobbyModel *model = self.viewModel.dataArray[indexPath.section][indexPath.item];
        
        ImageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        kWeakSelf(cell);
        cell.clickBlock = ^(){
            
            model.is_Select = !model.is_Select;
            
            if(model.is_Select)
            {
                weakcell.selectmark.image = [UIImage imageNamed:@"wodexihao_fengge_icon_xuanzhong"];
            }else{
                weakcell.selectmark.image = [UIImage imageNamed:@"wodexihao_fengge_icon_weixuanzhong"];
            }
        };
        [cell setCellData:model];
        return cell;
    }else{
        HobbyModel *model = self.viewModel.dataArray[indexPath.section][indexPath.item];
        
        LabelCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
        kWeakSelf(cell);
        cell.clickBlock = ^(){
            
            if(indexPath.section == 0)
            {
                model.is_SaleMark = !model.is_SaleMark;
            }else{
                for(int i =0; i<[self.viewModel.dataArray[indexPath.section] count]; i++)
                {
                    HobbyModel *lastmodel = self.viewModel.dataArray[indexPath.section][i];
                    if(lastmodel.is_SaleMark == YES)
                    {
                        if(i == indexPath.item)
                        {
                            continue;
                        }else{
                            lastmodel.is_SaleMark = NO;
                            [self reloadCell:i];
                            break;
                        }
                    }
                }
                
                model.is_SaleMark = !model.is_SaleMark;
            }
            
            if(model.is_SaleMark)
            {
                [weakcell.selectbtn setBackgroundImage:[UIImage imageNamed:@"wodexihao_xuanzhong"] forState:UIControlStateNormal];
                [weakcell.selectbtn setTintColor:tarbarrossred];
            }else{
                [weakcell.selectbtn setBackgroundImage:[UIImage imageNamed:@"wodexihao_moren"] forState:UIControlStateNormal];
                [weakcell.selectbtn setTintColor:RGBCOLOR_I(168, 168,168)];
            }
        };
        [cell setCellData:model];
        return cell;
    }
    
    return nil;
}

//刷新cell
- (void)reloadCell:(int)index
{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:2];
    NSArray *pathArr = @[indexPath];
    
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadItemsAtIndexPaths:pathArr];
    }];
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HobbyCollectionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader" forIndexPath:indexPath];
        
        headerView.title.text = [NSString stringWithFormat:@"%@",self.viewModel.titleArry[indexPath.section]];
        headerView.title.font = [UIFont systemFontOfSize:ZOOM6(30)];
        headerView.title.textColor = RGBCOLOR_I(62, 62, 62);
        headerView.title.numberOfLines = 0;

        return headerView;
    }
    else{
        __weak typeof (self) weakself = self;
        self.footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sectionFooter" forIndexPath:indexPath];
        
        self.footerView.heightTextFild.delegate = self;
        self.footerView.weightTextFild.delegate = self;
        if(self.is_change)
        {
            if(self.footerView.heightTextFild.text.length == 0 && self.footerView.weightTextFild.text.length == 0)
            {
                self.footerView.heightTextFild.text = self.viewModel.height;
                self.footerView.weightTextFild.text = self.viewModel.weight;
                
                _heighttextfild = self.footerView.heightTextFild;
                _weighttextfild = self.footerView.weightTextFild;
            }else if (_heighttextfild.text.length>0)
            {
                self.footerView.heightTextFild.text = _heighttextfild.text;
            }else if (_weighttextfild.text.length>0){
                self.footerView.weightTextFild.text = _weighttextfild.text;
            }
        }else{
            if (_heighttextfild.text.length>0)
            {
                self.footerView.heightTextFild.text = _heighttextfild.text;
            }
            if (_weighttextfild.text.length>0){
                self.footerView.weightTextFild.text = _weighttextfild.text;
            }
        }

        [self.footerView refreshData];
        
        self.footerView.cancleBlock = ^(){
            [weakself back];
        };
        
        self.footerView.okBlock = ^(){
            
            self.viewModel.dataArray.count>0?[weakself submit]:nil;
        };
        return self.footerView;
    }
    
    return nil;
}

#pragma mark FJWaterfallFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FJWaterfallFlowLayout*)collectionViewLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath
{
    CGFloat Heigh = 0;
    
    if(indexPath.section == 1)
    {
        Heigh = ceil((kScreenWidth - 60)/3);
    }else{
        Heigh = ceil(ZOOM6(60));
    }
    return Heigh;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(FJWaterfallFlowLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section==0)
    {
        return CGSizeMake(CGRectGetWidth(self.view.frame) , ceil(ZOOM6(220)));
    }
    return CGSizeMake(CGRectGetWidth(self.view.frame) , ceil(ZOOM6(80)));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(FJWaterfallFlowLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if(section == 2)
    {
        return CGSizeMake(CGRectGetWidth(self.view.frame) , 250);
    }else{
        return CGSizeMake(CGRectGetWidth(self.view.frame) , 0);
    }
    
    return CGSizeMake(CGRectGetWidth(self.view.frame) , 0);
}

- (UIView *)creatSectionFirstHeadView
{
    return nil;
}

- (UIView *)creatSectionThreeHeadView
{
    return nil;
}
#pragma mark *********************数据***********************
- (void)creatData
{
    self.viewModel = [[WaterFallFlowViewModel alloc] init];
    
    [self.viewModel getData:^{
        
        [self.collectionView reloadData];
        
    } Fail:^{
        [MBProgressHUD show:@"数据获取失败" icon:nil view:self.view];
        [self.collectionView reloadData];
    }];

}

- (void)getChangeData
{
    self.beforeChangeStrData = [[NSMutableString alloc]init];
    
    for(int k=0 ; k<[self.viewModel.dataArray count]; k++)
    {
        for(int i =0;i<[self.viewModel.dataArray[k] count];i++)
        {
            HobbyModel *model = self.viewModel.dataArray[k][i];
            if(k == 0)
            {
                if(model.is_SaleMark)
                {
                    [self.beforeChangeStrData appendString:model.ID];
                    [self.beforeChangeStrData appendString:@","];
                }
                
            }else if (k == 1)
            {
                if(model.is_Select)
                {
                    [self.beforeChangeStrData appendString:model.ID];
                    [self.beforeChangeStrData appendString:@","];
                }
            }else if (k == 2)
            {
                if(model.is_SaleMark)
                {
                    [self.beforeChangeStrData appendString:model.ID];
                    [self.beforeChangeStrData appendString:@","];
                }
            }
        }
        
    }
}

#pragma mark 提交喜好网络请求
-(void)requestHTTP
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    manager.requestSerializer.timeoutInterval = 300;
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&hobby=%@",[NSObject baseURLStr],VERSION,token,self.afterChangeStrData];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        if (responseObject!=nil) {
            NSString *message=responseObject[@"message"];
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                [self taskPopView];
                
                //保存当前用户登录/注册信息
                NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                [userdefaul setObject:responseObject[@"userinfo"][@"hobby"] forKey:USER_HOBBY];
            }
            else{
                
                [MBProgressHUD hideHUDForView:self.view];
                [MBProgressHUD show:message icon:nil view:self.view];
            }
        }
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD show:@"网络连接失败，请检查网络设置" icon:nil view:self.view];
        
    }];
    
}

#pragma mark *******************键盘处理***********************
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag == 88888)
    {
        _heighttextfild = textField;
    }else{
        _weighttextfild = textField;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

//弹出键盘
- (void)keyboardWillShow:(NSNotification *)notification {
    
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    NSDictionary *userInfo = [notification userInfo];
    _keyboardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
//    CGPoint rootViewPoint = [[textfild superview] convertPoint:textfild.frame.origin toView:self.view];
    
//    CGFloat height =rootViewPoint.y -_keyboardFrame.origin.y;
//    
//    CGFloat moveheigh = self.collectionView.contentOffset.y;
    
    [UIView animateWithDuration:animationDuration
                              animations:^{
                   
        [self performSelector:@selector(offset) withObject:nil afterDelay:0.05];
    }];
}
- (void)offset
{
     self.collectionView.contentOffset = CGPointMake(0, self.collectionView.contentSize.height - self.collectionView.frame.size.height + _keyboardFrame.size.height-80);
}
//收起键盘
- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         //滑动到最底部
                         [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height - self.collectionView.frame.size.height)];

    }];
}

#pragma mark ******************提交用户选择信息********************
- (void)submit
{
    
    currentSection = 100;
    if(![self getSaleResult:0])//消费习惯
    {
        [self setTaskPopMindView:Task_submitHobby Value:nil Title:@"亲爱的你还没选择消费习惯哦" Rewardvalue:nil Rewardnum:0 RewarType:nil];
        currentSection = 0;

        return;
    }
    
    if(![self getSaleResult:1])//风格
    {
        [self setTaskPopMindView:Task_submitHobby Value:nil Title:@"亲爱的你还没选择喜爱风格哦" Rewardvalue:nil Rewardnum:0 RewarType:nil];
        currentSection = 1;
        
        return;
    }

    if(![self getSaleResult:2])//年龄
    {
        [self setTaskPopMindView:Task_submitHobby Value:nil Title:@"亲爱的你还没选择你的年龄段哦" Rewardvalue:nil Rewardnum:0 RewarType:nil];
        return;
    }

    if([self getHeighttResult] == 0)//身高
    {
        [self setTaskPopMindView:Task_submitHobby Value:nil Title:@"亲爱的你还没填写你的身高哦" Rewardvalue:nil Rewardnum:0 RewarType:nil];
        return;
    }else if([self getHeighttResult] == 2){
        [self setTaskPopMindView:Task_submitHobby Value:nil Title:@"请输入正确的身高体重！" Rewardvalue:nil Rewardnum:0 RewarType:nil];
        return;
    }
    
    if([self getWeightResult] == 0)//体重
    {
        [self setTaskPopMindView:Task_submitHobby Value:nil Title:@"亲爱的你还没填写你的体重哦" Rewardvalue:nil Rewardnum:0 RewarType:nil];
        return;
    }else if([self getWeightResult] == 2){
        [self setTaskPopMindView:Task_submitHobby Value:nil Title:@"请输入正确的身高体重！" Rewardvalue:nil Rewardnum:0 RewarType:nil];
        return;
    }

    [self submitInformation];
}

- (void)submitInformation
{
    [self.SelectSaleArray removeAllObjects];
    [self.SelectStyleArry removeAllObjects];
    [self.SelectAgesArray removeAllObjects];
    
    self.afterChangeStrData = [[NSMutableString alloc]init];
    
    for(int k=0 ; k<[self.viewModel.dataArray count]; k++)
    {
        for(int i =0;i<[self.viewModel.dataArray[k] count];i++)
        {
            HobbyModel *model = self.viewModel.dataArray[k][i];
            if(k == 0)
            {
                if(model.is_SaleMark)
                {
                    [self.SelectSaleArray addObject:model.title];
                    [self.afterChangeStrData appendString:model.ID];
                    [self.afterChangeStrData appendString:@","];
                }
                
            }else if (k == 1)
            {
                if(model.is_Select)
                {
                    [self.SelectStyleArry addObject:model.title];
                    [self.afterChangeStrData appendString:model.ID];
                    [self.afterChangeStrData appendString:@","];
                }
            }else if (k == 2)
            {
                if(model.is_SaleMark)
                {
                    [self.SelectAgesArray addObject:model.title];
                    [self.afterChangeStrData appendString:model.ID];
                    [self.afterChangeStrData appendString:@","];
                }
            }
        }

    }
    
    //身高体重
    NSString *heighweigh = [NSString stringWithFormat:@"_%@,%@",_heighttextfild.text,_weighttextfild.text];
    if(self.afterChangeStrData.length>0)
    {
        NSString *cccc = [self.afterChangeStrData substringToIndex:[self.afterChangeStrData length] - 1];
        self.afterChangeStrData = [NSMutableString stringWithString:cccc];
    }
    [self.afterChangeStrData appendString:heighweigh];
    
    if(self.is_change)//判断是否有修改过信息如果没有提示用户修改
    {
        NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
        NSString *hobby = [userdefaul objectForKey:USER_HOBBY];

        if([hobby isEqualToString:self.afterChangeStrData])
        {
            [MBProgressHUD show:@"亲，你还没有修改信息" icon:nil view:self.view];
            return;
        }
    }
    
    [self requestHTTP];//提交喜好到服务器
}
#pragma mark 提示弹框
- (void)taskPopView
{
    if(_is_change)//设置
    {
        //保存当前用户登录/注册信息
        NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
        NSString *hobby = [userdefaul objectForKey:USER_HOBBY];
        if(hobby == nil)//第一次设置
        {
            [TaskSignModel getTaskHttp:self.index Day:self.day Success:^(id data) {
                TaskSignModel *model = data;
                if(model.status == 1)
                {
                    [self setTaskPopMindView:Task_setHobbySuccess Value:nil Title:nil Rewardvalue:self.rewardValue Rewardnum:0 RewarType:self.rewardType];
                }
            }];

        }else{
            [MBProgressHUD show:@"喜好设置修改成功~" icon:nil view:self.view];
            [self performSelector:@selector(back) withObject:nil afterDelay:1];
        }
        
    }else{//任务
        
        if(self.submitHobbySuccess)
        {
            self.submitHobbySuccess();
        }
       
        [self back];
    }
}

- (void)setTaskPopMindView:(TaskPopType)type Value:(NSString*)value Title:(NSString*)title Rewardvalue:(NSString*)rewardValue Rewardnum:(int)num RewarType:(NSString*)rewardtype
{
    FinishTaskPopview* bonusview = [[FinishTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) TaskType:type TaskValue:value Title:title RewardValue:rewardValue RewardNumber:num Rewardtype:rewardtype];
    
    __weak FinishTaskPopview *view = bonusview;
    view.tapHideMindBlock = ^{
        [view remindViewHiden];
        if(type == Task_setHobbySuccess)
        {
            [self back];
        }
    };
    
    view.leftHideMindBlock = ^(NSString*title){
        MyLog(@"左");
        if(currentSection == 0)
        {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:currentSection]
                                    atScrollPosition:UICollectionViewScrollPositionBottom
                                            animated:YES];
        }else if (currentSection == 1)
        {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:[self.viewModel.dataArray[0] count]-1 inSection:0]
                                        atScrollPosition:UICollectionViewScrollPositionTop
                                                animated:YES];
        }
        if(type == Task_setHobbySuccess)//一键做下个任务
        {
            [[NextTaskManager taskManager] bakeToMakemoneyVC];
        }
    };
    
    [self.view addSubview:bonusview];
}

- (BOOL)getSaleResult:(int)index
{
    BOOL result = false;
    
    for(int i =0;i<[self.viewModel.dataArray[index] count];i++)
    {
        HobbyModel *model = self.viewModel.dataArray[index][i];
        if(model.is_SaleMark && index !=1)
        {
            result = YES;
            break;
        }
        
        if(model.is_Select && index ==1)
        {
            result = YES;
            break;
        }
    }

    return result;
}

- (int)getHeighttResult
{
    int result = 0; //0为空 1范围之内 2范围之外
    if(_heighttextfild.text.length > 0)
    {
        result = 1;
        CGFloat heigh = [_heighttextfild.text floatValue];
        if(heigh < 100 || heigh > 200)
        {
            result = 2;
        }
    }
    
    return result;
}

- (int)getWeightResult
{
    int result = 0; //0为空 1范围之内 2范围之外
    if(_weighttextfild.text.length > 0)
    {
        result = 1;
        CGFloat heigh = [_weighttextfild.text floatValue];
        if(heigh < 30 || heigh > 100)
        {
            result = 2;
        }
    }
    
    return result;
}


- (void)back
{
    if([self.comefrom isEqualToString:@"推荐"])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:NSClassFromString(@"MakeMoneyViewController")]) {
                [self.navigationController popToViewController:controller animated:YES];
                return;
            }
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSMutableArray*)SelectSaleArray
{
    if(_SelectSaleArray == nil)
    {
        _SelectSaleArray = [NSMutableArray array];
    }
    
    return _SelectSaleArray;
}

- (NSMutableArray*)SelectStyleArry
{
    if(_SelectStyleArry == nil)
    {
        _SelectStyleArry = [NSMutableArray array];
    }
    
    return _SelectStyleArry;
}

- (NSMutableArray*)SelectAgesArray
{
    if(_SelectAgesArray == nil)
    {
        _SelectAgesArray = [NSMutableArray array];
    }
    
    return _SelectAgesArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
