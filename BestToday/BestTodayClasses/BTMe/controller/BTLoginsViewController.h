//
//  BTLoginsViewController.h
//  BestToday
//
//  Created by leeco on 2017/11/16.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTViewController.h"

typedef  void(^callBackLoginIn)(NSString *fromViewController);

@interface BTLoginsViewController : BTViewController

@property (nonatomic, copy) callBackLoginIn loginCallBack;

@property (strong, nonatomic) IBOutlet UIButton *sureButton;

@end
