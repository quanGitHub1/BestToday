//
//  BTMeMessageCell.h
//  BestToday
//
//  Created by 王卓 on 2017/11/17.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTMessageEntity.h"
#import "BTMessageUserEntity.h"

@interface BTMeMessageCell : UITableViewCell

- (void)setDataForCell:(BTMessageEntity *)entity;


@end
