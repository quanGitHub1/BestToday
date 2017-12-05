//
//  BTAttentionTableViewCell.h
//  BestToday
//
//  Created by leeco on 2017/11/15.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTUserEntity.h"

@interface BTAttentionTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *labName;// 名字

@property(nonatomic,strong)UIImageView *imageAvtar; //

@property(nonatomic,strong)UIButton *btnAttention; //

- (void)makeCellData:(BTUserEntity*)meEntity;

@end
