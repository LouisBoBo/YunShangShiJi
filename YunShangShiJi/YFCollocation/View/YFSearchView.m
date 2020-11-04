//
//  YFSearchView.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFSearchView.h"
#import "GlobalTool.h"
#import "UIImageView+WebCache.h"
#import "FMDBSearchManager.h"

@interface YFSearchView ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar; //搜索
@property (nonatomic, strong) UITableView *searchTableView; //目录

@end

@implementation YFSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGBCOLOR_I(22,22,22);
        [self addSubview:self.searchBar];
        [self addSubview:self.searchTableView];
    }
    return self;
}

/// 手势
- (void)swipeGRClick:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self.searchBar resignFirstResponder];
        if (self.delegate&&[self.delegate respondsToSelector:@selector(searchViewDirectionLeft)]) {
            [self.delegate searchViewDirectionLeft];
        }
    }
}

/// 刷新页面
- (void)reloadData {
    [self.searchTableView reloadData];
    self.searchBar.text = @"";
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *text = searchBar.text;
    [self.searchBar resignFirstResponder];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(searchViewSearchString:)]) {
        [self.delegate searchViewSearchString:text];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.text = @"";
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(numberOfSectionsInSearchView:)]) {
        return [self.delegate numberOfSectionsInSearchView:self];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, ZOOM(80))];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(62), 0, tableView.frame.size.width - ZOOM(62), ZOOM(80))];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = RGBCOLOR_I(167,167,167);
    label.backgroundColor = RGBCOLOR_I(22,22,22);
    label.font = kFont6px(32);
    [view addSubview:label];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(searchView:titleForHeaderInSection:)]) {
        label.text = [self.delegate searchView:self titleForHeaderInSection:section];
    }
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(searchView:numberOfRowsInSection:)]) {
        return [self.delegate searchView:self numberOfRowsInSection:section];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return ZOOM(80);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ZOOM(150);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLID"];
        cell.backgroundColor = RGBCOLOR_I(22,22,22);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(ZOOM(62), (CGRectGetHeight(cell.frame)-ZOOM(100))/2, ZOOM(67), ZOOM(100))];
        iv.tag = 500;
        [cell.contentView addSubview:iv];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(iv.frame.origin.x+iv.frame.size.width+ZOOM(62), 0, ZOOM(300), CGRectGetHeight(cell.frame))];
        titleLabel.tag = 501;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = kFont6px(34);
        [cell.contentView addSubview:titleLabel];
        
        UIImageView *iiv = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-ZOOM(62)-ZOOM(27), (CGRectGetHeight(cell.frame)-ZOOM(55))/2, ZOOM(27), ZOOM(55))];
        iiv.image = [UIImage imageNamed:@"搜索更多"];
        iiv.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:iiv];
    }
    UIImageView *iv = (UIImageView *)[cell.contentView viewWithTag:500];
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:501];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(searchView:itemForRowAtIndexPath:)]) {
        ShopTypeItem *item = [self.delegate searchView:self itemForRowAtIndexPath:indexPath];
        [iv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], item.ico]]];
        titleLabel.text = item.type_name;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar resignFirstResponder];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(searchView:didSelectRowAtIndexPath:)]) {
        [self.delegate searchView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - getter
- (UISearchBar *)searchBar {
    if (nil == _searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(ZOOM(30), 0, self.frame.size.width-ZOOM(30)*2-2, 44)];
        _searchBar.barTintColor = RGBCOLOR_I(22,22,22);
        _searchBar.placeholder = @"搜索";
        _searchBar.delegate = self;
        
        for (UIView *searchBarSubview in [_searchBar subviews]) {
            if ([searchBarSubview conformsToProtocol:@protocol(UITextInputTraits)]) {
                // Before iOS 7.0
                @try {
                    [(UITextField *)searchBarSubview setReturnKeyType:UIReturnKeySearch];
                }
                @catch (NSException * e) {
                }
            } else {
                // iOS 7.0
                for(UIView *subSubView in [searchBarSubview subviews]) {
                    if([subSubView conformsToProtocol:@protocol(UITextInputTraits)]) {
                        @try {
                            [(UITextField *)subSubView setReturnKeyType:UIReturnKeyDone];
                        }
                        @catch (NSException * e) {
                        }
                    }
                }
            }
        }

    }
    return _searchBar;
}

- (UITableView *)searchTableView {
    if (nil == _searchTableView) {
        _searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, self.frame.size.height-(self.searchBar.frame.size.height))];
        _searchTableView.delegate = self;
        _searchTableView.dataSource = self;
        _searchTableView.scrollsToTop = NO;
        _searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _searchTableView.backgroundColor = RGBCOLOR_I(22,22,22);
        
        UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGRClick:)];
        swipeGR.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.searchTableView addGestureRecognizer:swipeGR];
    }
    return _searchTableView;
}

@end
