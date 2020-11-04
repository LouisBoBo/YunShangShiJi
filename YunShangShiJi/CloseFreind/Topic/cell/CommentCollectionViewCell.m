//
//  CommentCollectionViewCell.m
//  TestStickHeader
//
//  Created by ios-1 on 2017/2/15.
//  Copyright © 2017年 liqi. All rights reserved.
//

#import "CommentCollectionViewCell.h"
#import "TopicPublicModel.h"
#import "ReplyTableViewCell.h"
#import "LreplistModel.h"
#import "GlobalTool.h"

@implementation CommentCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headimge.layer.cornerRadius = self.headimge.frame.size.width/2;
    self.headimge.image = [UIImage imageNamed:@"girl"];
    self.headimge.clipsToBounds = YES;
    
    self.vipico.frame = CGRectMake(CGRectGetMaxX(self.headimge.frame)-ZOOM6(30),CGRectGetMaxY(self.headimge.frame)-ZOOM6(30), ZOOM6(30), ZOOM6(30));
   
    self.name.textColor = RGBCOLOR_I(62, 62, 62);
    self.name.font = [UIFont systemFontOfSize:ZOOM6(30)];
    
    self.time.textColor = RGBCOLOR_I(125, 125, 125);
    self.time.font = [UIFont systemFontOfSize:ZOOM6(24)];
    
//    self.discription.textColor = RGBCOLOR_I(62, 62, 62);
//    self.discription.font = [UIFont systemFontOfSize:ZOOM6(30)];
    
    self.FabulousBtn.selected = NO;
    [self.FabulousBtn setImage:[UIImage imageNamed:@"topic_icon_zan-"] forState:UIControlStateNormal];
    [self.FabulousBtn setImage:[UIImage imageNamed:@"topic_icon_zan_pre"] forState:UIControlStateSelected];
    self.FabulousBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.FabulousBtn addTarget:self action:@selector(fabulousClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.fabulousNum.frame = CGRectMake(CGRectGetMaxX(self.FabulousBtn.frame),CGRectGetMinY(self.FabulousBtn.frame), ZOOM6(100), CGRectGetHeight(self.FabulousBtn.frame));
    self.fabulousNum.textColor = RGBCOLOR_I(168, 168, 168);
    self.fabulousNum.font = [UIFont systemFontOfSize:ZOOM6(24)];
    
}

- (void)refreshData:(LastCommentsModel*)model Indexpath:(NSIndexPath*)indexPath
{
    self.topicModel = model;
    self.curruntIndexPath = indexPath;
    
    //加V
    self.vipico.layer.masksToBounds = YES;
    self.vipico.layer.cornerRadius = ZOOM6(30) * 0.5;
    self.vipico.hidden=model.v_ident.integerValue==0;
    self.vipico.image=model.v_ident.integerValue==1?[UIImage imageNamed:@"V_red"]:[UIImage imageNamed:@"V_blue"];

    //点赞数
    NSURL *url = nil;
    if ([model.head_pic hasPrefix:@"http"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.head_pic]];
    } else {
        if ([model.head_pic hasPrefix:@"/"]) {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],[model.head_pic substringFromIndex:1]]];
        } else {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.head_pic]];
        }
    }
    [self.headimge sd_setImageWithURL:url];
    
    //是否点赞
    self.FabulousBtn.selected = model.comments_applaud_status.boolValue;
    if(model.user_id.intValue == model.base_user_id.intValue)
    {
        model.nickname = @"楼主";
    }
    if(model.nickname.length > 8)
    {
        model.nickname = [model.nickname substringToIndex:8];
    }
    self.name.text = [NSString stringWithFormat:@"%@",model.nickname];
    NSString *location = (model.location!=nil && model.location.length>0)?model.location:@"来自喵星";
    if(location.length > 8 )
    {
        location = [location stringByReplacingOccurrencesOfString:@" " withString:@""];
        location = [NSString stringWithFormat:@"%@...",[location substringToIndex:8]];
    }

    NSString *date = [MyMD5 themecompareCurrentTime:model.send_time];
    if(!date)
    {
        date = [MyMD5 timeWithTimeIntervalString:model.send_time];
    }
    self.time.text = [NSString stringWithFormat:@"%@   %@",location,date];
    self.fabulousNum.text = [NSString stringWithFormat:@"%d",(int)model.applaud_num];
    self.fabulousNum.textColor=self.FabulousBtn.selected?tarbarrossred:RGBCOLOR_I(168, 168, 168);
    
    [self.tableView removeFromSuperview];
    [self creatTableview];
    
    [self.spaceLine removeFromSuperview];
    [self creatSpaceLine];
    [self creatData:model];

}
- (void)creatData:(LastCommentsModel*)model
{
    for(int i =0;i<model.replies_list.count;i++)
    {
        LreplistModel *Replymodel = model.replies_list[i];
        
        if(Replymodel.status.intValue==0 || (Replymodel.status.intValue == 1 && Replymodel.receive_user_id.intValue == Replymodel.send_user_id.intValue))
        {
            [self.replyDataArray addObject:Replymodel];
        }

//        [self.replyDataArray addObject:Replymodel];
    }
    [self.tableView reloadData];
}
- (void)creatTableview
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = CGRectMake(CGRectGetMinX(self.headimge.frame), CGRectGetMaxY(self.headimge.frame)+ZOOM6(20), CGRectGetWidth(self.frame)-2*CGRectGetMinX(self.headimge.frame), self.topicModel.replyCellHeigh+self.topicModel.replyHeadHeigh+ZOOM6(20));
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [self creatTableHeadView];
    [self.contentView addSubview:self.tableView];

    [self.tableView registerNib:[UINib nibWithNibName:@"ReplyTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

- (void)creatSpaceLine
{
    self.spaceLine = [[UILabel alloc]init];
    self.spaceLine.frame = CGRectMake(0, self.frame.size.height-1, kScreenWidth, 0.5);
    self.spaceLine.backgroundColor = RGBCOLOR_I(229, 229, 229);
    [self.contentView addSubview:self.spaceLine];
}
- (UIView*)creatTableHeadView
{
    UILabel *headlab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.topicModel.replyHeadHeigh)];
    headlab.text = self.topicModel.content;
    headlab.numberOfLines = 0;
    headlab.textColor = RGBCOLOR_I(62, 62, 62);
    headlab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    return headlab;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topicModel.replies_list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    LreplistModel *Replymodel = self.topicModel.replies_list[indexPath.row];
    if(Replymodel.cellheigh)
    {
        return Replymodel.cellheigh;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LreplistModel *Replymodel = self.topicModel.replies_list[indexPath.row];
        
    if([self.delegate respondsToSelector:@selector(didselect:Indexpath:)]){
        
        [self.delegate didselect:Replymodel Indexpath:self.curruntIndexPath];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell = [[ReplyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.backgroundColor = RGBCOLOR_I(248, 248, 248);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LreplistModel *model = self.topicModel.replies_list[indexPath.row];
    model.base_user_id = self.topicModel.base_user_id;
    [cell refreshData:model];
    
    return cell;
}

- (void)fabulousClick:(UIButton*)sender
{
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    if(token.length >8)
    {
        kSelfWeak;
        if(sender.selected)//取消点赞
        {
            [TopicPublicModel DisThumbstData:2 This_id:self.topicModel.comment_id Theme_id:self.topicModel.theme_id Success:^(id data) {
                TopicPublicModel *model = data;
                if(model.status == 1)
                {
                    sender.selected = !sender.selected;
                    if([weakSelf.fabulousNum.text intValue] >0)
                    {
                        weakSelf.fabulousNum.text = [NSString stringWithFormat:@"%d",weakSelf.fabulousNum.text.intValue -1];
                        weakSelf.fabulousNum.textColor=sender.selected?tarbarrossred:RGBCOLOR_I(168, 168, 168);
                    }
                }
            }];
        }else{//点赞
            [TopicPublicModel ThumbstData:2 This_id:weakSelf.topicModel.comment_id Theme_id:weakSelf.topicModel.theme_id Success:^(id data) {
                TopicPublicModel *model = data;
                if(model.status == 1)
                {
                    sender.selected = !sender.selected;
                    weakSelf.fabulousNum.text = [NSString stringWithFormat:@"%d",weakSelf.fabulousNum.text.intValue +1];
                    weakSelf.fabulousNum.textColor=sender.selected?tarbarrossred:RGBCOLOR_I(168, 168, 168);
                }
                
            }];
        }

    }else{
        
        if([self.delegate respondsToSelector:@selector(fabulous:Indexpath:)]){
            
            [self.delegate fabulous:nil Indexpath:self.curruntIndexPath];
        }

    }
}

- (NSMutableArray*)replyDataArray
{
    if(_replyDataArray == nil)
    {
        _replyDataArray = [NSMutableArray array];
    }
    return _replyDataArray;
}
@end
