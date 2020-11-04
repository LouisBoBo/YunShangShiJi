//
//  PartnerCardViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/3/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "PartnerCardViewController.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "KeyboardTool.h"
#import "NavgationbarView.h"
#import "PartnerCardCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "PartnerCardModel.h"
#import "UIScrollView+MJRefresh.h"
#import "MJRefresh.h"
#import "TFBackgroundView.h"


@interface PartnerCardViewController ()

@end

@implementation PartnerCardViewController
{
    UITableView *_MytableView;
    UIView *_searchview;
    UITextField *_textfield;
    NSMutableArray *_MydataArray;//数据源
    UIImageView *_searchimage;
    UIButton *_canclebtn; //取消按钮
    UIImageView *_imageview;
    
    NSInteger _currentPage;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatNavgationView];
    [self creatMainView];
    [self creatData];
}

-(void)creatNavgationView
{
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
//    [backbtn setImage:[UIImage imageNamed:@"返回按钮_高亮"] forState:UIControlStateHighlighted];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, headview.frame.size.width, 40);
    titlelable.center=CGPointMake(kScreenWidth/2, headview.frame.size.height/2+10);
    titlelable.text= @"我的卡号";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height-1, kScreenWidth, 1)];
    line.backgroundColor=lineGreyColor;
    [headview addSubview:line];
}


- (void)creatMainView
{
//    [self creatSearchView];
//    
//    _MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_searchview.frame), kScreenWidth, kScreenHeight-64-_searchview.frame.size.height+kUnderStatusBarStartY) style:UITableViewStylePlain];
   
    _MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar+kUnderStatusBarStartY) style:UITableViewStylePlain];
    _MytableView.delegate = self;
    _MytableView.dataSource = self;
    _MytableView.tableHeaderView = [self creatSearchView];
    [self.view addSubview:_MytableView];
    _MytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_MytableView registerNib:[UINib nibWithNibName:@"PartnerCardCell" bundle:nil] forCellReuseIdentifier:@"CardCell"];
    
    
    [_MytableView addHeaderWithCallback:^{
        
        if(_textfield.text ==nil)
        {
            _currentPage =1;
            [_MydataArray removeAllObjects];
            [self requestHttp:nil];
            [_MytableView headerEndRefreshing];
        }else{
            [_MytableView headerEndRefreshing];
        }
    }];
    
    [_MytableView addFooterWithCallback:^{
        if(_textfield.text ==nil)
        {
            _currentPage++;
            [self requestHttp:nil];
            [_MytableView footerEndRefreshing];
        }else{
            [_MytableView footerEndRefreshing];
        }
        
    }];

}

#pragma mark 搜索框
- (UIView*)creatSearchView
{
    _searchview = [[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, 80)];
    [self.view addSubview:_searchview];
    
    _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(60), 20, kScreenWidth-2*ZOOM(60), 40)];
    _imageview.userInteractionEnabled = YES;
    _imageview.image = [UIImage imageNamed:@"输入框"];
    [_searchview addSubview:_imageview];
    
    _searchimage = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(30), 10, 20, 20)];
    _searchimage.image = [UIImage imageNamed:@"magnifying-glass-searcher"];
    [_imageview addSubview:_searchimage];
    
    //搜索框
    _textfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_searchimage.frame), 5, _imageview.frame.size.width -CGRectGetWidth(_searchimage.frame)-2*ZOOM(30), 30)];
    _textfield.placeholder = @"输入卡号或ID搜索...";
    _textfield.delegate = self;
    _textfield.clearButtonMode = UITextFieldViewModeAlways;
    [_imageview addSubview:_textfield];
    
    KeyboardTool *tool = [KeyboardTool keyboardTool];
    tool.delegate = self;
    tool.frame=CGRectMake(0, tool.frame.origin.y, kScreenWidth, 40);
    _textfield.inputAccessoryView = tool;

    //取消按钮
    _canclebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _canclebtn.frame = CGRectMake(kScreenWidth-30-ZOOM(60), 25, 40, 30);
    [_canclebtn setTitle:@"取消" forState:UIControlStateNormal];
    _canclebtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
    _canclebtn.tintColor = kTextColor;
    [_canclebtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    _canclebtn.hidden = YES;
    [_searchview addSubview:_canclebtn];
    
    UILabel *labline = [[UILabel alloc]initWithFrame:CGRectMake(0, 79, kScreenWidth, 1)];
    labline.backgroundColor = kBackgroundColor;
    [_searchview addSubview:labline];
    
    return _searchview;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _MydataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _textfield.text = nil;
    [self.view endEditing:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"CardCell";
    PartnerCardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[PartnerCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
       
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.activationImage.hidden = YES;
    PartnerCardModel *model = _MydataArray[indexPath.row];
    
    if(model.partnercard !=nil || ![model.partnercard isEqualToString:@"<null>"])
    {
        cell.cardlab.text = [NSString stringWithFormat:@"卡号:%@",model.partnercard];
    }
    
    if(model.plaintext !=nil || ![model.plaintext isEqualToString:@"<null>"])
    {
        cell.activationlab.text = [NSString stringWithFormat:@"激活码:%@",model.plaintext];
    }

    
    if(model.is_use !=nil || ![model.is_use isEqualToString:@"<null>"])
    {
        
        if(model.is_use.intValue == 1)
        {
            cell.statuelab.text = [NSString stringWithFormat:@"状态:%@",@"已激活"];
            cell.activationImage.hidden = NO;
            cell.statuelab.textColor = tarbarrossred;
            
        }else{
            cell.statuelab.text = [NSString stringWithFormat:@"状态:%@",@"未激活"];
            cell.statuelab.textColor = kTextColor;
            
        }
        
        NSMutableAttributedString *noteStr ;
        if(cell.statuelab.text)
        {
            noteStr = [[NSMutableAttributedString alloc]initWithString:cell.statuelab.text];
        }
        
        
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
        
        [cell.statuelab setAttributedText:noteStr];
       
    }

    if(model.buyer_id !=nil || ![model.buyer_id isEqualToString:@"<null>"])
    {
        cell.activationID.text = [NSString stringWithFormat:@"激活ID:%@",model.buyer_id];
    }
    
    cell.statuelab.font = [UIFont systemFontOfSize:ZOOM(45)];
    cell.cardlab.font = [UIFont systemFontOfSize:ZOOM(45)];
    cell.activationlab.font = [UIFont systemFontOfSize:ZOOM(45)];
    cell.activationID.font = [UIFont systemFontOfSize:ZOOM(45)];
    
    cell.lableline.backgroundColor = kBackgroundColor;
    
    return cell;
}

- (void)creatData
{
    _currentPage =1;
    _MydataArray = [NSMutableArray array];
    
    [self requestHttp:nil];
}

- (void)requestHttp:(NSString*)searchstr
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    
    NSString *token = [user objectForKey:USER_TOKEN];
    
    NSString *url;
    if(searchstr !=nil)
    {
        url=[NSString stringWithFormat:@"%@superMan/cardList?version=%@&token=%@&seach=%@",[NSObject baseURLStr],VERSION,token,searchstr];
    }else{
        url=[NSString stringWithFormat:@"%@superMan/cardList?version=%@&token=%@&pager=%d",[NSObject baseURLStr],VERSION,token,(int)_currentPage];
    }
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            if ([[responseObject allKeys] count] == 0) {
                CGRect frame = CGRectMake(0, Height_NavBar, self.view.frame.size.width, self.view.frame.size.height-Height_NavBar);
                [self createBackgroundView:self.view  andTag:9999 andFrame:frame withImgge:nil andText:nil];
            } else {
                [self clearBackgroundView:self.view withTag:9999];
            }
            
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                if([responseObject[@"cardList"] count] == 0)
                {
                    [self creatnoDataView];
                }else{
                
                    [self disapearDataView];
                    
                    for(NSDictionary *dic in responseObject[@"cardList"])
                    {
                        if(dic !=nil)
                        {
                            PartnerCardModel *model = [[PartnerCardModel alloc]init];
                            model.partnercard = [NSString stringWithFormat:@"%@",dic[@"card_no"]];
                            model.buyer_id = [NSString stringWithFormat:@"%@",dic[@"buyer_id"]];
                            model.plaintext = [NSString stringWithFormat:@"%@",dic[@"plaintext"]];
                            model.is_use = [NSString stringWithFormat:@"%@",dic[@"is_use"]];
                            
                            
                            [_MydataArray addObject:model];
                            
                        }
                    }

                }
                
                [_MytableView reloadData];
            }
            
            else{
                
                CGRect frame = CGRectMake(0, Height_NavBar, self.view.frame.size.width, self.view.frame.size.height-Height_NavBar);
                [self createBackgroundView:self.view  andTag:9999 andFrame:frame withImgge:nil andText:nil];
                
            }
            
            [[Animation shareAnimation] stopAnimationAt:self.view];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        CGRect frame = CGRectMake(0, Height_NavBar, self.view.frame.size.width, self.view.frame.size.height-Height_NavBar);
        [self createBackgroundView:self.view  andTag:9999 andFrame:frame withImgge:nil andText:nil];
        
        //网络连接失败");
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }];

}

//键盘
- (void)keyboardTool:(KeyboardTool *)keyboardTool itemClick:(KeyboardToolItemType)itemType
{
    if (itemType == KeyboardToolItemTypePrevious) { // 上一个
        //----上一个----");
    } else if (itemType == KeyboardToolItemTypeNext) { // 下一个
        //----下一个----");
    } else { // 完成
        //----完成----");
        
        MyLog(@"_textfield.text = %@",_textfield.text);
        
        if([_textfield.text length] > 0)
        {
            [_MydataArray removeAllObjects];
            [self requestHttp:_textfield.text];
        }else{
            
            _searchimage.hidden = NO;
            _imageview.frame = CGRectMake(ZOOM(60), 20, kScreenWidth-2*ZOOM(60), 40);
            _textfield.frame =CGRectMake(ZOOM(30)+20, 5, kScreenWidth-2*ZOOM(80) -CGRectGetWidth(_searchimage.frame)-2*ZOOM(30), 30);
            _canclebtn.hidden = YES;
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"请输入搜索内容" Controller:self];
        }
        [self.view endEditing:YES];
    }
}


#pragma mark 取消搜索
- (void)cancelClick
{
    [_MydataArray removeAllObjects];
    _currentPage =1;
    [self requestHttp:nil];
    
    _searchimage.hidden = NO;
    _imageview.frame = CGRectMake(ZOOM(60), 20, kScreenWidth-2*ZOOM(60), 40);
    _textfield.frame =CGRectMake(ZOOM(30)+20, 5, kScreenWidth-2*ZOOM(80) -CGRectGetWidth(_searchimage.frame)-2*ZOOM(30), 30);
    _textfield.text = @"";
    _canclebtn.hidden = YES;
    [self.view endEditing:YES];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _searchimage.hidden = YES;
    _canclebtn.hidden = NO;
    _imageview.frame = CGRectMake(ZOOM(60), 20, kScreenWidth-2*ZOOM(60)-40, 40);
    _textfield.frame =CGRectMake(ZOOM(30), 5, kScreenWidth-2*ZOOM(80) -CGRectGetWidth(_searchimage.frame)-2*ZOOM(30)+20-40, 30);
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
       [self.view endEditing:YES];
}

- (void)creatnoDataView
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
    lable.text = @"没有结果";
    lable.tag = 787878;
    lable.font = [UIFont systemFontOfSize:ZOOM(47)];
    lable.textColor = kTextColor;
    lable.textAlignment = NSTextAlignmentCenter;
    [_MytableView addSubview:lable];
}
- (void)disapearDataView
{
    UILabel *lable = (UILabel*)[_MytableView viewWithTag:787878];
    [lable removeFromSuperview];
}
- (void)createBackgroundView:(UIView *)view andTag:(NSInteger)tag andFrame:(CGRect)frame withImgge:(UIImage *)img andText:(NSString *)text
{
    TFBackgroundView *tb = [[[NSBundle mainBundle] loadNibNamed:@"TFBackgroundView" owner:self options:nil] lastObject];
    tb.frame = frame;
    tb.tag = tag;
    //    tb.backgroundColor = [UIColor yellowColor];
    if (img != nil) {
        tb.headImageView.image = img;
    } else {
        tb.headImageView.image = [UIImage imageNamed:@"笑脸21"];
    }
    
    if (text != nil) {
        tb.textLabel.text = text;
    } else {
        tb.textLabel.text = @"亲,暂时没有相关数据哦";
    }
    for (UIView *vv in view.subviews) {
        if ([vv isKindOfClass:[TFBackgroundView class]] && tag == view.tag) {
            [view bringSubviewToFront:vv];
            return;
        }
    }
    if([view viewWithTag:9999]==nil){
        [view addSubview:tb];
        [view bringSubviewToFront:tb];
    }
}
- (void)clearBackgroundView:(UIView *)view withTag:(NSInteger)tag
{
    
    
    TFBackgroundView *tb = (TFBackgroundView *)[view viewWithTag:tag];
    if (tb!=nil) {
        [tb removeFromSuperview];
    }
}

- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
