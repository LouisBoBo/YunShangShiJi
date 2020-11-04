//
//  BusinessDetailViewController.m
//  YunShangShiJi
//
//  Created by yssj on 15/10/16.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "BusinessDetailViewController.h"
#import "GlobalTool.h"
#import "StarsView.h"
#import "commentsCell.h"

#define kTableViewBackgroundColor [UIColor colorWithRed:246/255.0f green:246/255.0f blue:246/255.0f alpha:1]

@interface BusinessDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_tagArray;   //标签数组
}

@property(nonatomic,strong)UITableView *myTableView;


@end

@implementation BusinessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tagArray = @[@"环境不错",@"味道不错",@"位置好找",@"服务态度好",@"上菜快"];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatNavgationView];
    [self creatMainView];
    
}
/************  获得宽度 *************/
-(CGFloat)getWidth:(NSString *)string
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(48)]};
    CGSize textSize = [string boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    return textSize.width;
}
/************  获得高度 *************/
-(CGFloat)getHeight:(NSString *)string
{
    NSString * labelStr = string;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(48)]};
    CGSize textSize = [labelStr boundingRectWithSize:CGSizeMake(kApplicationWidth-ZOOM(62)*2, 1000) options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    
//    //textsize%f",textSize.height);
    return textSize.height;
}
-(void)creatNavgationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
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
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text= @"全部评价";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kApplicationWidth-25-ZOOM(50), headview.frame.size.height-35, 25, 25)];
    imageView.centerY = View_CenterY(headview);
    imageView.image = [UIImage imageNamed:@"个性签名"];
    
    [headview addSubview:imageView];
    UIButton *setting=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    setting.frame=CGRectMake(kApplicationWidth-50, 25, 50, 30);
    setting.centerY = View_CenterY(headview);
    [setting addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:setting];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height-1, kApplicationWidth, 1)];
    line.backgroundColor=lineGreyColor;
    [headview addSubview:line];
}

-(void)creatMainView
{
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kScreenHeight-Height_NavBar) style:UITableViewStylePlain];
    _myTableView.backgroundColor=kTableViewBackgroundColor;
    [_myTableView registerNib:[UINib nibWithNibName:@"commentsCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _myTableView.tableFooterView=[[UIView alloc]init];
    _myTableView.dataSource=self;
    _myTableView.delegate=self;
    
    _myTableView.tableHeaderView=[self tableHeaderView];
    [self.view addSubview:_myTableView];
}

-(UIView *)spaceViewWithYpoint:(CGFloat)yPoint
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, yPoint, kApplicationWidth, ZOOM(60))];
    view.backgroundColor=kTableViewBackgroundColor;
    return view;
    
}

-(UIView *)creatAddressViewWithYpoint:(CGFloat)yPoint
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, yPoint, kApplicationWidth, 300)];
    view.backgroundColor=DRandomColor;
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), 0, 300,21+ZOOM(48)+ZOOM(38))];
    titleLabel.text = [NSString stringWithFormat:@"百合SPA水会"];
    titleLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
    [view addSubview:titleLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(62),CGRectGetMaxY(titleLabel.frame) , kApplicationWidth-ZOOM(62), 1)];
    line.backgroundColor=lineGreyColor;
    [view addSubview:line];
    
    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    phoneBtn.frame=CGRectMake(kApplicationWidth-50-ZOOM(36), line.frame.origin.y+ZOOM(45), 50, 50);
    phoneBtn.backgroundColor=DRandomColor;
    [view addSubview:phoneBtn];
    
    UIImageView *addressImg = [[UIImageView alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x,phoneBtn.frame.origin.y+(phoneBtn.frame.size.height-50)/2, 30, 50)];
    addressImg.image=[UIImage imageNamed:@""];
    addressImg.backgroundColor=DRandomColor;
    [view addSubview:addressImg];
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(addressImg.frame)+ZOOM(38) , phoneBtn.frame.origin.y, kApplicationWidth-CGRectGetMaxX(addressImg.frame)-ZOOM(38)-phoneBtn.frame.size.width-ZOOM(36), phoneBtn.frame.size.height/2)];
    addressLabel.text=[NSString stringWithFormat:@"南山区海岸城广场五层535商铺"];
    addressLabel.textColor=RGBCOLOR_I(102, 102, 102);
    addressLabel.font=[UIFont systemFontOfSize:ZOOM(40)];
    [view addSubview:addressLabel];
    
    UILabel *distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(addressLabel.frame.origin.x, CGRectGetMaxY(phoneBtn.frame)-21, 100, 21)];
    distanceLabel.text=[NSString stringWithFormat:@"121km"];
    distanceLabel.textColor=RGBCOLOR_I(102, 102, 102);
    distanceLabel.font=[UIFont systemFontOfSize:ZOOM(40)];
    [view addSubview:distanceLabel];
    
    StarsView *starView=[[StarsView alloc]initWithFrame:CGRectMake(addressImg.frame.origin.x, CGRectGetMaxY(distanceLabel.frame)+ZOOM(66), (21+3)*5, 21)];
    [starView setScore:4];
    [view addSubview:starView];
    
    UILabel *starNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(starView.frame)+ZOOM(27), starView.frame.origin.y, 100, 21)];
    starNumLabel.text=@"4.0分";
    starNumLabel.font=[UIFont systemFontOfSize:ZOOM(55)];
    starNumLabel.textColor=tarbarrossred;
    [view addSubview:starNumLabel];
    
    view.frame=CGRectMake(0, yPoint, kApplicationWidth, titleLabel.frame.size.height+phoneBtn.frame.size.height+starView.frame.size.height+ZOOM(66)+ZOOM(87)+ZOOM(45));
    return view;
}
-(UIView *)buttonViewWithYpoint:(CGFloat)Ypoint
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [view addSubview:[self spaceViewWithYpoint:0]];
    
    UILabel *titileLabelOne = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), ZOOM(60)+ZOOM(42), 300, 21)];
    titileLabelOne.font=[UIFont systemFontOfSize:ZOOM(48)];
    titileLabelOne.text=[NSString stringWithFormat:@"会员折扣"];
    [view addSubview:titileLabelOne];
    
    UIButton *btnOne = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnOne.frame=CGRectMake(ZOOM(80),CGRectGetMaxY(titileLabelOne.frame)+ZOOM(42) , kApplicationWidth-ZOOM(80)*2, 50);
    [btnOne setTitle:@"会员专享8.8折" forState:UIControlStateNormal];
    [btnOne setTintColor:[UIColor whiteColor]];
    [btnOne setBackgroundColor:tarbarrossred];
    btnOne.titleLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
    [view addSubview:btnOne];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(btnOne.frame)+ZOOM(90), kApplicationWidth, 1)];
    line.backgroundColor=lineGreyColor;
    [view addSubview:line];
    
    UILabel *titileLabelTwo = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62),line.frame.origin.y+ ZOOM(42), 300, 21)];
    titileLabelTwo.font=[UIFont systemFontOfSize:ZOOM(48)];
    titileLabelTwo.text=[NSString stringWithFormat:@"会员独享服务"];
    [view addSubview:titileLabelTwo];
    UIButton *btnTwo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnTwo.frame=CGRectMake(ZOOM(80),CGRectGetMaxY(titileLabelTwo.frame)+ZOOM(42) , kApplicationWidth-ZOOM(80)*2, 50);
    [btnTwo setTitle:@"会员独享果汁一杯" forState:UIControlStateNormal];
    [btnTwo setTintColor:[UIColor whiteColor]];
    [btnTwo setBackgroundColor:tarbarrossred];
    btnTwo.titleLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
    [view addSubview:btnTwo];
    
    [view addSubview:[self spaceViewWithYpoint:CGRectGetMaxY(btnTwo.frame)+ZOOM(90)]];

    view.frame=CGRectMake(0, Ypoint, kApplicationWidth, ZOOM(60)*2+ZOOM(42)*4+(titileLabelOne.frame.size.height+btnOne.frame.size.height+ZOOM(90))*2);
    return view;
}
-(UIView *)tableHeaderView
{
    const CGFloat headImgHeight = 180;
    UIView *tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 600)];
    tableHeaderView.backgroundColor=[UIColor whiteColor];
    
    UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, headImgHeight)];
    headImg.backgroundColor = DRandomColor;
    
    
    UIView *addressView=[self creatAddressViewWithYpoint:headImgHeight];
    UIView *btnView = [self buttonViewWithYpoint:CGRectGetMaxY(addressView.frame)];

    [tableHeaderView addSubview:headImg];
    [tableHeaderView addSubview:addressView];
    [tableHeaderView addSubview:btnView];
    
    tableHeaderView.frame=CGRectMake(0, 0, kApplicationWidth, headImgHeight+addressView.frame.size.height+btnView.frame.size.height);
    return tableHeaderView;
}
#pragma mark - 分享话题
-(void)edit:(UIButton*)sender
{
    //分享话题");
    
    
    
}
- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    const CGFloat contenImgWidth = (kApplicationWidth-ZOOM(62)*2-10)/3;
    
    NSString *string =@"这家店很影响分扫房发生飞机撒发发发生的妇女理论是金额来看吗是浓了发生你垃圾哦近年来拉美了解哦哦就理解\n发烧发烧分散哦啊放松吗哦陌路了耐心了呢露出你的到了姥姥家了老大难浪费今年年初来成交额哦耶女决定问为奴森吗是的领导累了呢嗯啦了吗我了我冷漠为了买房三闾大夫吗发生吗企鹅品味哦吗";
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    
    
    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(46)],NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, string.length)];
    
    CGRect rect = [attrString boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM(60), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  context:nil];
    
    
    
    return rect.size.height+ZOOM(50)*4+70+contenImgWidth;
    
    
}
//-(UIView *)sectionView:(NSString *)string
//{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 50)];
//    view.backgroundColor=[UIColor whiteColor];
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), ZOOM(48), 300, view.frame.size.height-ZOOM(48)-ZOOM(38))];
//    titleLabel.text = [NSString stringWithFormat:@"%@",string];
//    [view addSubview:titleLabel];
//    
//    return view;
//    
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    view.backgroundColor=[UIColor whiteColor];

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62),0, 300,21+ZOOM(48)+ZOOM(38))];
    titleLabel.text = [NSString stringWithFormat:@"用户评价"];
    titleLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
    [view addSubview:titleLabel];
    
    view.frame=CGRectMake(0, 0, kApplicationWidth, 21+ZOOM(38)+ZOOM(48));
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(62), view.frame.size.height-1, kApplicationWidth, 1)];
    line.backgroundColor=lineGreyColor;
    [view addSubview:line];
    return view;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ZOOM(48)+ZOOM(38)+21;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    commentsCell *cell = [_myTableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UIEdgeInsets edge=cell.separatorInset;
    cell.separatorInset = UIEdgeInsetsMake(edge.top,ZOOM(62),edge.bottom,edge.right);
    [cell.starView setScore:3];
    return cell;
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
