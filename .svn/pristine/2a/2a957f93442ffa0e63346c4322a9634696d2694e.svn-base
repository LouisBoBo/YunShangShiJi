//
//  TFAdditionalEvaluationViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/29.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFAdditionalEvaluationViewController.h"
#import "PageViewCollectionViewCell.h"
#import "TFPhotoView.h"
#import "TFCellView.h"
#import "DoImagePickerController.h"
#import "TFCustomCamera.h"
#import "FullScreenScrollView.h"
#import "UpYun.h"
#import "MyOrderViewController.h"

@interface TFAdditionalEvaluationViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate,UIActionSheetDelegate,TFCameraDelegate,DoImagePickerControllerDelegate>

{
    NSTimer *_timeoutTimer;
}

@property (nonatomic, assign)int index;
@property (nonatomic, strong)UIButton *commitBtn;
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)FullScreenScrollView *imgFullScrollView;

@property (nonatomic, strong) UIScrollView *backgroundScrollView;

@property (nonatomic, strong)UITextView *textView;
@property (nonatomic, strong)TFPhotoView *photoView;
@property (nonatomic, strong)UILabel *timeLabel;
@end

@implementation TFAdditionalEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super setNavigationItemLeft:@"追加评价"];
    
    [self dataInit];
    [self createUI];
    
}
- (void)dataInit
{
    //点击图片放大
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imgClick:) name:@"imgClickNoti" object:nil];
    //长按删除
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imgLongPClick:) name:@"imgLongPClickNoti" object:nil];
    
    NSArray *orderShopsArr = self.Ordermodel.shopsArray;
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
        if (oModel.orderShopStatus.intValue !=1 && !(oModel.orderShopStatus.intValue==3 && oModel.change.intValue==2)&&!(oModel.orderShopStatus.intValue==3 && oModel.change.intValue==3)) {
            [self.dataArr addObject:model];
        }
    }

    
    self.index = 0;
    
    for (int i = 0; i<self.dataArr.count; i++) {
        ScoreModel *sModel = [[ScoreModel alloc] init];
        sModel.commentText = @"亲,写点评价吧";
        [self.modelArr addObject:sModel];
    }
}
- (void)createUI
{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7+1, kScreenWidth, kScreenHeight-kNavigationheightForIOS7-1)];
    [self.view addSubview:_backgroundScrollView = scrollView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBACOLOR_F(0.5,0.5,0.5,0.3);
    [self.view addSubview:lineView];
    
    [self createCollectionView];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0,  self.collectionView.bottom+2, kScreenWidth, 400)];
//    self.bgView.backgroundColor = [UIColor yellowColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.bgView addGestureRecognizer:tap];
    
    [self.backgroundScrollView addSubview:self.bgView];
    
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commitBtn.frame = CGRectMake(ZOOM(62), self.bgView.frame.size.height-(20)-ZOOM(110), kScreenWidth-2*ZOOM(62), ZOOM(110));
    [self.commitBtn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
    [self.commitBtn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
    [self.commitBtn setTitle:@"发表评价" forState:UIControlStateNormal];
    self.commitBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
    //    [self.commitBtn setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.commitBtn];
    
    self.backgroundScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.bgView.frame));
    
    [self createView];

    [self refreshView:(self.modelArr[self.index])];
    
}
- (void)createView
{
    TFCellView *tcv = [[TFCellView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM(106))];
    [tcv.headImageView removeFromSuperview];
    tcv.titleLabel.frame = CGRectMake(ZOOM(62), 0, (100), tcv.frame.size.height);
    tcv.titleLabel.text = @"已评价";
    tcv.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    [tcv.detailImageView removeFromSuperview];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(tcv.frame.size.width-(150)-ZOOM(62), 0, (150), tcv.frame.size.height)];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.timeLabel.textColor = RGBACOLOR_F(0.5,0.5,0.5,0.6);
    [tcv addSubview:self.timeLabel];

    NSString *time = [self timeInfoWithDateSec:[self.Ordermodel.add_time doubleValue]/1000];
    self.timeLabel.text = time;
//    [self.bgView addSubview:tcv];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(62), 0, (150), (30))];
    label.textColor = RGBACOLOR_F(0.5,0.5,0.5,0.6);
    label.font = [UIFont systemFontOfSize:ZOOM(48)];
    label.text = @"追加评价";
    [self.bgView addSubview:label];
    
    CGFloat H = (60);

    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(ZOOM(62),  label.bottom+(10), kScreenWidth-2*ZOOM(62), H)];
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
    //    self.photoView.backgroundColor = [UIColor yellowColor];
    [self.photoView.addImageBtn addTarget:self action:@selector(addImageClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.photoView];
    UILabel *warnLabel =[[UILabel alloc] initWithFrame:CGRectMake(ZOOM(150), (ZOOM(100)-ZOOM(50))/2, ZOOM(350), ZOOM(50))];
    warnLabel.text = @"上传图片晒单哦!";
    warnLabel.tag = 10010;
    warnLabel.textColor = kTextColor;
    warnLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
    [self.photoView addSubview:warnLabel];
    
}

- (void)refreshView:(ScoreModel *)sModel
{
    [self.imgArr removeAllObjects];
    [self.imgArr addObjectsFromArray:sModel.imgArr];
  
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

#pragma mark - *****************提交按钮*****************
- (void)commitBtnClick:(UIButton *)sender
{

    ScoreModel *sModel = self.modelArr[self.index];
    sModel.commentText = self.textView.text;

    [sModel.imgArr removeAllObjects];
    [sModel.imgArr addObjectsFromArray:self.imgArr];

    [self.modelArr replaceObjectAtIndex:self.index withObject:sModel];

    if (self.dataArr.count == 1) {
        ScoreModel *sModel = self.modelArr[0];
        if ([sModel.commentText isEqualToString:@"亲,写点评价吧"]||sModel.commentText.length == 0) {
            [MBProgressHUD showError:@"亲,写点评价吧"];
        } else {
//            [MBProgressHUD showMessage:@"正在提交评论" toView:self.view];
            [MBProgressHUD showMessage:@"正在提交评论" afterDeleay:0 WithView:self.view];
            
            if ([_timeoutTimer isValid]) {
                [_timeoutTimer invalidate];
                _timeoutTimer = nil;
            }
            _timeoutTimer = [NSTimer weakTimerWithTimeInterval:3*60 target:self selector:@selector(timeoutFunc) userInfo:nil repeats:NO];
            
            [self httpSingleSubmitEvalution];
        }
        
    } else if (self.dataArr.count>1) {
        int i = 0;
//        int j = 0;
        for (i = 0 ; i<self.modelArr.count; i++) {
            ScoreModel *sModel = self.modelArr[i];
            if ([sModel.commentText isEqualToString:@"亲,写点评价吧"]||sModel.commentText.length == 0) {
                [MBProgressHUD showError:@"你还有商品未评价"];
                break;
//                j++;
            }
        }
        
        
        if (i == self.modelArr.count) {
//            [MBProgressHUD showMessage:@"正在提交评论" toView:self.view];
            [MBProgressHUD showMessage:@"正在提交评论" afterDeleay:0 WithView:self.view];
            
            if ([_timeoutTimer isValid]) {
                [_timeoutTimer invalidate];
            }
            _timeoutTimer = [NSTimer weakTimerWithTimeInterval:3*60 target:self selector:@selector(timeoutFunc) userInfo:nil repeats:NO];
            [self httpMoreSubmitEvalution];
            
        }
         
    }
}

- (void)httpSingleSubmitEvalution
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    ScoreModel *sModel = self.modelArr[self.index];
    
    if ([sModel.commentText isEqualToString:@"亲,写点评价吧"]) {
        sModel.commentText = @"";
    }
    
//    ShopDetailModel *oModel = self.Ordermodel.shopsArray[self.index];
    TFShopModel *oModel = self.dataArr[self.index];

    NSString *shop_code = oModel.shop_code;
    NSString *ID = [NSString stringWithFormat:@"%@",oModel.ID];
    NSString *order_code = self.Ordermodel.order_code;
    if (sModel.imgArr.count == 0) {
        NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@shopComment/appendCommentList?token=%@&version=%@&order_code=%@&jsonComment=",[NSObject baseURLStr],token,VERSION,order_code];
        NSMutableArray *muArr = [[NSMutableArray alloc] init];
        NSMutableDictionary *muDic = [[NSMutableDictionary alloc] init];
        [muDic setValue:sModel.commentText forKey:@"content"];
        [muDic setValue:ID forKey:@"id"];
        [muDic setValue:shop_code forKey:@"shop_code"];
        [muArr addObject:muDic];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:muArr options:0 error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [urlStr appendString:jsonStr];
        NSString *URL = [MyMD5 authkey:urlStr];
        //
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            //
//            responseObject = [NSDictionary changeType:responseObject];
            if (responseObject!=nil) {
                if ([responseObject[@"status"] intValue] == 1) {
                    [MBProgressHUD showSuccess:@"追加评价成功"];
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
        
    } else {
        
        for (int i = 0; i<sModel.imgArr.count; i++) {
            UIImage *img = sModel.imgArr[i];
            NSString *imgName = [self getSaveKeyWithShopCode:shop_code withDate:[self getDate] withSec:[self getTime] withCurrCount:i];
            //            //%@",imgName);
            [self uploadData:img withImgName:imgName withModelIndex:self.index];
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

    NSString *shop_code = oModel.shop_code;
    NSString *ID = oModel.ID;
    NSString *order_code = self.Ordermodel.order_code;
    NSString *pic = [sModel.imgNameArr componentsJoinedByString:@","];
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@shopComment/appendCommentList?token=%@&version=%@&order_code=%@&jsonComment=",[NSObject baseURLStr],token,VERSION,order_code];
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] init];
    [muDic setValue:sModel.commentText forKey:@"content"];
    [muDic setValue:ID forKey:@"id"];
    [muDic setValue:pic forKey:@"pic"];
    [muDic setValue:shop_code forKey:@"shop_code"];
    [muArr addObject:muDic];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:muArr options:0 error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [urlStr appendString:jsonStr];
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        //
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                [MBProgressHUD showSuccess:@"追加评价成功"];
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
            sModel.commentText = @"";
        }
        
    } if (k == 0) {

        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *token = [ud objectForKey:USER_TOKEN];
        NSString *order_code = self.Ordermodel.order_code;
        NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@shopComment/appendCommentList?token=%@&version=%@&order_code=%@&jsonComment=",[NSObject baseURLStr],token,VERSION,order_code];
        NSString *URL;
        NSMutableArray *muArr = [[NSMutableArray alloc] init];
        for (i = 0; i<self.modelArr.count; i++) {
//            ShopDetailModel *oModel = self.Ordermodel.shopsArray[i];
            TFShopModel *oModel = self.dataArr[i];

            NSString *shop_code = oModel.shop_code;
            ScoreModel *sModel = self.modelArr[i];
            NSMutableDictionary *muDic = [[NSMutableDictionary alloc] init];
            [muDic setValue:sModel.commentText forKey:@"content"];
            [muDic setValue:[NSString stringWithFormat:@"%@",oModel.ID] forKey:@"id"];
            [muDic setValue:shop_code forKey:@"shop_code"];
            [muArr addObject:muDic];
        }
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:muArr options:0 error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [urlStr appendString:jsonStr];
        
        URL = [MyMD5 authkey:urlStr];
        //        //
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            responseObject = [NSDictionary changeType:responseObject];
            if (responseObject!=nil) {
                if ([responseObject[@"status"] intValue] == 1) {
                    [MBProgressHUD showSuccess:@"追加评价成功"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshOrder" object:nil];

                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [MBProgressHUD showError:responseObject[@"message"]];
                }

            }
            
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
             
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
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@shopComment/appendCommentList?token=%@&version=%@&order_code=%@&jsonComment=",[NSObject baseURLStr],token,VERSION,order_code];
    NSString *URL;
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<self.modelArr.count; i++) {
//        ShopDetailModel *oModel = self.Ordermodel.shopsArray[i];
        TFShopModel *oModel = self.dataArr[i];

        NSString *shop_code = oModel.shop_code;
        ScoreModel *sModel = self.modelArr[i];
        NSString *pic = [sModel.imgNameArr componentsJoinedByString:@","];
        NSMutableDictionary *muDic = [[NSMutableDictionary alloc] init];
        [muDic setValue:sModel.commentText forKey:@"content"];
        [muDic setValue:[NSString stringWithFormat:@"%@",oModel.ID] forKey:@"id"];
        [muDic setValue:pic forKey:@"pic"];
        [muDic setValue:shop_code forKey:@"shop_code"];
        [muArr addObject:muDic];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:muArr options:0 error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [urlStr appendString:jsonStr];
    
    URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        //
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                [MBProgressHUD showSuccess:@"追加评价成功"];
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

#pragma mark - 上传到又拍云
- (void)uploadData:(UIImage *)image withImgName:(NSString *)imgName withModelIndex:(int)index
{
    UpYun *uy = [[UpYun alloc] init];
    ScoreModel *sModel = self.modelArr[index];
    
    UIImage *newImage = [self compressionImage:image];
    
    uy.successBlocker = ^(id data)
    {

        [sModel.imgNameArr addObject:imgName];
        
        [self.modelArr replaceObjectAtIndex:index withObject:sModel];
        
        ScoreModel *ssModel = self.modelArr[index];
        if (ssModel.imgNameArr.count >= ssModel.imgArr.count&&self.modelArr.count == 1) { //
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
    uy.progressBlocker = ^(CGFloat percent, long long requestDidSendBytes)
    {
        
    };
    [uy uploadFile:newImage saveKey:imgName];
}


- (NSString *)getSaveKeyWithShopCode:(NSString *)shopCode withDate:(NSString *)date withSec:(NSString *)sec withCurrCount:(int )curCount
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *User_id = [ud objectForKey:USER_ID];
    return [NSString stringWithFormat:@"shop_comment/%@/%@/additional/%@%@-%d.png",shopCode,date,sec,User_id,curCount];
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


- (void)addImageClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (self.imgArr.count == 3) {
        [MBProgressHUD showError:@"最多插入三张图片,您可长按删除"];
    } else {

        UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册获取", nil];
        [actionsheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {
        //拍照");
        
        [self performSelector:@selector(choosePhoto) withObject:nil afterDelay:0.5];
        
        
    } else if (buttonIndex == 1) {
        //图库");
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
//    camera.MaxImageNum = 3-self.imgArr.count;   //最多图片数量
//    [self.navigationController pushViewController:camera animated:YES];
}
#pragma mark TFcamera Delegate
- (void)SelectPhotoEnd:(TFCustomCamera *)Manager WithPhotoArray:(NSArray *)PhotoArray
{

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


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    ScoreModel *sModel = self.modelArr[self.index];
    if (kDevice_Is_iPhone4) {
        [UIView animateWithDuration:0.8 animations:^{
            self.backgroundScrollView.contentOffset = CGPointMake(0, 100);
        }];
    } else if (kDevice_Is_iPhone5) {
        [UIView animateWithDuration:0.8 animations:^{
            self.backgroundScrollView.contentOffset = CGPointMake(0, 100);
        }];
    } else if (kDevice_Is_iPhone6) {
        [UIView animateWithDuration:0.8 animations:^{
            self.backgroundScrollView.contentOffset = CGPointMake(0, 120);
        }];
    } else if (kDevice_Is_iPhone6Plus) {
        [UIView animateWithDuration:0.8 animations:^{
            self.backgroundScrollView.contentOffset = CGPointMake(0, 0);
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
- (void)textViewDidEndEditing:(UITextView *)textView
{
     ScoreModel *sModel = self.modelArr[self.index];
    sModel.commentText = textView.text;
    [self.modelArr replaceObjectAtIndex:self.index withObject:sModel];
}
- (void)createCollectionView
{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    

    layout.itemSize = CGSizeMake(kScreenWidth, ZOOM(350));

    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    layout.minimumLineSpacing = 0;
    

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM(350)) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = YES;

    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, ZOOM(350));

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = YES;
    self.collectionView.tag = 200;
    [self.backgroundScrollView addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PageViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PAGERVIEWID"];
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
    sModel.commentText = self.textView.text;

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
- (void)tapClick:(UITapGestureRecognizer *)tap
{
    [self.bgView endEditing:YES];
    [UIView animateWithDuration:0.8 animations:^{
        self.backgroundScrollView.contentOffset = CGPointMake(0, 0);
    }];
}
#pragma mark - 计算时间
- (NSString *)timeInfoWithDateSec:(double )time
{
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *showtimeNew = [formatter stringFromDate:oldDate];
    
    return [NSString stringWithFormat:@"%@",[showtimeNew substringToIndex:16]];
}

- (void)imgClick:(NSNotification *)note
{

    //放大图片
    UIView *window = [[UIApplication sharedApplication].delegate window];
    self.imgFullScrollView = [[FullScreenScrollView alloc] initWithPicutreArray:self.imgArr withCurrentPage:[note.object intValue]];
    
    self.imgFullScrollView.backgroundColor = [UIColor blackColor];
    [window addSubview:self.imgFullScrollView];
}

- (void)imgLongPClick:(NSNotification *)note
{
    //长按");
    
    if (self.imgArr.count > [note.object intValue]) {
        [self.imgArr removeObjectAtIndex:[note.object intValue]];
    }
    
    [self.photoView receiveImageArray:self.imgArr];
    UILabel *wlabel = (UILabel *)[self.view viewWithTag:10010];
    wlabel.frame = CGRectMake(CGRectGetMaxX(self.photoView.addImageBtn.frame)+ZOOM(30), (ZOOM(100)-ZOOM(50))/2, ZOOM(350), ZOOM(50));
}
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

//提交评价超时
- (void)timeoutFunc
{
    [_timeoutTimer invalidate];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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
