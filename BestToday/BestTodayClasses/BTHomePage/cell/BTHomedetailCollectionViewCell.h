//
//  BTHomedetailCollectionViewCell.h
//  BestToday
//
//  Created by leeco on 2017/11/22.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTHomeDetailLookEntity.h"

@interface BTHomedetailCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) UIImageView *imagePic;  // 图片

- (void)makeDetailRecomendCellData:(BTHomeDetailLookEntity *)lookEntity;


@end
