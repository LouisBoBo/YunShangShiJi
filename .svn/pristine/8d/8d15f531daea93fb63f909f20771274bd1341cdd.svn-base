//
//  AllCommentsViewController.m
//  YunShangShiJi
//
//  Created by yssj on 15/10/14.
//  Copyright © 2015年 ios-1. All rights reserved.
//

/** |－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－-|
 *  |                   全部评论界面                         |
 *  |------------------------------------------------------|
 */
#import "AllCommentsViewController.h"
#import "GlobalTool.h"
#import "StarsView.h"
#import "commentsCell.h"

@interface AllCommentsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_tagArray;   //标签数组
}

@property(nonatomic,strong)UITableView *myTableView;

@end

@implementation AllCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tagArray = @[@"环境不错",@"味道不错",@"位置好找",@"服务态度好",@"上菜快"];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatNavgationView];
    [self creatMainView];
    
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
    _myTableView.backgroundColor=[UIColor whiteColor];
    [_myTableView registerNib:[UINib nibWithNibName:@"commentsCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _myTableView.tableFooterView=[[UIView alloc]init];
    _myTableView.dataSource=self;
    _myTableView.delegate=self;

    _myTableView.tableHeaderView=[self tableHeaderView];
    [self.view addSubview:_myTableView];
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
-(UIView *)tableHeaderView
{
    const  CGFloat tagLabelWidth = (kApplicationWidth-ZOOM(62)*2-10*2)/3;
    const  CGFloat tagLabelHeight = ZOOM(130);

    
    /**************  总体评价  **************/
    UILabel *starLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), ZOOM(50),[self getWidth:@"总体评价 : "], [self getHeight:@"总体评价 : "])];
    starLabel.text=@"总体评价 : ";
    starLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
    StarsView *starView=[[StarsView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(starLabel.frame)+ZOOM(32), starLabel.frame.origin.y, (starLabel.frame.size.height+3)*5, starLabel.frame.size.height)];
    [starView setScore:4];
    UILabel *starNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(starView.frame)+ZOOM(27), starLabel.frame.origin.y, 50, 21)];
    starNumLabel.text=@"4.0";
    starNumLabel.font=[UIFont systemFontOfSize:ZOOM(60)];
    starNumLabel.textColor=tarbarrossred;
    
    /**************  评价标签  **************/
    UIView *tagView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(starLabel.frame)+ZOOM(50), kApplicationWidth, tagLabelHeight*(_tagArray.count/3+1)+10*(_tagArray.count/3))];
//    tagView.backgroundColor=DRandomColor;
    for (int i=0; i<_tagArray.count; i++) {
        UILabel *tagLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62)+(10+tagLabelWidth)*(i%3),(10+tagLabelHeight)*(i/3), tagLabelWidth, tagLabelHeight)];
        tagLabel.text=_tagArray[i];
        tagLabel.textColor=tarbarrossred;
        tagLabel.textAlignment=NSTextAlignmentCenter;
        tagLabel.font=[UIFont systemFontOfSize:ZOOM(40)];
        tagLabel.layer.cornerRadius=3;
        tagLabel.layer.borderColor=tarbarrossred.CGColor;
        tagLabel.layer.borderWidth=1;
        [tagView addSubview:tagLabel];
    }

    UIView *tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, starLabel.frame.size.height+tagView.frame.size.height+ZOOM(50)*3)];
    tableHeaderView.backgroundColor=[UIColor whiteColor];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, tableHeaderView.frame.size.height-1, kApplicationWidth, 0.5)];
    line.backgroundColor=lineGreyColor;
    
    [tableHeaderView addSubview:line];
    [tableHeaderView addSubview:starLabel];
    [tableHeaderView addSubview:starNumLabel];
    [tableHeaderView addSubview:starView];
    [tableHeaderView addSubview:tagView];

    return tableHeaderView;
}
#pragma mark 发表话题
-(void)edit:(UIButton*)sender
{
    //发表话题");
    
    
    
}
- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    const CGFloat contenImgWidth = (kApplicationWidth-ZOOM(62)*2-10)/3;

    NSString *string =@"这家店很影响分扫房发生飞机撒发发发生的妇女理论是金额来看吗是浓了发生你垃圾哦近年来拉美了解哦哦就理解\n发烧发烧分散哦啊放松吗哦陌路了耐心了呢露出你的到了姥姥家了老大难浪费今年年初来成交额哦耶女决定问为奴森吗是的领导累了呢嗯啦了吗我了我冷漠为了买房三闾大夫吗发生吗企鹅品味哦吗";

    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];


    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(46)],NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, string.length)];
    
    CGRect rect = [attrString boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM(60), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  context:nil];
    

   
    //real   yy %f    %f",rect.size.height+ZOOM(50)*4+70+contenImgWidth,rect.size.height);
    return rect.size.height+ZOOM(50)*4+70+contenImgWidth;


}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    commentsCell *cell = [_myTableView dequeueReusableCellWithIdentifier:@"cell"];
  
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
