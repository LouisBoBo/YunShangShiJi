//
//  MemberViewModel.m
//  YunShangShiJi
//
//  Created by hebo on 2019/5/27.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "MemberViewModel.h"
#import "MemberModel.h"
#import "vipDataModel.h"
#import "uservipDataModel.h"
@implementation MemberViewModel
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.uservipList = [NSMutableArray array];
        self.vipList = [NSMutableArray array];
    }
    return self;
}

- (void)getVipData:(void(^)())success;
{
    kWeakSelf(self);
    [MemberModel getVipData:1 Success:^(id data) {
        MemberModel *model = data;
        if(model.status == 1)
        {
            self.vipList = [NSMutableArray arrayWithArray:model.vipdata];
            self.uservipList = [NSMutableArray arrayWithArray:model.uservipdata];
            self.raffle_money = model.raffle_money;
            self.bouns = model.bouns;
            if(model.uservipdata)
            {
                [weakself handlevipData:model.vipdata UserVipData:model.uservipdata];
            }
            if(success)
            {
                success();
            }
        }
    }];
}
- (void)addUserVipCard:(NSInteger)vipcount VipType:(NSInteger)viptype Success:(void(^)(id))success;
{
    [MemberModel addUserVipCard:vipcount VipType:viptype Success:^(id data) {
        MemberModel *model = data;
        if(model.status == 1)
        {
            if(success)
            {
                success(data);
            }
        }
    }];
}
- (void)addUserVipOrder:(NSString*)vipcode Success:(void(^)(id))success;
{
    [MemberModel addUserVipOrder:vipcode Success:^(id data) {
        MemberModel *model = data;
        if(model.status == 1)
        {
           if(success)
           {
               success(data);
           }
        }
    }];
}
- (void)handlevipData:(NSMutableArray*)vipList UserVipData:(NSMutableArray*)uservipList
{
    NSInteger selectIndex = 0;
    for(vipDataModel *vipmodel in vipList)
    {
        NSString *rulestr = [NSString string];
        NSMutableArray *markruleArr = [NSMutableArray array];
        NSString *vip_price = [NSString stringWithFormat:@"%@",vipmodel.vip_price];
        NSString *discount = [NSString stringWithFormat:@"%@",vipmodel.discount];
        NSString *price_section = [NSString stringWithFormat:@"%@",vipmodel.price_section];
        NSString *punch_days = [NSString stringWithFormat:@"%@",vipmodel.punch_days];
        NSString *return_money = [NSString stringWithFormat:@"%@",vipmodel.return_money];
        NSString *vip_name = [NSString stringWithFormat:@"%@",vipmodel.vip_name];
        if(vipmodel.vip_type.integerValue == 4 || vipmodel.vip_type.integerValue == 5)
        {
            rulestr = [NSString stringWithFormat:@"1.预存%@元可成为%@会员。\n2.预存款可全额用于购买商品。%@专享全商品%@折。\n3.赠送%@元无门槛购物券一张，可免费购买任意原价%@元以下商品。\n4.每日可免费领原价%@元以下任意1件商品9次,领中即发货。\n5.每月1次专业搭配师一对一服务。\n6.%@日后可返还%@元。\n",vip_price,vip_name,vip_name,discount,price_section,price_section,price_section,punch_days,return_money];
            markruleArr = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"预存%@元",vip_price],@"赠送",[NSString stringWithFormat:@"%@元",price_section],@"全额用于购买",@"9次",[NSString stringWithFormat:@"%@折",discount],return_money, nil];
        }else if (vipmodel.vip_type.integerValue == 6)
        {
            rulestr = [NSString stringWithFormat:@"1.预存%@元可成为%@会员。\n2.预存款可全额用于购买商品。%@专享全商品%@折。\n3.赠送%@元无门槛购物券一张，可免费购买任意原价%@元以下商品。\n4.%@会员每日不受价格限制免费领任意女装9次。60日内必免费领走1至5件女装。\n5.每月1次专业搭配师一对一服务。\n6.%@日后可返还%@元。\n",vip_price,vip_name,vip_name,discount,price_section,price_section,vip_name,punch_days,return_money];
            markruleArr = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"预存%@元",vip_price],@"赠送",[NSString stringWithFormat:@"%@元",price_section],@"全额用于购买",@"9次",[NSString stringWithFormat:@"%@折",discount],return_money,@"不受价格限制免费领",@"免费领走1至5件", nil];
        }
        vipmodel.ruledata = rulestr;
        vipmodel.markrule = [NSArray arrayWithArray:markruleArr];
        
        for(uservipDataModel *uservipmodel in uservipList)
        {
            if(vipmodel.vip_type == uservipmodel.vip_type)
            {
                vipmodel.arrears_price = uservipmodel.arrears_price;
                vipmodel.vip_balance = uservipmodel.vip_balance;
                vipmodel.vip_num = uservipmodel.vip_num;
                vipmodel.vip_code = uservipmodel.vip_code;
                vipmodel.num = uservipmodel.num;
                vipmodel.count = uservipmodel.count;
                vipmodel.context = uservipmodel.context;
                vipmodel.substance = uservipmodel.substance;
                
                self.max_vipTypeIndex = selectIndex;
                NSString *num0 = @"今日剩余免费领商品次数：";
                NSString *num1 = @"";
                NSString *num2 = @"";

                if(vipmodel.vip_code){
                    if(vipmodel.arrears_price.floatValue == 0 && vipmodel.num.integerValue > 0)//正常
                    {
                        num1 = [NSString stringWithFormat:@"%@件",vipmodel.num];
                        num2 = [NSString stringWithFormat:@"每件%@次",vipmodel.count];
                        if(vipmodel.vip_type.integerValue == 6)
                        {
                            vipmodel.ruledata = [NSString stringWithFormat:@"%@%@\n今日剩余免费领商品次数：\n%@任意价格商品,%@",rulestr,@"",num1,num2];
                        }else{
                            NSString *vip_price = [NSString stringWithFormat:@"%@",vipmodel.price_section];
                            num1 = [NSString stringWithFormat:@"%@件%@元",vipmodel.num,vip_price];
                            vipmodel.ruledata = [NSString stringWithFormat:@"%@%@\n今日剩余免费领商品次数：\n%@以下商品,%@",rulestr,@"",num1,num2];
                        }
                        
                    }else if (vipmodel.arrears_price.floatValue > 0)//欠费
                    {
                        num1 = @"此卡欠费";
                        vipmodel.ruledata = vipmodel.ruledata = [NSString stringWithFormat:@"%@%@\n今日剩余免费领商品次数：\n%@",rulestr,@"",num1];;
                        
                    }else if (vipmodel.count.integerValue == 0)//次数为0
                    {
                        num1 = @"0次";
                        vipmodel.ruledata = vipmodel.ruledata = [NSString stringWithFormat:@"%@%@\n今日剩余免费领商品次数：\n%@",rulestr,@"",num1];
                    }
                    
                    [markruleArr addObject:num0];
                    [markruleArr addObject:num1];
                    [markruleArr addObject:num2];
                    
                    vipmodel.markrule = [NSArray arrayWithArray:markruleArr];
                }
            }
        }
        
        selectIndex ++;
    }
}
@end