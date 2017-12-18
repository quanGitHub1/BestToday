//
//  BTAttentionTableViewCell.m
//  BestToday
//
//  Created by leeco on 2017/11/15.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTAttentionTableViewCell.h"
#import "BTAttention.h"
#import "BTMeViewController.h"

#define cellHeight 65

@implementation BTAttentionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imageAvtar = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, ScaleWidth(40), ScaleHeight(40))];
        
        
        _imageAvtar.backgroundColor = [UIColor whiteColor];
        
        _imageAvtar.layer.cornerRadius = _imageAvtar.size.width * 0.5;
        
        _imageAvtar.clipsToBounds = YES;
        
        _imageAvtar.userInteractionEnabled = YES;
        
        //创建手势 使用initWithTarget:action:的方法创建
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        
        //设置属性
        tap.numberOfTouchesRequired = 1;
        
        tap.delegate = self;
        
        //别忘了添加到testView上
        [_imageAvtar addGestureRecognizer:tap];

        
        _labName = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#212121" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:16] bkColor:nil frame:CGRectMake(_imageAvtar.right + 15, (cellHeight - 20)/2 + 2, 200, 20)];
        
        _labName.userInteractionEnabled = YES;
        
        //创建手势 使用initWithTarget:action:的方法创建
        UITapGestureRecognizer *tapLab = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewName:)];
        
        tapLab.delegate = self;
        
        [_labName addGestureRecognizer:tapLab];
        
        _btnAttention = [[UIButton alloc] initWithFrame:CGRectMake(FULL_WIDTH - 75, (cellHeight - 26)/2 + 2, 60, 26)];
        
        _btnAttention.layer.borderColor = [UIColor colorWithHexString:@"#969696"].CGColor;
        
        _btnAttention.layer.borderWidth = 1;
        
        _btnAttention.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_btnAttention setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];
        
        _btnAttention.layer.cornerRadius = 1.5;
        
        [_btnAttention addTarget:self action:@selector(onclickBtnAtten:) forControlEvents:UIControlEventTouchUpInside];

        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 64.4, FULL_WIDTH, 0.6)];
        
        viewLine.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        
        [self.contentView addSubview:_imageAvtar];
        
        [self.contentView addSubview:_labName];
        
        [self.contentView addSubview:_btnAttention];
        
        [self.contentView addSubview:viewLine];
        
    }
    return self;
}

- (void)makeCellData:(BTUserEntity *)meEntity{
    
    self.meEntitys = meEntity;

    _labName.text = meEntity.nickName;
    
    [_imageAvtar sd_setImageWithURL:[NSURL URLWithString:meEntity.avatarUrl] placeholderImage:nil];
    
    if ([meEntity.isFollowed integerValue] == 0) {
        
        [_btnAttention setTitle:@"+关注" forState:UIControlStateNormal];

    }else {
    
        [_btnAttention setTitle:@"已关注" forState:UIControlStateNormal];

    }
    
}

- (void)onclickBtnAtten:(UIButton *)btn{
    
    if ([btn.titleLabel.text isEqualToString:@"+关注"]) {
        
        [BTAttention requestFollowUser:self.meEntitys.userId success:^(BOOL isSuccess) {
            
            [_btnAttention setTitle:@"已关注" forState:UIControlStateNormal];

            
        } faild:^(BOOL failure) {
            
            
            
        }];
        
    }else {
        
        [BTAttention requestUnFollowUser:self.meEntitys.userId success:^(BOOL isSuccess) {
            
            [_btnAttention setTitle:@"+关注" forState:UIControlStateNormal];

            
        } faild:^(BOOL failure) {
            
            
            
        }];
    }
    
}

/** 点击啊头像 */
- (void)tapView:(UITapGestureRecognizer*)gesTap{
    
    BTMeViewController *meView = [[BTMeViewController alloc] init];
    
    meView.userId = self.meEntitys.userId;
    
    meView.otherId = YES;
    
    [[self viewController].navigationController pushViewController:meView animated:YES];
    
}

/** 点击姓名 */
- (void)tapViewName:(UITapGestureRecognizer*)gesTap{
    
    BTMeViewController *meView = [[BTMeViewController alloc] init];
    
    meView.userId = self.meEntitys.userId;
    
    meView.otherId = YES;
    
    [[self viewController].navigationController pushViewController:meView animated:YES];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
