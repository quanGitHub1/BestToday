//
//  BTSpreadTableView.m
//  BestToday
//
//  Created by leeco on 2017/11/6.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTSpreadTableView.h"
#import "BTRecomendUserTableViewCell.h"
#import "BTMeViewController.h"
#import "BTGoodRecommentViewController.h"

@interface BTSpreadTableView()<UITableViewDataSource,UITableViewDelegate, UIGestureRecognizerDelegate>
{
    NSMutableArray *_cellArr;
    
    NSInteger _indexSection;
    
    UIView *_headerView;
    
    UIImageView *_headerImageView;
    
    UILabel *_LabelPrice;
    
    UIImageView *_tagImage;
}

@end

@implementation BTSpreadTableView


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style withType:(BTSpreadTableViewStyle)type
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        
        self.type = type;
        _dataArr = [[NSArray alloc] init];
        _cellArr = [[NSMutableArray alloc] initWithCapacity:10];
        
        // 把tableview翻转
        CGFloat xOffset = (frame.size.height - frame.size.width)/2.0f;
        CGAffineTransform transform0 = CGAffineTransformMakeTranslation(xOffset, -xOffset);
        CGAffineTransform transform1 = CGAffineTransformRotate(transform0, -M_PI_2);
        self.transform = transform1;
        
        _dateAll = [NSArray array];
        
    }
    return self;
}

// 刷新数据
- (void)refreshData:(NSArray *)data
{
    if (data) {
        
        self.dataArr = data;
        
    }
}

- (void)setDataArr:(NSArray *)dataArr
{
    if (_dataArr != dataArr) {
        _dataArr = dataArr;
        [self reloadData];
    }
}


- (void)tapPushAction:(UITapGestureRecognizer *)tap{

  
    
}

/** 点击查看更多 */
- (void)onClickBtns:(UIButton *)btn{
    
    if (_spreadDelegate && [_spreadDelegate respondsToSelector:@selector(spreadTableViewDidSelectMore)]) {
        [_spreadDelegate spreadTableViewDidSelectMore];
    }
}

#pragma mark - UITableViewDataSource

// 增加cell
- (void)addCell
{
    if (_cellArr.count > 0) {
        [_cellArr removeAllObjects];
    }
    

    for (int i = 0; i < _dataArr.count; i++) {
        
        UITableViewCell *cell = nil;
        
        switch (self.type) {
                
            case BTSpreadTableViewStyleImageText:
            {
                cell = [[BTRecomendUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [(BTRecomendUserTableViewCell *)cell makeEditCellData:[_dataArr objectAtIndex:i]];
                
                // 把cell添加进去
                [_cellArr addObject:cell];
            }
                break;
                
            default:
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                
                [_cellArr addObject:cell];

            }
                break;
                
        }
        
    }
}

#pragma mark -- tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    [self addCell];
    
    return [_dataArr count];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 这步最为关键，把cell翻转
        UITableViewCell *cell = [_cellArr objectAtIndex:indexPath.row];
        cell.transform = CGAffineTransformMakeRotation(M_PI_2);
        
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /**
      这个高度是横向单个cell的宽度
     */
    return ScaleHeight(80);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == BTSpreadTableViewStyleImageText) {
        
        BTHomeUserEntity *userEntity = [_dataArr objectAtIndex:indexPath.row];
        
        if ([userEntity.jumpType isEqualToString:@"2"]) {
            
            BTGoodRecommentViewController *recomment = [[BTGoodRecommentViewController alloc] init];
            
            recomment.userId = userEntity.userId;
            
            [[self viewController].navigationController pushViewController:recomment animated:YES];

            
        }else {
        
            BTMeViewController *meView = [[BTMeViewController alloc] init];
            
            meView.userId = userEntity.userId;
            
            meView.otherId = YES;
            
            [[self viewController].navigationController pushViewController:meView animated:YES];
        }
        
        
    }
    
}


//获取View所在的Viewcontroller方法
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if ([_spreadDelegate respondsToSelector:@selector(spreadTableViewContentOffset:)]) {
        
        [_spreadDelegate spreadTableViewContentOffset:scrollView.contentOffset.y];
    }
    
}

@end
