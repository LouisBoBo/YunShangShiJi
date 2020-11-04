//
//  SelectShareTypeViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/7.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "SelectShareTypeViewController.h"
#import "XRWaterfallLayout.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.h"
#import "HotTopicCollectionViewCell.h"
#import "TopicDetailViewController.h"
#import "TFShoppingViewController.h"
#import "MakeMoneyViewController.h"
#import "WaterFlowCell.h"
#import "GlobalTool.h"
#import "ShareModel.h"
#import "TFWaterFLayout.h"

#import "TFShoppingVM.h"
#import "NavgationbarView.h"
#import "TopicPublicModel.h"
#import "ShopDetailViewController.h"
#import "TaskSignModel.h"
#import "AppDelegate.h"
#import "QRCodeGenerator.h"
#import "ProduceImage.h"
#import "TypeShareModel.h"
#import "WXApi.h"
#define SHAREVIEWHEIGH ZOOM6(150)
@interface SelectShareTypeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,XRWaterfallLayoutDelegate,DShareManagerDelegate,WXApiDelegate,MiniShareManagerDelegate>
{
    NSInteger haveSelectedType;
    
    NSInteger selectRowOne;
    NSInteger selectRowTwo;
}
@property (nonatomic , assign)int currPage;
@property (nonatomic , assign)int currPage2;

@property (nonatomic, strong) TFShoppingVM *viewModel;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *dataArray2;
@property (nonatomic , strong) DShareManager *shareManager;

@end

@implementation SelectShareTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor whiteColor];
    [self creatHeadView];
    [self creatCollectionView];
    [self.view addSubview:self.shareView];
    
    self.currPage=1;self.currPage2=1;
    
    if (_hideSegment) {
        if (_selectShareType) {
            [self httpTheme];
        }else
            [self httpGetData];
    }else{
        [self creatsegment];
        
        [self httpGetData];
        [self httpTheme];
    }
    
    kSelfWeak;
    [self loadFailBtnBlock:^{
        kSelfStrong;
        if (weakSelf.selectShareType) {
            weakSelf.currPage2=1;
            [weakSelf httpTheme];
            strongSelf -> haveSelectedType= strongSelf ->haveSelectedType==2?0:strongSelf ->haveSelectedType;
        }else{
            strongSelf ->haveSelectedType=strongSelf ->haveSelectedType==1?0:strongSelf ->haveSelectedType;
            weakSelf.currPage=1;
            [weakSelf httpGetData];
        }
    }];
}
- (TFShoppingVM *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[TFShoppingVM alloc] init];
        _viewModel.typeID = [NSNumber numberWithInteger:6];
        _viewModel.typeName = @"热卖";
    }
    return _viewModel;
}
- (NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)dataArray2 {
    if (nil == _dataArray2) {
        _dataArray2=[NSMutableArray array];
    }
    return _dataArray2;
}
#pragma mark - DataAccess
- (void)httpTheme {
    kSelfWeak;
    [CircleModel getCircleThemeModelWithCurPage:self.currPage2 success:^(id data) {
        CircleModel *model = data;
        if (model.status == 1) {
            if (weakSelf.currPage2 == 1) {
                [weakSelf.dataArray2 removeAllObjects];
            }
            
            for(int i =0 ; i <model.myData.count; i++){
                IntimateCircleModel *cmodel = model.myData[i];
                if(cmodel.pics.length>6 || cmodel.shop_list.count){
                    [weakSelf.dataArray2 addObject:cmodel];
                }
            }
            [weakSelf.collectionView reloadData];
        } else {
            [NavgationbarView showMessageAndHide:model.message backgroundVisiable:NO];
        }
    }];
}

- (void)httpGetData
{
    kSelfWeak;
    [self.viewModel handleDataWithFromType:@"购物" pageNum:self.currPage Success:^(NSArray *modelArray, Response *response) {
        
//        [weakSelf.collectionView headerEndRefreshing];
//        [weakSelf.collectionView footerEndRefreshing];
        if (response.status == 1) {
            
            if (weakSelf.currPage == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            
            [weakSelf.dataArray addObjectsFromArray:modelArray];
//            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.collectionView reloadData];
//            });
            [weakSelf loadingDataSuccess];
            
        }
        
    } failure:^(NSError *error) {
//        [self.collectionView headerEndRefreshing];
//        [self.collectionView footerEndRefreshing];
        [weakSelf loadingDataBackgroundView:self.collectionView img:[UIImage imageNamed:@"哭脸"] text:@"亲,没网了"];
        
    }];
    
}

- (void)creatsegment
{
    self.segment=[[UISegmentedControl alloc]initWithItems:@[@"分享品质美衣",@"分享热门穿搭"]];
    self.segment.frame=CGRectMake((kApplicationWidth-ZOOM6(480))/2, ZOOM6(30)+Height_NavBar, ZOOM6(480), ZOOM6(60));
    self.segment.selectedSegmentIndex = self.selectShareType;
    [self.segment setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIFont systemFontOfSize:ZOOM6(28)],NSFontAttributeName,nil] forState:UIControlStateNormal];
    [self.segment setTintColor:tarbarrossred];
    [self.segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segment];

}
//导航条
- (void)creatHeadView
{
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
    if(self.ISInvit)
    {
        titlelable.text=@"选择分享方式";
    }else{
        titlelable.text=@"选择邀请方式";
    }
    if (_hideSegment) {
        if (_selectShareType) {
            titlelable.text=@"分享热门穿搭";
        }else
            titlelable.text=@"分享品质美衣";
    }
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [self.tabheadview addSubview:titlelable];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];

}
- (DShareManager*)shareManager
{
    if(_shareManager == nil)
    {
        AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app shardk];
        _shareManager = [DShareManager share];
        _shareManager.delegate = self;
        kSelfWeak;
        _shareManager.ShareSuccessBlock=^{
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"分享成功" Controller:weakSelf];
            [weakSelf shareSuccess:YES];
        };
        _shareManager.ShareFailBlock = ^{
            
            if(weakSelf.ISInvit)
            {
                [weakSelf shareSuccess:NO];//集赞邀请没有分享成功也算完成任务
            }else{
                NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                [mentionview showLable:@"分享失败" Controller:weakSelf];
            }
        };
    }
    return _shareManager;
}
//分享视图
- (UIView*)shareView
{
    if(_shareView == nil)
    {
        _shareView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-SHAREVIEWHEIGH, kScreenWidth, SHAREVIEWHEIGH)];
        
        UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20),ZOOM6(20), kScreenWidth-2*ZOOM6(20), ZOOM6(0))];
        titlelabel.textAlignment = NSTextAlignmentCenter;
//        titlelabel.text = @"分享到";
        titlelabel.textColor = RGBCOLOR_I(62, 62, 62);
        titlelabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
        [_shareView addSubview:titlelabel];
        
        //分享的平台
//        NSArray *shareArray = @[@"微信",@"朋友圈",@"QQ空间"];
        NSMutableArray *shareArray=[NSMutableArray array];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
            [shareArray addObject:@"微信"];
//            [shareArray addObject:@"朋友圈"];
        }
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
//            [shareArray addObject:@"QQ空间"];
        CGFloat buttonwith = ZOOM6(420);
        CGFloat buttonHeig = ZOOM6(88);
        CGFloat spacewith = (kScreenWidth-shareArray.count*buttonwith)/(shareArray.count + 1);
        for(int i =0; i<shareArray.count; i++)
        {
            UIButton *shareButton = [[UIButton alloc]init];
            shareButton.frame = CGRectMake(spacewith+(buttonwith+spacewith)*i, CGRectGetMaxY(titlelabel.frame)+ZOOM6(10), buttonwith, buttonHeig);
            shareButton.tag = 10000+i;
            [_shareView addSubview:shareButton];
            
            if(i == 0)
            {
                [shareButton setImage:[UIImage imageNamed:@"分享到微信群"] forState:UIControlStateNormal];
            }else if (i == 1)
            {
                [shareButton setImage:[UIImage imageNamed:@"朋友圈-1"] forState:UIControlStateNormal];
            }else if (i == 2)
            {
                [shareButton setImage:[UIImage imageNamed:@"qq空间-1"] forState:UIControlStateNormal];
            }
            
            [shareButton addTarget:self action:@selector(shareclick:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *sharelab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(shareButton.frame), CGRectGetMaxY(shareButton.frame)+ZOOM6(10),CGRectGetWidth(shareButton.frame), ZOOM6(30))];
            sharelab.text = shareArray[i];
            sharelab.textAlignment = NSTextAlignmentCenter;
            sharelab.textColor = RGBCOLOR_I(168, 168, 168);
            sharelab.font = [UIFont systemFontOfSize:ZOOM6(24)];
//            [_shareView addSubview:sharelab];
        }
    }
    
    return _shareView;
}

- (void)creatCollectionView
{
    //创建瀑布流布局
//    XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:1];
    
    XRWaterfallLayout *waterfall = [[XRWaterfallLayout alloc]init];
    //设置各属性的值
    //    waterfall.rowSpacing = 10;
    //    waterfall.columnSpacing = 10;
    //    waterfall.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //或者一次性设置
    [waterfall setColumnSpacing:5 rowSpacing:0 sectionInset:UIEdgeInsetsMake(0, 5, 0, 5)];

    //设置代理，实现代理方法
    waterfall.delegate = self;
    /*
     //或者设置block
     [waterfall setItemHeightBlock:^CGFloat(CGFloat itemWidth, NSIndexPath *indexPath) {
     //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
     XRImage *image = self.images[indexPath.item];
     return image.imageH / image.imageW * itemWidth;
     }];
     */
    
    CGFloat height = _hideSegment ? 0 :ZOOM6(120);
    //创建collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Height_NavBar+height, kScreenWidth, kScreenHeight-Height_NavBar-height-SHAREVIEWHEIGH) collectionViewLayout:waterfall];
    self.collectionView.backgroundColor = RGBCOLOR_I(239, 239, 239);
    [self.collectionView registerNib:[UINib nibWithNibName:@"HotTopicCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HotCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"WaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    /*
    //下拉刷新
    __weak SelectShareTypeViewController *myController = self;
    [_collectionView addHeaderWithCallback:^{
        [myController.collectionView headerEndRefreshing];
    }];
    
    //上拉加载
    [_collectionView addFooterWithCallback:^{
        [myController.collectionView footerEndRefreshing];
    }];
    */
    kSelfWeak;
    [_collectionView addHeaderWithCallback:^{
        kSelfStrong;
        [weakSelf.collectionView headerEndRefreshing];
        if (weakSelf.selectShareType) {
            weakSelf.currPage2=1;
            [weakSelf httpTheme];
            strongSelf ->haveSelectedType=strongSelf ->haveSelectedType==2?0:strongSelf ->haveSelectedType;
        }else{
            strongSelf ->haveSelectedType=strongSelf ->haveSelectedType==1?0:strongSelf ->haveSelectedType;
            weakSelf.currPage=1;
            [weakSelf httpGetData];
        }
    }];
    [_collectionView addFooterWithCallback:^{
        [weakSelf.collectionView footerEndRefreshing];
        if (weakSelf.selectShareType) {
            weakSelf.currPage2++;
            [weakSelf httpTheme];
        }else{
            weakSelf.currPage++;
            [weakSelf httpGetData];
        }
    }];
}

//根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath
{
    if(self.selectShareType == 0)
    {
        CGFloat imgH = 900;
        CGFloat imgW = 600;
        
        CGFloat W = (kScreenWidth-18)/2.0;
        CGFloat H = imgH*W/imgW;
        
        return  H+5;

    }else{
        
        IntimateCircleModel *model = self.dataArray2[indexPath.item];
        CGFloat imageSize = 0;
        
        if(model.theme_type.intValue == 1)
        {
            imageSize = 0.67;
        }else{
            NSString *str = model.pics;
            NSArray *imageArr = [str componentsSeparatedByString:@","];
            NSString *imagestr = @"";
            
            if(imageArr.count){
                imagestr = imageArr[0];
                NSArray *arr = [imagestr componentsSeparatedByString:@":"];
                if(arr.count == 2){
                    imageSize = ([arr[1] floatValue]<0.56)?0.56:[arr[1] floatValue];
                }
            }
        }
        
        if(imageSize >0) {
            return itemWidth/imageSize +50+ZOOM6(90)+5;
        }
        return imageSize;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.selectShareType == 0 ? self.dataArray.count : self.dataArray2.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.selectShareType == 0)
    {
        WaterFlowCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
        if(self.dataArray.count>indexPath.item){
            TFShoppingM *model=self.dataArray[indexPath.item];
            [cell receiveDataModel2:model];
            [cell receiveshareModel:model.isSelect&&haveSelectedType==1];
            kSelfWeak;
            cell.selectBlock = ^{
                kSelfStrong;
                TFShoppingM *model=weakSelf.dataArray[indexPath.item];
                
                model.isSelect=!model.isSelect;
                
                if (strongSelf->selectRowOne!=indexPath.item) {
                    TFShoppingM *model2=weakSelf.dataArray[strongSelf->selectRowOne];
                    model2.isSelect=NO;
                }
                strongSelf->haveSelectedType=model.isSelect;
                strongSelf->selectRowOne=indexPath.item;
                [weakSelf.collectionView reloadData];
            };
        }
        
        return cell;

    }else{
        HotTopicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCell" forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.bigImage.frame = CGRectMake(0, 5, cell.frame.size.width, cell.frame.size.height-50-ZOOM6(90));
        if (self.dataArray2.count>indexPath.item) {
            IntimateCircleModel *circleModel = self.dataArray2[indexPath.item];
            [cell refreshCircleData:circleModel];
            [cell refreshShareData:circleModel.isSelect&&haveSelectedType==2];
            kWeakSelf(cell);
            kSelfWeak;
            cell.selectBlock = ^{
                kSelfStrong;
                IntimateCircleModel *model=weakSelf.dataArray2[indexPath.item];
                model.isSelect=!model.isSelect;
                if (strongSelf->selectRowTwo!=indexPath.item) {
                    IntimateCircleModel *model2=weakSelf.dataArray2[strongSelf->selectRowTwo];
                    model2.isSelect=NO;
                }
                strongSelf->haveSelectedType = model.isSelect?2:0;
                strongSelf->selectRowTwo=indexPath.item;
                [weakSelf.collectionView reloadData];
            };
            
            NSString *them_id = [NSString stringWithFormat:@"%@",circleModel.theme_id];
            kWeakSelf(circleModel)
            cell.likeBlock = ^(NSInteger num){
                
                if(weakcell.like.selected)//取消点赞
                {
                    [TopicPublicModel DisThumbstData:1 This_id:them_id Theme_id:them_id Success:^(id data) {
                        TopicPublicModel *model = data;
                        if(model.status == 1)
                        {
                            weakcell.like.selected = !weakcell.like.selected;
                            weakcircleModel.applaud_status=0;
                            weakcircleModel.applaud_num = [NSNumber numberWithInteger:weakcircleModel.applaud_num.integerValue-1];
                            if(num >0)
                            {
                                [weakcell.like setTitle:[NSString stringWithFormat:@"%d",(int)num-1] forState:UIControlStateNormal];
                                
                                [weakcell.like setTitleColor:RGBCOLOR_I(168, 168, 168) forState:UIControlStateNormal];
                            }
                        }
                    }];
                }else{//点赞
                    
                    [TopicPublicModel ThumbstData:1 This_id:them_id Theme_id:them_id Success:^(id data) {
                        TopicPublicModel *model = data;
                        if(model.status == 1)
                        {
                            weakcell.like.selected = !weakcell.like.selected;
                            weakcircleModel.applaud_status=1;
                            weakcircleModel.applaud_num = [NSNumber numberWithInteger:weakcircleModel.applaud_num.integerValue+1];
                            
                            [weakcell.like setTitle:[NSString stringWithFormat:@"%d",(int)num+1] forState:UIControlStateNormal];
                            
                            [weakcell.like setTitleColor:tarbarrossred forState:UIControlStateNormal];
                        }
                        
                    }];
                }
            };
        }
   
//        cell.imageURL = self.images[indexPath.item].imageURL;

        /*
        kWeakSelf(cell);
        cell.likeBlock = ^(NSInteger num){
            
            if(weakcell.like.selected)
            {
                [weakcell.like setTitle:[NSString stringWithFormat:@"%ld",(long)num-1] forState:UIControlStateNormal];
            }else{
                [weakcell.like setTitle:[NSString stringWithFormat:@"%ld",(long)num+1] forState:UIControlStateNormal];
            }
            weakcell.like.selected = !weakcell.like.selected;
        };
        */
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.selectShareType == 0) {
        TFShoppingM *model=self.dataArray[indexPath.item];
        ShopDetailViewController *detail=[[ShopDetailViewController alloc] initWithNibName:@"ShopDetailViewController" bundle:nil];
        detail.stringtype = @"订单详情";
        detail.shop_code = model.shop_code;
        [self.navigationController pushViewController:detail animated:YES];
    }else{
        IntimateCircleModel *model = self.dataArray2[indexPath.item];
        TopicDetailViewController *topic = [[TopicDetailViewController alloc]init];
        topic.theme_id = [model.theme_id stringValue];
        topic.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:topic animated:YES];
    }
}

#pragma mark - 事件点击 segmentChange
-(void)segmentChange:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.selectShareType = 0;
            break;
        case 1:
            self.selectShareType = 1;
            break;
        default:
            break;
    }
    
    //滑动到最底部
    [self.collectionView setContentOffset:CGPointMake(0, 0)];
    self.selectShareType = sender.selectedSegmentIndex;
    [self.collectionView reloadData];
}
- (void)shareclick:(UIButton*)sender
{
    NSInteger tag = sender.tag -10000;
    if (haveSelectedType) {
        NSString *imgUrl,*title,*link;
        if (haveSelectedType==1) {
            TFShoppingM *model=self.dataArray[selectRowOne];
            NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model.shop_code]];
            NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
            NSString *pic = [NSString stringWithFormat:@"%@/%@/%@",supcode,model.shop_code,model.def_pic];
            NSString *picSize;
            if (kDevice_Is_iPhone6Plus) {
                picSize = @"!382";
            } else {
                picSize = @"!280";
            }
            //            NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],pic,picSize]];
            imgUrl=[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],pic,picSize];
            
            title = model.shop_name;
            [self shopRequest:tag shopcode:model.shop_code];
            
        }else{
            IntimateCircleModel *circleModel = self.dataArray2[selectRowTwo];
            if(circleModel.theme_type.intValue == 1){
                TFShopModel *shopmodel = circleModel.shop_list[0];
                imgUrl = [HotTopicCollectionViewCell shopImageStr:shopmodel];
            }else{
                imgUrl = [HotTopicCollectionViewCell circiImageStr:circleModel];
            }
            if(circleModel.title.length>0) {
                title = [NSString stringWithFormat:@"#%@# %@",circleModel.title,circleModel.content];
            }else{
                title = [NSString stringWithFormat:@"%@",circleModel.content];
            }
            NSString *realm = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
            link  = [NSString stringWithFormat:@"%@views/topic/detail.html?theme_id=%@&realm=%@",[NSObject baseH5ShareURLStr],circleModel.theme_id,realm];
            
            if(tag == 0)//好友
            {
                MiniShareManager *minishare = [MiniShareManager share];
                
                NSString *image = [NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],imgUrl];
                NSString *path  = [NSString stringWithFormat:@"/pages/shouye/detail/sweetFriendsDetail/friendsDetail?theme_id=%@&user_id=%@",circleModel.theme_id,realm];
                
                minishare.delegate = self;
                [minishare shareAppWithType:MINIShareTypeWeixiSession Image:image Title:title Discription:nil WithSharePath:path];
            }else{
                [self goShare:tag imgUrl:imgUrl title:title link:link];
            }
    
        }
    }else{
        [NavgationbarView showMessageAndHide:@"请选择" backgroundVisiable:NO];
    }
    
}
#pragma mark 获取商品链接请求
- (void)shopRequest:(NSInteger)tag shopcode:(NSString*)shopcode
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *realm = [user objectForKey:USER_ID];
    NSString *token = [user objectForKey:USER_TOKEN];
    
    [DataManager sharedManager].key = shopcode;
    
    NSString *url=[NSString stringWithFormat:@"%@shop/getShopLink?version=%@&shop_code=%@&realm=%@&token=%@&share=%@&getShopMessage=true",[NSObject baseURLStr],VERSION,shopcode,realm,token,@"2"];
    
    
    MyLog(@"url is: %@", url);
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"分享加载中，稍等哟~" afterDeleay:0 WithView:self.view];
    
    MyLog(@"URL is: %@", URL);
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject!=nil || ![responseObject isEqual:[NSNull null]]) {
            
            NSString *str=responseObject[@"status"];
            if(str.intValue==1) {
                //                _shareModel=[ShareShopModel alloc];
                //                _shareModel.shopUrl=responseObject[@"link"];
                NSString *_shareShopurl=responseObject[@"link"];
                NSString *QrLink =responseObject[@"QrLink"];
                NSDictionary * dic =responseObject[@"shop"];
                
                if(dic != NULL)
                {
                    NSString  *_sharePrice=dic[@"shop_se_price"];
                    
                    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                    NSString *imgstr;
                    NSString *strstr = [NSString stringWithFormat:@"%@",dic[@"four_pic"]];
                    
                    if([strstr length] >10){
                        NSArray *imageArray = [dic[@"four_pic"] componentsSeparatedByString:@","];
                        
                        if(imageArray.count > 2){
                            imgstr = imageArray[2];
                            //                            _shareModel.shopImage = imageArray[2];
                            
                        }else if (imageArray.count > 0){
                            imgstr = imageArray[0];
                        }
                        
                        //获取供应商编号
                        NSMutableString *code ;
                        NSString *supcode  ;
                        if(dic[@"shop_code"]){
                            code = [NSMutableString stringWithString:dic[@"shop_code"]];
                            supcode  = [code substringWithRange:NSMakeRange(1, 3)];
                        }
                        [userdefaul setObject:[NSString stringWithFormat:@"%@/%@/%@",supcode,code,imgstr] forKey:SHOP_PIC];
                    }
                    
                    
                    [userdefaul setObject:[NSString stringWithFormat:@"%@",dic[@"content"]] forKey:SHOP_TITLE];
                    [userdefaul setObject:[NSString stringWithFormat:@"%@",_shareShopurl] forKey:SHOP_LINK];
                    [userdefaul setObject:[NSString stringWithFormat:@"%@",dic[@"shop_name"]] forKey:SHOP_NAME];
                    [userdefaul setObject:[NSString stringWithFormat:@"%@",dic[@"supp_label"]] forKey:SHOP_BRAND];
                    [userdefaul setObject:shopcode forKey:SHOP_CODE];
                     [userdefaul setObject:[NSString stringWithFormat:@"%@",dic[@"app_shop_group_price"]] forKey:@"app_shop_group_price"];
                    if(_shareShopurl)
                    {
                        [userdefaul setObject:[NSString stringWithFormat:@"%@",_shareShopurl] forKey:QR_LINK];
                    }
//                    if(QrLink){
//                        [userdefaul setObject:QrLink forKey:QR_LINK];
//                    }
                    
                    if(_sharePrice !=nil || ![_sharePrice isEqual:[NSNull null]]){
                        [user setObject:[NSString stringWithFormat:@"%.1f",_sharePrice.floatValue*0.5] forKey:SHOP_PRICE];
                    }
                    
                    if( [_shareShopurl isEqual:[NSNull null]] || [_sharePrice isEqual:[NSNull null]]){
                        [MBProgressHUD hideHUDForView:self.view];
                        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                        [mentionview showLable:@"数据获取异常" Controller:self];
                        return;
                    }
                    
                    [self gotoShare:tag];
                    
//                    [TypeShareModel getTypeCodeWithShop_code:shopcode success:^(TypeShareModel *data) {
//
//                        if(data.status == 1 && data.type2 != nil)
//                        {
//                            [userdefaul setObject:[NSString stringWithFormat:@"%@",data.type2] forKey:SHOP_TYPE2];
//                            [self gotoShare:tag];
//                        }
//
//                    }];
                }
            }else{
                [MBProgressHUD hideHUDForView:self.view];
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"网络异常，请稍后重试" Controller:self];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark 分享
- (void)gotoShare:(NSInteger)sharetag {
    AppDelegate *app=[[UIApplication sharedApplication] delegate];
    [app shardk];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *shop_pic=[user objectForKey:SHOP_PIC];
    NSString *shopprice =[user objectForKey:SHOP_PRICE];
    NSString *qrlink = [user objectForKey:QR_LINK];
    NSString *shop_code = [user objectForKey:SHOP_CODE];
    if(sharetag==0)//微信好友
    {
        [MBProgressHUD hideHUDForView:self.view];
        
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSString *shopprice =[user objectForKey:SHOP_PRICE];
        NSString *shop_brand = [user objectForKey:SHOP_BRAND];
        NSString *realm = [user objectForKey:USER_ID];
        NSString *shop_name = [user objectForKey:SHOP_NAME];
        NSString *app_shop_group_price = [user objectForKey:@"app_shop_group_price"];

        if(shop_brand == nil || [shop_brand isEqualToString:@"(null)"] || [shop_brand isEqual:[NSNull null]])
        {
            shop_brand = @"衣蝠";
        }
        NSString *type2 = [user objectForKey:SHOP_TYPE2];
        MiniShareManager *minishare = [MiniShareManager share];
        
        NSString *image = [NSString stringWithFormat:@"%@%@!450",[NSObject baseURLStr_Upy],shop_pic];
        NSString *title = [minishare taskrawardHttp:type2 Price:shopprice Brand:shop_brand];
        NSString *path  = [NSString stringWithFormat:@"/pages/shouye/detail/detail?shop_code=%@&user_id=%@",shop_code,realm];
        
        minishare.delegate = self;
        
        //合成图片
        ProduceImage *pi = [[ProduceImage alloc] init];
        UIImage *baseImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]];
        UIImage *zhezhaoImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/shareCanvas_price.png"]]]];
        UIImage *afterImage = [pi getShareImage:zhezhaoImg WithBaseImg:baseImg WithPrice:app_shop_group_price];
        NSData *imageData = UIImageJPEGRepresentation(afterImage,0.8f);
        
        float length = [imageData length]/1024;
        NSLog(@"image length===%f",length);
        
        title= [NSString stringWithFormat:@"点击购买👆【%@】今日特价%.1f元！",shop_name,[app_shop_group_price floatValue]];
        [minishare shareAppImageWithType:MINIShareTypeWeixiSession Image:imageData Title:title Discription:nil WithSharePath:path];
        
    }else if (sharetag==1)//微信朋友圈
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [MBProgressHUD hideHUDForView:self.view];
            
            UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],shop_pic]]]];
//            [self.shareManager shareAppWithType:ShareTypeWeixiTimeline View:nil Image:shopimage WithShareType:@"newShare"];

//            UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],shop_pic]]]];
            if(shopimage == nil){
                NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                [mentionview showLable:@"数据获取异常" Controller:self];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                return ;
            }
            [MBProgressHUD hideHUDForView:self.view];
            
            UIImage *qrpicimage =[[UIImage alloc]init];
            //    直接创建二维码图像
            qrpicimage = [QRCodeGenerator qrImageForString:qrlink imageSize:165];
            
            NSData *data = UIImagePNGRepresentation(qrpicimage);
            NSString *st = [NSString stringWithFormat:@"%@/Documents/abc.png", NSHomeDirectory()];
            [data writeToFile:st atomically:YES];
            
            ProduceImage *pi = [[ProduceImage alloc] init];
            UIImage *newimg = [pi getImage:shopimage withQRCodeImage:qrpicimage withText:@"detail" withPrice:shopprice WithTitle:nil];
            
//            [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:newimg WithShareType:@"shopping"];

            int shareCount = [[user objectForKey:ShareCount] intValue];
            int shareType = shareCount %2==0?1:2;
            UIImage *pubImage;
            if(shareType == 1)//分享图片
            {
                pubImage = newimg;
            }else{
                pubImage = shopimage;
            }

            self.shareManager.taskValue = shareType;
            [self.shareManager shareAppWithType:ShareTypeWeixiTimeline View:nil Image:pubImage WithShareType:@"newShare"];

        });
        
    }else if (sharetag==2)//QQ空间
    {
        [MBProgressHUD hideHUDForView:self.view];
        UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],shop_pic]]]];
        [self.shareManager shareAppWithType:ShareTypeQQSpace View:nil Image:shopimage WithShareType:@"newShare"];
    }
    
}
- (void)shareSuccess:(BOOL)shareSuccess {
    kSelfWeak;
    [TaskSignModel getTaskHttp:[Signmanager SignManarer].share_indexid Day:[Signmanager SignManarer].share_day Success:^(id data) {
        TaskSignModel *model = data;
        if(model.status == 1)
        {
            if(shareSuccess)
            {
                if (self.TaskFinishBlock) {
                    self.TaskFinishBlock();
                }
            }
            [self invitBlock];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [self invitBlock];
        }
    }];
}
- (void)invitBlock
{
    if(self.ISInvit)//如果是邀请好友回到赚钱任务界面
    {
        for(UIViewController *vc in self.navigationController.viewControllers)
        {
            if([vc isKindOfClass:[MakeMoneyViewController class]]){
                [self.navigationController popToViewController:vc animated:YES];
                [DataManager sharedManager].InvitationSuccess = YES;
                return;
            }else if ([vc isKindOfClass:[ShopDetailViewController class]]){
                [self.navigationController popToViewController:vc animated:YES];
                [DataManager sharedManager].InvitationSuccess = YES;
                return;
            }
        }
    }
}
- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type {
    if(shareStatus != STATE_BEGAN){
        if (shareStatus == STATE_SUCCESS) {
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"分享成功" Controller:self];
            [self shareSuccess:YES];
           
        }else if (shareStatus == STATE_FAILED|| shareStatus==STATE_CANCEL) {
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"分享失败" Controller:self];
        }
    }
}

- (void)goShare:(NSInteger)tag imgUrl:(NSString *)imgUrl title:(NSString *)title link:(NSString *)link
{
    //    imgUrl = @"http://pic50.nipic.com/file/20141009/10453194_005943612000_2.jpg";
    //    title = @"明天会更好";
    //    link  = @"https://www.baidu.com";
    
    ShareType sharetype;
    switch (tag) {
        case 1:
            MyLog(@"微信朋友圈");
            sharetype = ShareTypeWeixiTimeline;
            break;
        case 0:
            MyLog(@"微信好友");
            sharetype = ShareTypeWeixiSession;
            break;
        case 2:
            MyLog(@"空间");
            sharetype = ShareTypeQQSpace;
            break;
            
        default:
            break;
    }
    

    [self.shareManager shareAppWithType:sharetype withLink:link andImagePath:imgUrl andContent:title];

    /*
    ShareModel *model = [[ShareModel alloc]init];
    switch (tag) {
        case 1:
            MyLog(@"微信朋友圈");
            model.sharetype = shareType_weixin_pyq;
            break;
        case 0:
            MyLog(@"微信好友");
            model.sharetype = shareType_weixin_hy;
            break;
        case 2:
            MyLog(@"空间");
            model.sharetype = shareType_qq_kj;
            break;
            
        default:
            break;
    }
    
    model.shareResultBlock = ^(NSInteger statue){
        switch (statue) {
            case 0:{
                [TaskSignModel getTaskHttp:[Signmanager SignManarer].share_indexid Day:[Signmanager SignManarer].share_day Success:^(id data) {
                }];
                [MBProgressHUD show:@"分享成功" icon:nil view:self.view];
            }
                break;
            case 1:
                [MBProgressHUD show:@"分享失败" icon:nil view:self.view];
                break;
            case 2:
                [MBProgressHUD show:@"分享取消" icon:nil view:self.view];
                break;
            default:
                break;
        }
        
    };
    [model goshare:model.sharetype ShareImage:imgUrl ShareTitle:title ShareLink:link];
    */
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {

    MyLog(@"%@ release",[self class]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark *************小程序分享****************
//小程序分享回调
- (void)MinihareManagerStatus:(MINISHARESTATE)shareStatus withType:(NSString *)type
{
    [MBProgressHUD hideHUDForView:self.view];
    
    NSString *sstt = @"";
    switch (shareStatus) {
        case MINISTATE_SUCCESS:
            [self shareSuccess:YES];
            break;
        case MINISTATE_FAILED:
            sstt = @"分享失败";
            break;
        case MINISTATE_CANCEL:
            sstt = @"分享取消";
            break;
        default:
            break;
    }
    if(shareStatus != MINISTATE_SUCCESS)
    {
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:sstt Controller:self];
    }
}
@end
