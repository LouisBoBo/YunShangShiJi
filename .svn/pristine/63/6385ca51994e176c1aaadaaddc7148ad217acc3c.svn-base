//
//  TFCircleSubViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/11/18.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFCircleSubViewController.h"
#import "LoginViewController.h"
#import "ForumModel.h"
#import "SmileView.h"
#import "AppDelegate.h"

#import "FamilyTableViewCell.h"
#import "TimeLineTableViewCell.h"
#import "CircleTableViewCell.h"

#import "PostViewController.h"
#import "InvitationViewController.h"

#import "TFLoginView.h"

#define contentWidth (kScreenWidth-50-ZOOM(62)*2-ZOOM(35))


@interface TFCircleSubViewController () <UITableViewDataSource, UITableViewDelegate, AddcircleDelegate>

//@property (nonatomic, assign)int currPage;
@property (nonatomic, assign)int countPage;

@property (nonatomic, strong)UIView *smileView;

@end

@implementation TFCircleSubViewController
{
    int _index;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = COLOR_RANDOM;
    [self createUI];
    
    [self httpGetData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submitSuccess:) name:@"submitSuccess" object:nil];
}

- (void)findBtnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(smileViewSelect:)]) {
        [self.delegate smileViewSelect:self.CURR_STATUS];
    }
}

-(void)creatSTATUS_MY_SmileView
{
    
    self.smileView = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 300, 200)];
    self.smileView.center = CGPointMake(self.tableView.frame.size.width/2.0, self.tableView.frame.size.height/2.0);
        
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake((300-64)/2.0, 0, 64, 56)];
    iv.image = [UIImage imageNamed:@"表情"];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    [self.smileView addSubview:iv];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iv.frame)+20, 300, 30)];
    label.text = @"O(n_n)O~亲~";
    label.textColor = RGBCOLOR_I(220,220,220);
    label.textAlignment = NSTextAlignmentCenter;
    [self.smileView addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), 300, 30)];
    label2.text = @"您还没有加入任何圈子";
    label2.textColor = RGBCOLOR_I(220,220,220);
    label2.textAlignment = NSTextAlignmentCenter;
    [self.smileView addSubview:label2];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, CGRectGetHeight(self.smileView.frame)-40, 260, 40);
    btn.layer.borderColor = [[UIColor blackColor] CGColor];
    btn.layer.borderWidth = 1;
    btn.tag = 100;
    [btn addTarget:self action:@selector(findBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"查看所有圈子" forState:UIControlStateNormal];
    
    [self.smileView addSubview:btn];
    
    [self.tableView addSubview:self.smileView];

}
- (void)httpGetData
{
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];

    if (self.CURR_STATUS == CIRCLE_STATUS_MY) {
        if (token!=nil) {
            url=[NSString stringWithFormat:@"%@circle/queryUserCircleList?version=%@&token=%@&pager.curPage=%d",[NSObject baseURLStr],VERSION,token,self.currPage];
        } else{
            [self.dataArr removeAllObjects];;
            [self.tableView reloadData];
            BOOL bl = NO;
            for (UIView *subView in self.tableView.subviews) {
                if (subView == self.smileView) {
                    bl = YES;
                    break;
                }
            }
            
            if (bl == NO) {
                [self creatSTATUS_MY_SmileView];
            }
            return;
        }
        
    } else if (self.CURR_STATUS == CIRCLE_STATUS_RECOMMEND) {
        if (token!=nil){
            url=[NSString stringWithFormat:@"%@circle/fine?version=%@&token=%@&recom=false&pager.curPage=%d",[NSObject baseURLStr],VERSION,token,self.currPage];
        }else
            url=[NSString stringWithFormat:@"%@circle/fineUnLogin?version=%@&recom=false&pager.curPage=%d",[NSObject baseURLStr],VERSION,self.currPage];
        
    } else if (self.CURR_STATUS == CIRCLE_STATUS_ALL) {
        if (token!=nil) {
            url=[NSString stringWithFormat:@"%@circle/queryAll?version=%@&token=%@&pager.curPage=%d",[NSObject baseURLStr],VERSION,token,self.currPage];
        }else
            url=[NSString stringWithFormat:@"%@circle/queryAllUnLogin?version=%@&token=%@&pager.curPage=%d",[NSObject baseURLStr],VERSION,token,self.currPage];
    }
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    NSString *URL = [MyMD5 authkey:url];
    
    [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
//        responseObject = [NSDictionary changeType:responseObject];
        if (self.CURR_STATUS == CIRCLE_STATUS_MY) {

            MyLog(@"responseObject = %@",responseObject);
            
            if (responseObject!=nil) {
                
                //MY = %@", responseObject);
                
                NSString *statu=responseObject[@"status"];
                NSString *message=responseObject[@"message"];
                NSString *pagecount =responseObject[@"pager"][@"pageCount"];
                
                if(statu.intValue==1) {
                    
                    if (self.currPage == 1) {
                        [self.dataArr removeAllObjects];;
                    }
                    
                    for(NSDictionary *dic in responseObject[@"circles"]) {
                        ForumModel *model=[[ForumModel alloc] init];
                        
                        model.n_count=dic[@"n_count"];
                        model.circle_id=dic[@"circle_id"];
                        model.content=dic[@"content"];
                        model.pic=dic[@"pic"];
                        model.title=dic[@"title"];
                        model.u_count=dic[@"u_count"];
                        
                        [self.dataArr addObject:model];
                    }
                    
                    self.countPage = pagecount.intValue;
                    

                    if(self.dataArr.count==0 && [responseObject[@"circles"] count] == 0) {
                        
                        BOOL bl = NO;
                        for (UIView *subView in self.tableView.subviews) {
                            if (subView == self.smileView) {
                                bl = YES;
                                break;
                            }
                        }
                        
                        if (bl == NO) {
                            [self creatSTATUS_MY_SmileView];
                        }
                    } else {
                        [self.smileView removeFromSuperview];

                    }
                    [self.tableView reloadData];
                    
                }
                else if (statu.intValue==10030) {
                    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                    [ud removeObjectForKey:USER_TOKEN];
                    LoginViewController *login=[[LoginViewController alloc]init];
                    login.tag= 1000;
                    [self.navigationController pushViewController:login animated:YES];
                    
                }
                else {
                    
                    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                    [mentionview showLable:message Controller:self];
                    
                }
                
//                //dataArr_MY = %@", self.dataArr);
                
            }
        } else if (self.CURR_STATUS == CIRCLE_STATUS_RECOMMEND) {
        
            if (responseObject!=nil) {
                
                //RECOMMEND = %@", responseObject);
                
                NSString *statu=responseObject[@"status"];
                NSString *message=responseObject[@"message"];
                NSString *pagecount =responseObject[@"pager"][@"pageCount"];

                if(statu.intValue==1)//请求成功
                {
                    
                    if (self.currPage == 1) {
                        [self.dataArr removeAllObjects];;
                    }
                    
                    for(NSDictionary *dic in responseObject[@"circles"])
                    {
                        ForumModel *model=[[ForumModel alloc]init];
                        model.circle_id=dic[@"circle_id"];
                        model.content=dic[@"content"];
                        model.ctitle=dic[@"ctitle"];
                        model.ftitle=dic[@"ftitle"];
                        model.pic=dic[@"pic"];
                        model.news_id=dic[@"news_id"];
                        model.pic_list=dic[@"pic_list"];
                        model.send_time=dic[@"send_time"];
                        model.user_id=dic[@"user_id"];
                        model.r_count=dic[@"r_count"];
                        model.nickname=dic[@"nickname"];
                        
                        [self.dataArr addObject:model];
                    }
                    self.countPage = pagecount.intValue;
                    

                    if (self.dataArr.count == 0 && [responseObject[@"circles"] count] == 0) {
                        
                        BOOL bl = NO;
                        for (UIView *subView in self.tableView.subviews) {
                            if (subView == self.smileView) {
                                bl = YES;
                                break;
                            }
                        }
                        
                        if (bl == NO) {
                            self.smileView = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 300, 200)];
                            self.smileView.center = CGPointMake(self.tableView.frame.size.width/2.0, self.tableView.frame.size.height/2.0-20);
                            //                        self.smileView.backgroundColor = COLOR_RANDOM;
                            
                            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake((300-64)/2.0, 0, 64, 56)];
                            iv.image = [UIImage imageNamed:@"表情"];
                            iv.contentMode = UIViewContentModeScaleAspectFit;
                            [self.smileView addSubview:iv];
                            
                            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                            btn.frame = CGRectMake(20, CGRectGetHeight(self.smileView.frame)-40, 260, 40);
                            btn.layer.borderColor = [[UIColor blackColor] CGColor];
                            btn.layer.borderWidth = 1;
                            
                            btn.tag = 101;
                            [btn addTarget:self action:@selector(findBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                            
                            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                            [btn setTitle:@"查看所有圈子" forState:UIControlStateNormal];
                            [self.smileView addSubview:btn];
                            
                            
                            [self.tableView addSubview:self.smileView];
                        }
                        

                    } else {
                        [self.smileView removeFromSuperview];
                    }
                    
                    [self.tableView reloadData];
                    
                    
                    
                }else{
                    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                    [mentionview showLable:message Controller:self];
                }
                
//                //dataArr_RECOMMEND = %@", self.dataArr);
                
            }

            
        } else if (self.CURR_STATUS == CIRCLE_STATUS_ALL) {
            
            if (responseObject!=nil) {
                
                 //ALL = %@", responseObject);
                
                NSString *statu=responseObject[@"status"];
                NSString *message=responseObject[@"message"];
                NSString *pagecount =responseObject[@"pager"][@"pageCount"];
                
                if(statu.intValue==1)//请求成功
                {
                    if (self.currPage == 1) {
                        [self.dataArr removeAllObjects];;
                    }
                    
                    for(NSDictionary *dic in responseObject[@"circles"])
                    {
                        ForumModel *model=[[ForumModel alloc]init];
                        model.circle_id=dic[@"circle_id"];
                        model.content=dic[@"content"];
                        model.title=dic[@"title"];
                        model.day_count=dic[@"day_count"];
                        model.pic=dic[@"pic"];
                        model.isNO=dic[@"isNo"];
                        [self.dataArr addObject:model];
                    }
                    self.countPage = pagecount.intValue;

                    if (self.dataArr.count == 0 || responseObject[@"circles"] == nil) {
                        SmileView *smileView = [[SmileView alloc]initWithFrame:CGRectMake(0,0, kApplicationWidth, kApplicationHeight-74-49+kUnderStatusBarStartY)];
                        smileView.backgroundColor=[UIColor whiteColor];
                        smileView.str = @"O(n_n)O~亲~";
                        smileView.str2 = @"暂时还没有任何圈子";
                        self.tableView.tableFooterView=smileView;
                    } else {
                        self.tableView.tableFooterView = nil;
                    }
                    
                    [self.tableView reloadData];
                }else {
                    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                    [mentionview showLable:message Controller:self];
                }
                
//                //dataArr_ALL = %@", self.dataArr);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

//        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
    }];
}

- (void)createUI
{
    self.currPage = 1;
    
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        CGFloat H = 0;
        
        if (self.CURR_STATUS == CIRCLE_STATUS_MY) {
            H = CGRectGetHeight(self.view.frame)-65-49-40;
        } else if (self.CURR_STATUS == CIRCLE_STATUS_ALL||self.CURR_STATUS == CIRCLE_STATUS_RECOMMEND) {
            H = CGRectGetHeight(self.view.frame)-65-49;
        }
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, H)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"FamilyTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
        [_tableView registerNib:[UINib nibWithNibName:@"TimeLineTableViewCell" bundle:nil] forCellReuseIdentifier:@"TimeCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"CircleTableViewCell" bundle:nil] forCellReuseIdentifier:@"CilcleCell"];
        _tableView.tableFooterView = [[UIView alloc] init];
        
        __weak TFCircleSubViewController *tc = self;
        
        [_tableView addHeaderWithCallback:^{
            tc.currPage = 1;
            [tc httpGetData];
            [tc.tableView headerEndRefreshing];
        }];
        
        [_tableView addFooterWithCallback:^{
            tc.currPage++;
            [tc httpGetData];
        }];
        
    }
    if(self.CURR_STATUS!=CIRCLE_STATUS_RECOMMEND){
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.CURR_STATUS == CIRCLE_STATUS_MY) {
        ForumModel *model = self.dataArr[indexPath.row];
        
        PostViewController *post=[[PostViewController alloc]init];
        post.circle_id=[NSString stringWithFormat:@"%@",model.circle_id];
        post.forummodel=model;
        post.circle_name=model.title;
        post.isNO = @"1";
        
        post.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:post animated:YES];
    } else if (self.CURR_STATUS == CIRCLE_STATUS_RECOMMEND) {
        ForumModel *model=self.dataArr[indexPath.row];
        
        InvitationViewController *invitation=[[InvitationViewController alloc]init];
        invitation.circle_id=[NSString stringWithFormat:@"%@",model.circle_id];
        //        invitation.circle_content=[NSString stringWithFormat:@"%@",_circleModel.content];
        invitation.model=model;
        invitation.circle_name=model.title;
        invitation.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:invitation animated:YES];
        /*
         PostViewController *post=[[PostViewController alloc]init];
         post.circle_id=[NSString stringWithFormat:@"%@",model.circle_id];
         post.forummodel=model;
         post.hidesBottomBarWhenPushed=YES;
         [self.navigationController pushViewController:post animated:YES];
         */
    } else if (self.CURR_STATUS == CIRCLE_STATUS_ALL) {
        
        _index = (int)indexPath.row;
        
        ForumModel *model=self.dataArr[indexPath.row];
        
        PostViewController *post=[[PostViewController alloc]init];
        
        post.isNO = [NSString stringWithFormat:@"%@",model.isNO];
        post.circle_id=[NSString stringWithFormat:@"%@",model.circle_id];
        post.forummodel=model;
        post.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:post animated:YES];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.CURR_STATUS == CIRCLE_STATUS_MY) {
        return 90;
    } else if (self.CURR_STATUS == CIRCLE_STATUS_RECOMMEND) {
        ForumModel *model=self.dataArr[indexPath.row];
        NSArray *imageArray=[model.pic_list componentsSeparatedByString:@","];
        CGFloat heigh=0;
        if(imageArray.count)
        {
            for(int i=0;i<1;i++)
            {
                NSArray *arr = [imageArray[i] componentsSeparatedByString:@":"];
                CGFloat scale;
                if(arr.count == 2)
                {
                    scale = [arr[1] floatValue];
                }
                if(scale && model.pic_list.length !=0)
                {
                    heigh += contentWidth/scale ;
                    heigh += ZOOM(10*3.4);
                }
            
            }
        }
        
        //头像
        CGFloat titleimageHeigh = 50;
        
        //主标题
        CGFloat titlenameHeigh;
        titlenameHeigh=[self getRowHeight: model.ctitle fontSize:ZOOM(51)];
        
        //副标题
        CGFloat othertitleHeigh;
        othertitleHeigh = [self getRowHeight:model.ftitle fontSize:ZOOM(44)];
        
        CGFloat DiscriiptionLableHeigh ;
        
        //根据文本计算高度
        CGFloat discriptionHeigh;
        discriptionHeigh=[self getRowHeight:model.content fontSize:ZOOM(37)];
        
        //lable只有3行的固定高度
        CGFloat lableheigh = ZOOM(50)*3;
        
        DiscriiptionLableHeigh = discriptionHeigh>lableheigh? (lableheigh):(discriptionHeigh);
        
        MyLog(@"DiscriiptionLableHeigh =%f",DiscriiptionLableHeigh);
        
        CGFloat totalHeigh = (titleimageHeigh+titlenameHeigh+othertitleHeigh+DiscriiptionLableHeigh+heigh+ZOOM(50*3.4));
    
        return totalHeigh;
        
        
    } else if (self.CURR_STATUS == CIRCLE_STATUS_ALL) {
        return 90;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    //count = %d", (int)self.dataArr.count);
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(self.CURR_STATUS == CIRCLE_STATUS_MY)
    {
        FamilyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        ForumModel *model=self.dataArr[indexPath.row];
        
//        //MY = %@", model);
        
        [cell refreshData:model];

        return cell;
    } else if (self.CURR_STATUS == CIRCLE_STATUS_RECOMMEND) {
        
        
        
        static NSString *identifier = @"TimeCell";
        TimeLineTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cell.fineImage.hidden=YES;
        cell.topimage.hidden=YES;
        
        ForumModel *model;
        model = self.dataArr[indexPath.row];
        cell.TitleImage.frame = CGRectMake(ZOOM(62), ZOOM(47), 50, 50);
        
        //主标题地
        cell.titlename.text=model.ctitle;
        cell.titlename.font = [UIFont systemFontOfSize:ZOOM(51)];
        
        CGFloat titlenameHeigh;
        titlenameHeigh=[self getRowHeight: cell.titlename.text fontSize:ZOOM(46)];
        cell.titlename.frame=CGRectMake(CGRectGetMaxX(cell.TitleImage.frame)+ZOOM(33), CGRectGetMidY(cell.TitleImage.frame)-titlenameHeigh/2, cell.titlename.frame.size.width, titlenameHeigh);
        
        cell.time.frame = CGRectMake(kApplicationWidth-ZOOM(62)-90, cell.titlename.frame.origin.y, 90, cell.time.frame.size.height);
        NSString *newtime=[MyMD5 compareCurrentTime:model.send_time];
        cell.time.text = [NSString stringWithFormat:@"%@",newtime];
        cell.time.textColor=kTextColor;
        cell.time.textAlignment=NSTextAlignmentRight;
        cell.time.font = [UIFont systemFontOfSize:ZOOM(40)];
        
        CGFloat x_point = 0;
        
        if(model.fine.intValue == 1)
        {
            cell.fineImage.hidden = NO;
            cell.fineImage.frame = CGRectMake(cell.titlename.frame.origin.x, CGRectGetMaxY(cell.TitleImage.frame)+ZOOM(0), 18, 18);
            
            x_point +=23;
        }
        
        if(model.pic_list.length >0)
        {
            cell.topimage.hidden = NO;
            cell.topimage.frame = CGRectMake(cell.titlename.frame.origin.x+x_point, CGRectGetMaxY(cell.TitleImage.frame)+ZOOM(0), 18, 18);
            
            x_point +=23;
        }
        
        //副标题
        cell.circlename.text=[NSString stringWithFormat:@"【%@】",model.ftitle];
        CGFloat circlenameHeigh;
        circlenameHeigh=[self getRowHeight:cell.circlename.text fontSize:ZOOM(44)];
        cell.circlename.frame=CGRectMake(cell.titlename.frame.origin.x+x_point,CGRectGetMaxY(cell.TitleImage.frame)+ZOOM(0),contentWidth-x_point,circlenameHeigh);
        cell.circlename.font = [UIFont systemFontOfSize:ZOOM(44)];

        //描述内容
        cell.DiscriiptionLable.text=model.content;
        cell.DiscriiptionLable.numberOfLines = 0;
        
        CGFloat DiscriiptionLableHeigh ;
        
        //根据文本计算高度
        CGFloat discriptionHeigh;
        discriptionHeigh=[self getRowHeight:cell.DiscriiptionLable.text fontSize:ZOOM(37)];
        
        //lable只有3行的固定高度
        CGFloat lableheigh = ZOOM(50)*3;
        
        DiscriiptionLableHeigh = discriptionHeigh > lableheigh? (lableheigh):(discriptionHeigh);

        MyLog(@"DiscriiptionLableHeigh =%f",DiscriiptionLableHeigh);
        
        cell.DiscriiptionLable.frame=CGRectMake(cell.titlename.frame.origin.x, cell.circlename.frame.origin.y+circlenameHeigh+ZOOM(25), contentWidth, DiscriiptionLableHeigh);
        cell.DiscriiptionLable.font = [UIFont systemFontOfSize:ZOOM(37)];
        
        for (UIView *view in cell.allImgView.subviews) {
            [view removeFromSuperview];
        }
        
        UIView *allimgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.backView.frame.size.width-ZOOM(62), 0)];
        allimgView.backgroundColor=[UIColor blueColor];
        
        
        NSString *last;
        if (model.pic_list.length!=0) {
            last = [model.pic_list substringFromIndex:model.pic_list.length-1];
        }
        if ([last isEqualToString:@","]) {
            model.pic_list = [model.pic_list substringToIndex:model.pic_list.length-1];
        }
        
        
        //图片
        NSArray *imageArray;
        if(model.pic_list.length >0) {
            imageArray  = [model.pic_list componentsSeparatedByString:@","];
        }
        
        NSMutableArray *imagesArray = [NSMutableArray arrayWithArray:imageArray];
        
        CGFloat totalHeith=0;
        
        
        if(imageArray.count && model.pic_list.length!=0) {
            CGFloat tempheigh=0;
            CGFloat tempY = 0;
            
            for( int i=0 ;i<1;i++) {
                CGFloat imageHeigh;
                CGFloat scale;
                NSString *imageUrl;
                
                NSString *detailimage =imagesArray[i];
                
                NSArray *arr =[detailimage componentsSeparatedByString:@":"];
                
                if(arr.count == 2) {
                    imageUrl = arr[0];
                    scale = [arr[1] floatValue];
                    
                    MyLog(@"scale=%f",scale);
                }
                
                if(scale && model.pic_list.length!=0) {
                    imageHeigh = contentWidth/scale;
                    totalHeith += imageHeigh;
                    totalHeith += 10;
                }
                
                
                UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, tempY+10*i, contentWidth, imageHeigh)];
                tempheigh=imageHeigh;
                tempY=totalHeith;
//                imageView.contentMode=UIViewContentModeScaleAspectFit;
                NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!560",[NSObject baseURLStr_Upy],imageUrl]];
                __block float d = 0;
                __block BOOL isDownlaod = NO;
                [imageView sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    d = (float)receivedSize/expectedSize;
                    isDownlaod = YES;
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image != nil && isDownlaod == YES) {
                        imageView.alpha = 0;
                        [UIView animateWithDuration:0.5 animations:^{
                            imageView.alpha = 1;
                        } completion:^(BOOL finished) {
                        }];
                    } else if (image != nil && isDownlaod == NO) {
                        imageView.image = image;
                        //%f  %f   %f",image.size.width,image.size.height,image.size.width/image.size.height);
                    }
                }];
                
                [allimgView addSubview:imageView];
            }
        }
       
        
        [cell.allImgView addSubview:allimgView];
        cell.allImgView.frame=CGRectMake(cell.titlename.frame.origin.x, CGRectGetMaxY(cell.DiscriiptionLable.frame)+ZOOM(30), contentWidth, totalHeith);

        //名字
        
        cell.name.frame=CGRectMake(cell.titlename.frame.origin.x,CGRectGetMaxY(cell.allImgView.frame), 150, 20);

        cell.name.font = [UIFont systemFontOfSize:ZOOM(40)];
        cell.name.textColor = kTextColor;
        NSString *nickname=model.nickname;
        if (model.nickname.length>8) {
            nickname=[nickname substringToIndex:8];
        }
        cell.name.text=[NSString stringWithFormat:@"%@",nickname];
        
        if (model.r_count) {
            cell.couunt.text=[NSString stringWithFormat:@"%@",model.r_count];
        } else {
            cell.couunt.text=[NSString stringWithFormat:@"0"];
        }
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]};
        CGSize textSize = [cell.couunt.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
        cell.couunt.frame=CGRectMake(kScreenWidth-textSize.width-ZOOM(62),cell.name.frame.origin.y,textSize.width, 25);
        cell.couunt.font = HBfont(ZOOM(40));
        cell.couunt.textColor = kTextColor;
        
        cell.commentImg.frame=CGRectMake(cell.couunt.frame.origin.x-cell.commentImg.frame.size.width-5, cell.couunt.frame.origin.y, cell.commentImg.frame.size.width, 28);
        cell.standLine.hidden=YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.pic]];
        if ([model.pic hasPrefix:@"http://"]) {
            imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic]];
        }
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        [cell.TitleImage sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"默认头像.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            d = (float)receivedSize/expectedSize;
            isDownlaod = YES;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil && isDownlaod == YES) {
                cell.TitleImage.alpha = 0;
                [UIView animateWithDuration:0.5 animations:^{
                    cell.TitleImage.alpha = 1;
                } completion:^(BOOL finished) {
                }];
            } else if (image != nil && isDownlaod == NO) {
                cell.TitleImage.image = image;
            }
        }];
        
        [cell.imgBtn addTarget:self action:@selector(tapClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.TitleImage.clipsToBounds=YES;
        cell.TitleImage.layer.cornerRadius=25;

//        //RECOMMEND = %@", model);
        return cell;
        
    } else if (self.CURR_STATUS == CIRCLE_STATUS_ALL) {
        static NSString *identifier=@"CilcleCell";
        CircleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ForumModel *model=self.dataArr[indexPath.row];
        
        cell.row=indexPath.row;
        cell.delegate = self;
        [cell refreshData:model];
        
//        //ALL = %@", model);
        
        return cell;
    } else
        return 0;
    
}

- (void)submitSuccess:(NSNotification*)note
{
    if (self.CURR_STATUS == CIRCLE_STATUS_ALL) {
        
        ForumModel *model = self.dataArr[_index];
        MyLog(@"model.u_count = %@",model.r_count);
        
        model.day_count = [NSString stringWithFormat:@"%d",model.day_count.intValue+1];
        MyLog(@"model.u_count = %@",model.day_count);
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:_index inSection:0];
        
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(contentWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    return height;
}

-(void)tapClick:(UIButton *)sender
{
    TimeLineTableViewCell * cell;
    if (kIOSVersions >= 7.0 && kIOSVersions < 8) {
        cell = (TimeLineTableViewCell *)[[[sender superview] superview] superview] ;
    }else{
        cell = (TimeLineTableViewCell *)[[sender superview] superview];
    }
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ForumModel *model=self.dataArr[indexPath.row];
    PostViewController *post=[[PostViewController alloc]init];
    post.circle_id=[NSString stringWithFormat:@"%@",model.circle_id];
    post.forummodel=model;
    post.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:post animated:YES];
}
#pragma mark 跳转到登录界面
- (void)ToLogin :(NSInteger)tag
{
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag = tag;
    login.loginStatue=@"toBack";
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:YES];
}

- (void)ToLoginView
{
    TFLoginView *tf = [[TFLoginView alloc] initWithHeadImage:nil contentText:nil upButtonTitle:nil downButtonTitle:nil];
    [tf show];
    
    tf.upBlock = ^() { //注册
        //上键");
        [self ToLogin:2000];
    };
    
    tf.downBlock = ^() {// 登录
        //下键");
        
        [self ToLogin:1000];
    };
}
#pragma mark 加入圈
-(void)Addcircle:(NSInteger)index
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]==nil) {
        [self ToLoginView];
        return;
    }else{
        ForumModel *model = self.dataArr[index];
        NSString *circleid=[NSString stringWithFormat:@"%@",model.circle_id];
        
        if(model.isNO.intValue == 0)
        {
            
            [self AddcircleHttp:circleid :index];
            
        }
        else if (model.isNO.intValue == 1)
        {
            
            MyLog(@"退出圈");
            
            [self ExitcircleHttp:circleid :index];
            
            //        NavgationbarView *mentiontview = [[NavgationbarView alloc]init];
            //        [mentiontview showLable:@"已是该圈子成员" Controller:self];
        }
    }
}

#pragma mark 网络请求——退出圈
-(void)ExitcircleHttp:(NSString*)circleid :(NSInteger)index
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@circle/del?version=%@&token=%@&circle_id=%@",[NSObject baseURLStr],VERSION,token,circleid];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        [MBProgressHUD hideHUDForView:self.view];
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                message=@"退出圈成功";
                ForumModel *model = self.dataArr[index];
                model.isNO=@"0";

                [MBProgressHUD showSuccess:message];
            } else{
                message=@"退出圈失败";
                [MBProgressHUD showError:message];
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
            
            [self.tableView reloadData];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];

        [[Animation shareAnimation] stopAnimationAt:self.view];
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败，稍后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alter show];
        
    }];
    
    
}


#pragma mark 网络请求————加入圈
-(void)AddcircleHttp:(NSString*)circleid :(NSInteger)index
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@circle/add?version=%@&token=%@&circle_id=%@",[NSObject baseURLStr],VERSION,token,circleid];
    
    NSString *URL=[MyMD5 authkey:url];
   
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                message=@"加入圈成功";
                //            _currentpage3=1;
                //            [self circleHttp];
                
                ForumModel *model = self.dataArr[index];
                model.isNO=@"1";
                [MBProgressHUD showSuccess:message];
                
                
                
                
            }else{
                message=@"加入圈失败";
                [MBProgressHUD showError:message];
                

            }
            
            [self.tableView reloadData];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败，稍后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alter show];
        
    }];
    
    
}

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}
- (void)viewWillAppear:(BOOL)animated
{
    Myview.hidden = NO;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    Myview.hidden = NO;
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
