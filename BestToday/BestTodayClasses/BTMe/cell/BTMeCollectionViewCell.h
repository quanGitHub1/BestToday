//
//  BTMeCollectionViewCell.h
//  BestToday
//
//  Created by leeco on 2017/11/10.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTMeResourceVoList.h"

@interface BTMeCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) UIImageView *imagePic;  // 图片


- (void)makeLiveFiannceCellData:(BTMeResourceVoList *)resourceVolist;


@end
