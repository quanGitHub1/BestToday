//
//  MLTCollectionView+MLTBrokenNetwork.h
//  AMCustomer
//
//  Created by 恺撒 on 2016/10/27.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "MLTCollectionView.h"

@interface MLTCollectionView (MLTBrokenNetwork)

/*
 *  10.27  是否自动开启断网提示view，铺满整个collectionview，默认是NO
 *         暂时的逻辑是这样的：只有当从没有从接口获得过数据时才显示，否则显示之前的数据即可
 */

@property (nonatomic, assign) BOOL autoShowBrokenNetwork;

- (void)showBrokenNetworkView;

@end
