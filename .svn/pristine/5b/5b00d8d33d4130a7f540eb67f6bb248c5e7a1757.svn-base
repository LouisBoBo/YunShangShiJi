//
//  PopoverView.h
//  ArrowView
//
//  Created by guojiang on 4/9/14.
//  Copyright (c) 2014年 LINAICAI. All rights reserved.
//


#import <UIKit/UIKit.h>
@class PopoverView;

@protocol  PopoverViewDelegate <NSObject>

@optional

- (void)seletRowAtIndex:(PopoverView *)popoverView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)dismissPopverView:(PopoverView *)popverView ;

@end


@interface PopoverView : UIView

-(id)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)imageArr withSceenWith:(CGFloat )sceenWith popWith:(CGFloat)popwith cellTextFont:(CGFloat)cellTextFont;
-(void)show;
-(void)dismiss;
-(void)dismiss:(BOOL)animated;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, copy) UIColor *borderColor;
@property (nonatomic, copy) void (^selectRowAtIndex)(NSInteger index);

@property(nonatomic, assign) CGFloat sceenWith;

@property(nonatomic, weak) id<PopoverViewDelegate> delegate;

@property(nonatomic, assign) CGFloat popWith;

@property(nonatomic, assign) CGFloat cellTextFont;

@property (nonatomic , strong) dispatch_block_t dismissblock;
@end
