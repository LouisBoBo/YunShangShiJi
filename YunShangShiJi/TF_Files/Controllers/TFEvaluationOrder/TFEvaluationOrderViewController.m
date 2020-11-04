//
//  TFEvaluationOrderViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/23.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFEvaluationOrderViewController.h"
#import "TFTitleView.h"
#import "TFShopModel.h"
#import "PageViewCollectionViewCell.h"
#import "ShopDetailModel.h"
#import "RatingBar.h"

#import "CameraVC.h"
#import "DoImagePickerController.h"
#import "FullScreenScrollView.h"
#import "UpYun.h"
#import "MyOrderViewController.h"

#import "TFCustomCamera.h"
@interface TFEvaluationOrderViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate,UIActionSheetDelegate,TFCameraDelegate,DoImagePickerControllerDelegate,CameraDelegate>

{
    NSTimer *_timeoutTimer;
}

@property (nonatomic, assign)int index;
@property (nonatomic, strong)UIButton *commitBtn;
@property (nonatomic, strong)UIView *bgView;

@property (nonatomic, strong)NSArray *titleArr;
@property (nonatomic, strong)UITextView *textView;
@property (nonatomic, strong)RatingBar *startRb;
@property (nonatomic, strong)TFPhotoView *photoView;

@property (nonatomic, strong)FullScreenScrollView *imgFullScrollView;


@property (nonatomic, copy)NSString *starCount;

@property (nonatomic, assign)BOOL colorBl;
@property (nonatomic, assign)BOOL styleBl;
@property (nonatomic, assign)BOOL makeBl;
@property (nonatomic, assign)BOOL priceBl;

@property (nonatomic, strong)NSMutableArray *imgArr;
@property (nonatomic, assign)int type;

@property (nonatomic, strong)UIScrollView *scroller;

@end

@implementation TFEvaluationOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self dataInit];
    [self createUI];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, Height_NavBar)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [super setNavigationItemLeft:@"评价订单"];
    
    
}

- (void)dataInit
{
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(starttap:) name:@"starttap" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startpan:) name:@"startpan" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imgClick:) name:@"imgClickNoti" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imgLongPClick:) name:@"imgLongPClickNoti" object:nil];
    
    NSArray *orderShopsArr = self.Ordermodel.shopsArray;
    
    //orderShopsArr = %@", orderShopsArr);
    
    
    for (ShopDetailModel *oModel in orderShopsArr) {
        TFShopModel *model = [[TFShopModel alloc] init];
        model.ID = [NSNumber numberWithInt:[oModel.ID intValue]];
        model.color = oModel.shop_color;
        model.shop_code = oModel.shop_code;
        model.shop_price = [NSNumber numberWithDouble:[oModel.shop_price doubleValue]];
        model.status = oModel.status;
        model.shop_pic = oModel.shop_pic;
        model.supp_id = [NSNumber numberWithInt:[oModel.suppid intValue]];
        model.shop_num = [NSNumber numberWithInt:[oModel.shop_num intValue]];
        model.order_code = oModel.order_code;
        model.size = oModel.shop_size;
        model.shop_name = oModel.shop_name;
        
        if(oModel.orderShopStatus.intValue !=1 &&!(oModel.orderShopStatus.intValue==3 && oModel.change.intValue==2)&& !(oModel.orderShopStatus.intValue==3 && oModel.change.intValue==3) && oModel.status.intValue!=5)
            [self.dataArr addObject:model];
    }
    

    
    self.index = 0;

    for (int i = 0; i<self.dataArr.count; i++) {
        ScoreModel *sModel = [[ScoreModel alloc] init];
        sModel.starCount = @"5";
        sModel.colorBl = YES;
        sModel.styleBl = YES;
        sModel.makeBl = YES;
        sModel.priceBl = YES;
        sModel.commentText = @"亲,写点评价吧";
        sModel.type = 3;
        [self.modelArr addObject:sModel];
    }

    self.titleArr = [NSArray arrayWithObjects:@"总评价",@"没有色差",@"版型漂亮",@"做工不错",@"性价比高", nil];
}

- (void)createUI
{
    self.scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.scroller.scrollEnabled = NO;
    if (kDevice_Is_iPhone4) {
        self.scroller.scrollEnabled = YES;
        self.scroller.contentSize = CGSizeMake(0, 510);
    }
    
    [self.view addSubview:self.scroller];
    
    TFTitleView *ttv = [[TFTitleView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7-20, kScreenWidth, (30))];
    ttv.titleLabel.frame = CGRectMake(15, 0, CGRectGetWidth(ttv.frame)-15, CGRectGetHeight(ttv.frame));
    ttv.titleLabel.text = @"评价商品";
    ttv.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
    ttv.backgroundColor = [UIColor whiteColor];
    [self.scroller addSubview:ttv];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,  ttv.bottom, kScreenWidth, 1)];
    lineView.backgroundColor = RGBACOLOR_F(0.5,0.5,0.5,0.3);
    [self.scroller addSubview:lineView];
    
    //创建collectionView
    [self createCollectionView:lineView];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0,  self.collectionView.bottom+5, kScreenWidth, kScreenHeight- self.collectionView.bottom-1-2)];
    //self.bgView.backgroundColor = [UIColor yellowColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.bgView addGestureRecognizer:tap];
    
    [self.scroller addSubview:self.bgView];
    
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commitBtn.frame = CGRectMake(ZOOM(60), self.bgView.frame.size.height-ZOOM(40)-ZOOM(110)-ZOOM(60), kScreenWidth-2*ZOOM(60), ZOOM(110));
    if (kDevice_Is_iPhone4) {
        self.commitBtn.frame = CGRectMake(ZOOM(60), self.bgView.frame.size.height-ZOOM(110)+10, kScreenWidth-2*ZOOM(60), ZOOM(110));
    }
    if (kDevice_Is_iPhone5) {
        self.commitBtn.frame = CGRectMake(ZOOM(60), self.bgView.frame.size.height-2*ZOOM(115), kScreenWidth-2*ZOOM(60), ZOOM(110));
    }
    [self.commitBtn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
    [self.commitBtn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
    [self.commitBtn setTitle:@"发表评价" forState:UIControlStateNormal];
    self.commitBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
//    [self.commitBtn setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.commitBtn];

    [self createView];

    //后面要打开
//    [self refreshView:(self.modelArr[self.index])];
    
}

- (void)createView
{
    for (int i = 0; i<self.titleArr.count; i++) {
        if (i == 0) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(60), 0, (70), (35))];
            
            label.tag = 300+i;
            label.text = self.titleArr[i];
            label.font = [UIFont systemFontOfSize:ZOOM(46)];
            [self.bgView addSubview:label];
        } else {
            UILabel *ll = (UILabel *)[self.bgView viewWithTag:300];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(60),  ll.bottom+(i-1)*ll.frame.size.height, (80), ll.frame.size.height)];
            
            label.tag = 300+i;
            label.text = self.titleArr[i];
            label.font = [UIFont systemFontOfSize:ZOOM(46)];
            [self.bgView addSubview:label];
        }
    }
    
    UILabel *ll = (UILabel *)[self.bgView viewWithTag:300+4];
    
//    CGFloat H = (self.bgView.frame.size.height- ll.bottom-(40)-(10)*3-(35)-(20));
    
    CGFloat H = (self.bgView.frame.size.height- ll.bottom-(40)-(10)*3-(35)-(20)-80);
    if (kDevice_Is_iPhone4) {
        H = 50;
    }
    if(kDevice_Is_iPhone5)
    {
        H = 70;
    }
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(ZOOM(60),  ll.bottom+(10), kScreenWidth-2*ZOOM(60), H)];
    self.textView.tag = 201;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = (5);
    self.textView.layer.borderColor = [[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.3] CGColor];
    self.textView.layer.borderWidth = 1;
    self.textView.font = [UIFont systemFontOfSize:ZOOM(46)];
    self.textView.delegate = self;
    self.textView.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.4];
    self.textView.scrollEnabled = YES;
    [self.bgView addSubview:self.textView];
    

    self.photoView = [[TFPhotoView alloc] initWithFrame:CGRectMake(self.textView.frame.origin.x,  self.textView.bottom+(10), self.textView.frame.size.width, ZOOM(100))];
    
    UILabel *warnLabel =[[UILabel alloc] initWithFrame:CGRectMake(ZOOM(150), (ZOOM(100)-ZOOM(50))/2, ZOOM(350), ZOOM(50))];
    warnLabel.text = @"上传图片晒单哦!";
    warnLabel.tag = 10010;
    warnLabel.textColor = kTextColor;
    warnLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
    [self.photoView addSubview:warnLabel];
//    self.photoView.backgroundColor = [UIColor yellowColor];
    [self.photoView.addImageBtn addTarget:self action:@selector(addImageClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.photoView];
    

    CGFloat M = 40;
    
    if (kDevice_Is_iPhone4||kDevice_Is_iPhone5) {
        M = 40;
    } else if (kDevice_Is_iPhone6) {
        M = 40;
    } else if (kDevice_Is_iPhone6Plus) {
        M = 38;
    }
    
    UILabel *labee = (UILabel *)[self.bgView viewWithTag:300];
    
    self.startRb = [[RatingBar alloc] initWithFrame:CGRectMake( ll.right+M, 0, ZOOM(67)*5+ZOOM(33)*6, ZOOM(67))];
    self.startRb.center = CGPointMake(self.startRb.center.x, labee.center.y);
//    self.startRb.backgroundColor = [UIColor yellowColor];
    [self.bgView addSubview:self.startRb];
    
    
    
    for (int i = 0; i<4; i++) {
        UILabel *ll2 = (UILabel *)[self.bgView viewWithTag:300+1+i];
        for (int j= 0 ; j<2; j++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(j*(15)+ ll2.right+j*(60)+(50), ll2.frame.origin.y+(5), ZOOM(60), ZOOM(60));
            if (kDevice_Is_iPhone4) {
                 btn.frame = CGRectMake(j*(15)+ ll2.right+j*(60)+(50), ll2.frame.origin.y+(8), ZOOM(60), ZOOM(60));
            }
            btn.tag = (i+1)*10+j;
            [btn setBackgroundImage:[UIImage imageNamed:@"否"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"是"] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.bgView addSubview:btn];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( btn.right+(10), btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height)];
            
            label.font = [UIFont systemFontOfSize:ZOOM(46)];
            if (j == 0) {
                label.text = @"是";
            } else {
                label.text = @"否";
            }
            [self.bgView addSubview:label];
            
        }
    }
}

- (void)refreshView:(ScoreModel *)sModel
{
    self.starCount = sModel.starCount;
    self.colorBl = sModel.colorBl;
    self.styleBl = sModel.styleBl;
    self.makeBl = sModel.makeBl;
    self.priceBl = sModel.priceBl;
    [self.imgArr removeAllObjects];
    [self.imgArr addObjectsFromArray:sModel.imgArr];
    
    if ([sModel.starCount intValue]<=2) {
        self.type = 3;
    } else if ([sModel.starCount intValue] == 3||[sModel.starCount intValue] == 4) {
        self.type = 2;
    } else if ([sModel.starCount intValue] == 5) {
        self.type = 1;
    }

    [self.startRb setStarNumber:[self.starCount intValue]];


    [self setChooseBtn:self.colorBl withFlag:0];
    [self setChooseBtn:self.styleBl withFlag:1];
    [self setChooseBtn:self.makeBl withFlag:2];
    [self setChooseBtn:self.priceBl withFlag:3];
    

    if ([sModel.commentText isEqualToString:@"亲,写点评价吧"]){
        self.textView.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.4];
    } else {
        self.textView.textColor = [UIColor blackColor];
    }
    self.textView.text = sModel.commentText;
    
    [self.photoView receiveImageArray:self.imgArr];
    UILabel *wlabel = (UILabel *)[self.view viewWithTag:10010];
    wlabel.frame = CGRectMake(CGRectGetMaxX(self.photoView.addImageBtn.frame)+ZOOM(30), (ZOOM(100)-ZOOM(50))/2, ZOOM(350), ZOOM(50));
    
}

- (void)addImageClick:(UIButton *)sender
{
    if (self.imgArr.count == 3) {
        [MBProgressHUD showError:@"最多插入三张图片,您可长按删除"];
    } else {
        [self.view endEditing:YES];
        [UIView animateWithDuration:0.3 animations:^{
            _scroller.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        }];
        UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册获取", nil];
        [actionsheet showInView:self.view];
    }
}

#pragma mark - *****************提交按钮*****************
- (void)commitBtnClick:(UIButton *)sender
{

    ScoreModel *sModel = self.modelArr[self.index];
    sModel.starCount = self.starCount;
    sModel.colorBl = self.colorBl;
    sModel.styleBl = self.styleBl;
    sModel.makeBl = self.makeBl;
    sModel.priceBl = self.priceBl;
    sModel.commentText = self.textView.text;
    sModel.type = self.type;

    [sModel.imgArr removeAllObjects];
    [sModel.imgArr addObjectsFromArray:self.imgArr];

    [self.modelArr replaceObjectAtIndex:self.index withObject:sModel];

    if (self.dataArr.count == 1) {
        ScoreModel *sModel = self.modelArr[0];
        
//        int starCount = [sModel.starCount intValue];    //星星颗数
        
        if (([sModel.commentText isEqualToString:@"亲,写点评价吧"])||(sModel.commentText.length == 0)) {
            [MBProgressHUD showError:@"请写评论内容"];
            
        } else {

//            [MBProgressHUD showMessage:@"正在提交评论" toView:self.view];
            [MBProgressHUD showMessage:@"正在提交评论" afterDeleay:0 WithView:self.view];
            
            
            if ([_timeoutTimer isValid]) {
                [_timeoutTimer invalidate];
            }
            _timeoutTimer = [NSTimer weakTimerWithTimeInterval:60*1 target:self selector:@selector(timeoutFunc) userInfo:nil repeats:NO];
            
            
            [self httpSingleSubmitEvalution];
        }
    } else if (self.dataArr.count>1) {
        int i = 0;
        for (i = 0 ; i<self.modelArr.count; i++) {
            ScoreModel *sModel = self.modelArr[i];
            
//            int starCount = [sModel.starCount intValue];    //星星颗数
            
            if (([sModel.commentText isEqualToString:@"亲,写点评价吧"])||(sModel.commentText.length == 0)) {
                    [MBProgressHUD showError:@"你还有商品未评价"];
                break;
            }
        } if (i == self.modelArr.count) {
//            [MBProgressHUD showMessage:@"正在提交评论" toView:self.view];
            [MBProgressHUD showMessage:@"正在提交评论" afterDeleay:0 WithView:self.view];
            
            if ([_timeoutTimer isValid]) {
                [_timeoutTimer invalidate];
            }
            _timeoutTimer = [NSTimer weakTimerWithTimeInterval:60*1 target:self selector:@selector(timeoutFunc) userInfo:nil repeats:NO];
            
            [self httpMoreSubmitEvalution];
        }
    }
}

- (void)httpSingleSubmitEvalution
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    ScoreModel *sModel = self.modelArr[self.index];
//    ShopDetailModel *oModel = self.Ordermodel.shopsArray[self.index];
    ShopDetailModel *oModel = self.dataArr[self.index];
    NSString *shop_code = oModel.shop_code;
    NSString *order_code = self.Ordermodel.order_code;
    NSString *ID = oModel.ID;
    
    if ([sModel.commentText isEqualToString:@"亲,写点评价吧"]) {
        sModel.commentText = @"默认好评";
    }
    
    NSString *urlStr;
    NSString *URL;
    if (sModel.imgArr.count == 0) { //没有图片
        urlStr = [NSString stringWithFormat:@"%@shopComment/addShopComment?token=%@&version=%@&id=%@&content=%@&comment_type=%d&ordercode=%@&star=%@&color=%d&type=%d&work=%d&cost=%d",[NSObject baseURLStr],token,VERSION,ID,sModel.commentText,sModel.type,order_code,sModel.starCount,sModel.colorBl,sModel.styleBl,sModel.makeBl,sModel.priceBl];
        
        URL = [MyMD5 authkey:urlStr];
//        //
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = 60;
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
//            responseObject = [NSDictionary changeType:responseObject];
            if (responseObject!=nil) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([responseObject[@"status"] intValue] == 1) {
                    [MBProgressHUD showSuccess:@"评价成功"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshOrder" object:nil];

                    for (UIViewController *controller in self.navigationController.viewControllers) {
                        if ([controller isKindOfClass:[MyOrderViewController class]]) {
                            [self.navigationController popToViewController:controller animated:YES];
                            return ;
                        }
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    
                } else {
                    [MBProgressHUD showError:responseObject[@"message"]];
                }
            }
  
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }];
        
    } else {    //有图片

        for (int i = 0; i<sModel.imgArr.count; i++) {
            UIImage *img = sModel.imgArr[i];
            NSString *imgName = [self getSaveKeyWithShopCode:shop_code withDate:[self getDate] withSec:[self getTime] withCurrCount:i];

            [self uploadData:img withImgName:imgName withModelIndex:self.index]; //上传
        }
    }
}

- (void)httpSingleImgUpYunFinish
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    ScoreModel *sModel = self.modelArr[self.index];
//    ShopDetailModel *oModel = self.Ordermodel.shopsArray[self.index];
    ShopDetailModel *oModel = self.dataArr[self.index];
    NSString *order_code = self.Ordermodel.order_code;
    NSString *ID = oModel.ID;
    NSString *urlStr;
    NSString *URL;
    NSString *pic = [sModel.imgNameArr componentsJoinedByString:@","];
    urlStr = [NSString stringWithFormat:@"%@shopComment/addShopComment?token=%@&version=%@&id=%@&content=%@&comment_type=%d&ordercode=%@&star=%@&color=%d&type=%d&work=%d&cost=%d&pic=%@",[NSObject baseURLStr],token,VERSION,ID,sModel.commentText,sModel.type,order_code,sModel.starCount,sModel.colorBl,sModel.styleBl,sModel.makeBl,sModel.priceBl,pic];
    
    URL = [MyMD5 authkey:urlStr];
//    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 60;
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MyLog(@"responseObject: %@", responseObject);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                [MBProgressHUD showSuccess:@"评价成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshOrder" object:nil];

                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
          [MBProgressHUD hideHUDForView:self.view animated:YES];
          NavgationbarView *mentionview=[[NavgationbarView alloc]init];
          [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}

- (void)httpMoreSubmitEvalution
{
    int i = 0;
    int j = 0;
    int k = 0;
    for (i = 0; i<self.modelArr.count; i++) {
        ScoreModel *sModel = self.modelArr[i];
        for (j = 0; j<sModel.imgArr.count; j++) {
            k++;
        }
        
        if ([sModel.commentText isEqualToString:@"亲,写点评价吧"]) {
            sModel.commentText = @"默认好评";
        }
        
    } if (k == 0) {

        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *token = [ud objectForKey:USER_TOKEN];
        NSString *order_code = self.Ordermodel.order_code;
        NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@shopComment/addShopCommentList?token=%@&version=%@&ordercode=%@&jsonComment=",[NSObject baseURLStr],token,VERSION,order_code];
        NSString *URL;
        NSMutableArray *muArr = [[NSMutableArray alloc] init];
        for (i = 0; i<self.modelArr.count; i++) {
//            ShopDetailModel *oModel = self.Ordermodel.shopsArray[i];
            
            TFShopModel *oModel = self.dataArr[i];
            ScoreModel *sModel = self.modelArr[i];
            NSMutableDictionary *muDic = [[NSMutableDictionary alloc] init];
            [muDic setValue:sModel.starCount forKey:@"star"];
            [muDic setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:sModel.colorBl]] forKey:@"color"];
            [muDic setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:sModel.styleBl]] forKey:@"type"];
            [muDic setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:sModel.makeBl]] forKey:@"work"];
            [muDic setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:sModel.priceBl]] forKey:@"cost"];
            [muDic setValue:sModel.commentText forKey:@"content"];
            [muDic setValue:[NSNumber numberWithInt:sModel.type] forKey:@"comment_type"];
            [muDic setValue:oModel.ID forKey:@"id"];
            [muArr addObject:muDic];
        }
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:muArr options:0 error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [urlStr appendString:jsonStr];
        
        URL = [MyMD5 authkey:urlStr];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = 60;
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
//            responseObject = [NSDictionary changeType:responseObject];
            if (responseObject!=nil) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([responseObject[@"status"] intValue] == 1) {
                    [MBProgressHUD showSuccess:@"评价成功"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshOrder" object:nil];

                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [MBProgressHUD showError:responseObject[@"message"]];
                }

            }
            
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NavgationbarView *mentionview=[[NavgationbarView alloc]init];
             [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }];
    } else {

        for (i = 0; i<self.modelArr.count; i++) {
            ScoreModel *sModel = self.modelArr[i];
            TFShopModel *tModel = self.dataArr[i];
            NSString *shop_code = tModel.shop_code;
            for (j = 0; j<sModel.imgArr.count; j++) {
                UIImage *img = sModel.imgArr[j];
                NSString *imgName = [self getSaveKeyWithShopCode:shop_code withDate:[self getDate] withSec:[self getTime] withCurrCount:j];
//                //imgName = %@",imgName);
                [self uploadData:img withImgName:imgName withModelIndex:i];
            }
        }
    }
}

- (void)httpMoreImgUpYunFinish
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *order_code = self.Ordermodel.order_code;
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@shopComment/addShopCommentList?token=%@&version=%@&ordercode=%@&jsonComment=",[NSObject baseURLStr],token,VERSION,order_code];
    NSString *URL;
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<self.modelArr.count; i++) {
//        ShopDetailModel *oModel = self.Ordermodel.shopsArray[i];
        TFShopModel *oModel = self.dataArr[i];
        ScoreModel *sModel = self.modelArr[i];
        NSString *pic = [sModel.imgNameArr componentsJoinedByString:@","];
        NSMutableDictionary *muDic = [[NSMutableDictionary alloc] init];
        [muDic setValue:sModel.starCount forKey:@"star"];
        [muDic setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:sModel.colorBl]] forKey:@"color"];
        [muDic setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:sModel.styleBl]] forKey:@"type"];
        [muDic setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:sModel.makeBl]] forKey:@"work"];
        [muDic setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:sModel.priceBl]] forKey:@"cost"];
        [muDic setValue:sModel.commentText forKey:@"content"];
        [muDic setValue:[NSNumber numberWithInt:sModel.type] forKey:@"comment_type"];          [muDic setValue:oModel.ID forKey:@"id"];
        [muDic setValue:pic forKey:@"pic"];
        [muArr addObject:muDic];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:muArr options:0 error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [urlStr appendString:jsonStr];
    
    URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 60;
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                [MBProgressHUD showSuccess:@"评价成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshOrder" object:nil];

                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}
- (void)uploadData:(UIImage *)image withImgName:(NSString *)imgName withModelIndex:(int)index
{
    UpYun *uy = [[UpYun alloc] init];
    ScoreModel *sModel = self.modelArr[index];
    
//    UIImage *newImage = [self compressionImage:image];
    
    //压缩图片
    
    NSInteger fileSize = 0;
    if (kDevice_Is_iPhone4||kDevice_Is_iPhone5) {
        fileSize = 40;
    } else {
        fileSize = 25;
    }
    
    UIImage *newImage = [self compressImage:image toMaxFileSize:fileSize];
    
    uy.successBlocker = ^(id data)
    {

        
        [sModel.imgNameArr addObject:imgName];

        [self.modelArr replaceObjectAtIndex:index withObject:sModel];
        
        ScoreModel *ssModel = self.modelArr[index];
        if (ssModel.imgNameArr.count == ssModel.imgArr.count&&self.modelArr.count == 1) { //
            MyLog(@"上传完成");
            [self httpSingleImgUpYunFinish];
        } else if (self.modelArr.count>1) {
            int i = 0;
            int k = 0;
            for (i = 0; i<self.modelArr.count; i++) {
                ScoreModel *sssModel = self.modelArr[i];
                if (sssModel.imgNameArr.count == sssModel.imgArr.count) {
                    k++;
                }
            } if (k == self.modelArr.count) {
                MyLog(@"上传完成");
                [self httpMoreImgUpYunFinish];
            }
            
        }
    };
    uy.failBlocker = ^(NSError * error)
    {
        NSString *message = [error.userInfo objectForKey:@"message"];
        [MBProgressHUD showError:message];
        //error = %@",error);
    };
    uy.progressBlocker = ^(CGFloat percent, long long requestDidSendBytes) {
        
    };
    [uy uploadFile:newImage saveKey:imgName];
}

- (NSString *)getSaveKeyWithShopCode:(NSString *)shopCode withDate:(NSString *)date withSec:(NSString *)sec withCurrCount:(int )curCount
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *User_id = [ud objectForKey:USER_ID];
    return [NSString stringWithFormat:@"shop_comment/%@/%@/%@%@-%d.png",shopCode,date,sec,User_id,curCount];
}

- (NSString *)getTime
{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    double i = time;
    return [NSString stringWithFormat:@"%.0f",i];
}

- (NSString *)getDate
{
    NSDate *curDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *showCurDate = [formatter stringFromDate:curDate];
    return showCurDate;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {

        [self performSelector:@selector(choosePhoto) withObject:nil afterDelay:0.5];
        
        
    } else if (buttonIndex == 1) {

        DoImagePickerController *doimg = [[DoImagePickerController alloc] init];
        doimg.delegate = self;
        doimg.nColumnCount = 3;
        doimg.nResultType = DO_PICKER_RESULT_UIIMAGE;
        doimg.nMaxCount = 3-self.imgArr.count;
        [self presentViewController:doimg animated:YES completion:nil];
    }
}
- (void)choosePhoto
{
    TFCustomCamera *tcvc = [[TFCustomCamera alloc] init];
    tcvc.maxPhotoCount = 3-(int)self.imgArr.count;
    tcvc.delegate = self;
    [self.navigationController pushViewController:tcvc animated:NO];
//    CameraVC *camera=[[CameraVC alloc] init];
//    camera.delegate = self;
//    camera.MaxImageNum = 3-self.imgArr.count;
//    [self.navigationController pushViewController:camera animated:YES];
}

- (void)SelectPhotoEnd:(TFCustomCamera *)Manager WithPhotoArray:(NSArray *)PhotoArray
{
    //PhotoArray = %@",PhotoArray);
    for (UIImage *img in PhotoArray) {
        [self.imgArr addObject:img];
    }
    [self.photoView receiveImageArray:self.imgArr];
    UILabel *wlabel = (UILabel *)[self.view viewWithTag:10010];
    wlabel.frame = CGRectMake(CGRectGetMaxX(self.photoView.addImageBtn.frame)+ZOOM(30), (ZOOM(100)-ZOOM(50))/2, ZOOM(350), ZOOM(50));

}
#pragma mark - DoImagePickerControllerDelegate
- (void)didCancelDoImagePickerController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected
{
    //aSelected = %@",aSelected);
    
    for (UIImage *img in aSelected) {
        [self.imgArr addObject:img];
    }
    [self.photoView receiveImageArray:self.imgArr];
    UILabel *wlabel = (UILabel *)[self.view viewWithTag:10010];
    wlabel.frame = CGRectMake(CGRectGetMaxX(self.photoView.addImageBtn.frame)+ZOOM(30), (ZOOM(100)-ZOOM(50))/2, ZOOM(350), ZOOM(50));
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 coclor - flag = 0
 style - flag = 1
 make - flag = 2
 price - flag = 3
 */
- (void)setChooseBtn:(BOOL)bl withFlag:(int)flag
{
    UIButton *btn1 = (UIButton *)[self.bgView viewWithTag:((flag+1)*10)+0];
    UIButton *btn2 = (UIButton *)[self.bgView viewWithTag:((flag+1)*10)+1];
    if (bl == YES) {
        btn1.selected = YES;
        btn2.selected = NO;
    } else {
        btn1.selected = NO;
        btn2.selected = YES;
    }

}

- (void)chooseBtnClick:(UIButton *)sender
{
    if (sender.tag<12&&sender.tag>=10) {
        for (int i = 0; i<2; i++) {
            UIButton *btn = (UIButton *)[self.bgView viewWithTag:10+i];
            btn.selected = NO;
            if (sender.tag == 10+i) {
                btn.selected = YES;
                if (sender.tag%2 == 1) {
                    self.colorBl = NO;
                } else {
                    self.colorBl = YES;
                }
            }
        }
    } else if (sender.tag<22&&sender.tag>=20) {
        for (int i = 0; i<2; i++) {
            UIButton *btn = (UIButton *)[self.bgView viewWithTag:20+i];
            btn.selected = NO;
            if (sender.tag == 20+i) {
                btn.selected = YES;
                if (sender.tag%2 == 1) {
                    self.styleBl = NO;
                } else {
                    self.styleBl = YES;
                }
            }
        }
    } else if (sender.tag<32&&sender.tag>=30) {
        for (int i = 0; i<2; i++) {
            UIButton *btn = (UIButton *)[self.bgView viewWithTag:30+i];
            btn.selected = NO;
            if (sender.tag == 30+i) {
                btn.selected = YES;
                if (sender.tag%2 == 1) {
                    self.makeBl = NO;
                } else {
                    self.makeBl = YES;
                }
            }
        }
    } else if (sender.tag<42&&sender.tag>=40) {
        for (int i = 0; i<2; i++) {
            UIButton *btn = (UIButton *)[self.bgView viewWithTag:40+i];
            btn.selected = NO;
            if (sender.tag == 40+i) {
                btn.selected = YES;
                if (sender.tag%2 == 1) {
                    self.priceBl = NO;
                } else {
                    self.priceBl = YES;
                }
            }
        }
    }
    
    ScoreModel *sModel = self.modelArr[self.index];
    sModel.colorBl = self.colorBl;
    sModel.styleBl = self.styleBl;
    sModel.makeBl = self.makeBl;
    sModel.priceBl = self.priceBl;
    [self.modelArr replaceObjectAtIndex:self.index withObject:sModel];
    
}

-(void)starttap:(NSNotification*)note
{
    self.starCount = [NSString stringWithFormat:@"%@",note.object];

    ScoreModel *sModel = self.modelArr[self.index];
    sModel.starCount = self.starCount;
    [self.modelArr replaceObjectAtIndex:self.index withObject:sModel];
    
}

-(void)startpan:(NSNotification*)note
{
    self.starCount = [NSString stringWithFormat:@"%@",note.object];

    ScoreModel *sModel = self.modelArr[self.index];
    sModel.starCount = self.starCount;
    [self.modelArr replaceObjectAtIndex:self.index withObject:sModel];
}

- (void)imgClick:(NSNotification *)note
{

    UIView *window = [[UIApplication sharedApplication].delegate window];
    self.imgFullScrollView = [[FullScreenScrollView alloc] initWithPicutreArray:self.imgArr withCurrentPage:[note.object intValue]];
    
    self.imgFullScrollView.backgroundColor = [UIColor blackColor];
    [window addSubview:self.imgFullScrollView];
}

- (void)imgLongPClick:(NSNotification *)note
{

    if (self.imgArr.count > [note.object intValue]) {
        [self.imgArr removeObjectAtIndex:[note.object intValue]];
    }
    
    [self.photoView receiveImageArray:self.imgArr];
    UILabel *wlabel = (UILabel *)[self.view viewWithTag:10010];
    wlabel.frame = CGRectMake(CGRectGetMaxX(self.photoView.addImageBtn.frame)+ZOOM(30), (ZOOM(100)-ZOOM(50))/2, ZOOM(350), ZOOM(50));
}

#pragma mark - CollectionView相关
- (void)createCollectionView:(UIView *)lineView
{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    

    layout.itemSize = CGSizeMake(kScreenWidth, ZOOM(350));

    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,  lineView.bottom, kScreenWidth, ZOOM(350)) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = YES;

    self.collectionView.frame = CGRectMake(0,  lineView.bottom, kScreenWidth, ZOOM(350));

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = YES;
    self.collectionView.tag = 200;
    [self.scroller addSubview:self.collectionView];
    

    [self.collectionView registerNib:[UINib nibWithNibName:@"PageViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PAGERVIEWID"];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0,  self.collectionView.bottom, kScreenWidth, 1)];
    lineView1.backgroundColor = RGBACOLOR_F(0.5,0.5,0.5,0.3);
    
    [self.scroller addSubview:lineView1];
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth, ZOOM(350));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArr count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    PageViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PAGERVIEWID" forIndexPath:indexPath];
    [cell receiveDataModel:self.dataArr[indexPath.row]];
    
    return cell;
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{

    [self.textView resignFirstResponder];

    ScoreModel *sModel = self.modelArr[self.index];
    
    sModel.starCount = self.starCount;
    sModel.colorBl = self.colorBl;
    sModel.styleBl = self.styleBl;
    sModel.makeBl = self.makeBl;
    sModel.priceBl = self.priceBl;
    sModel.commentText = self.textView.text;
    sModel.type = self.type;
    

    [sModel.imgArr removeAllObjects];
    [sModel.imgArr addObjectsFromArray:self.imgArr];

    [self.modelArr replaceObjectAtIndex:self.index withObject:sModel];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 200) {
        
        self.index = scrollView.contentOffset.x/kScreenWidth;
        

        [self refreshView:self.modelArr[self.index]];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    ScoreModel *sModel = self.modelArr[self.index];
    if (kDevice_Is_iPhone4) {
        [UIView animateWithDuration:0.3 animations:^{
            _scroller.frame = CGRectMake(0, -160-32, kScreenWidth, kScreenHeight);
        }];
    } else if (kDevice_Is_iPhone5) {
        [UIView animateWithDuration:0.3 animations:^{
            _scroller.frame = CGRectMake(0, -190-32, kScreenWidth, kScreenHeight);
        }];
    } else if (kDevice_Is_iPhone6) {
        [UIView animateWithDuration:0.3 animations:^{
            _scroller.frame = CGRectMake(0, -175-32, kScreenWidth, kScreenHeight);
        }];
    } else if (kDevice_Is_iPhone6Plus) {
        [UIView animateWithDuration:0.3 animations:^{
            _scroller.frame = CGRectMake(0, -175-32, kScreenWidth, kScreenHeight);
        }];
    }
    
    if ([sModel.commentText isEqualToString:@"亲,写点评价吧"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        sModel.commentText = textView.text;
        [self.modelArr replaceObjectAtIndex:self.index withObject:sModel];
        return YES;
    } else {
        return YES;
    }
}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    [self.bgView endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        _scroller.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
}
- (UIImage *)compressionImage:(UIImage *)img
{
    CGSize imagesize = img.size;

    imagesize.height = imagesize.height/kImageSizeCompression;
    imagesize.width = imagesize.width/kImageSizeCompression;

    UIImage *newImg = [self imageWithImage:img scaledToSize:imagesize];

    NSData *imageData = UIImageJPEGRepresentation(newImg, kImageCompression);
    return [UIImage imageWithData:imageData];
}


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

- (NSData *)dataWithImageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return UIImageJPEGRepresentation(newImage, kImageCompression);
}

#pragma mark - 懒加载
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (NSMutableArray *)modelArr
{
    if (_modelArr == nil) {
        _modelArr = [[NSMutableArray alloc] init];
    }
    return  _modelArr;
}

- (NSMutableArray *)imgArr
{
    if (_imgArr == nil) {
        _imgArr = [[NSMutableArray alloc] init];
    }
    return _imgArr;
}

//屏幕转换函数
- (float)heightCoefficient:(float)height
{
    if (ThreeAndFiveInch) {
        return height*0.845;
    } else if (FourInch) {
        return height*1;
    } else if (FourAndSevenInch) {
        return height*1.174;
    } else if (FiveAndFiveInch) {
        return height*1.296;
    } else {
        return height*1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//提交评价超时
- (void)timeoutFunc
{
    [_timeoutTimer invalidate];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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
