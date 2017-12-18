//
//  BTMeEditInforViewController.h
//  BestToday
//
//  Created by leeco on 2017/11/10.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTViewController.h"

typedef void(^updateInforBlock)(NSString *nikeName, NSString *introduction, UIImage *picAvtar);

@interface BTMeEditInforViewController : BTViewController

@property (nonatomic, strong)NSString *nikeName;

@property (nonatomic, strong)NSString *introduction;

@property (nonatomic, strong)UIImage *picAvtar;

@property (nonatomic, copy) updateInforBlock updateInforBlock;

@property (nonatomic, strong) NSString *uploadCategoryId;
@property (nonatomic, strong) NSString *uploadtagId;
@property (nonatomic, strong) NSString *uploadtagName;


@end
