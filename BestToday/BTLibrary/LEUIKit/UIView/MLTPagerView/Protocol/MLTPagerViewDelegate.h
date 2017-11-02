//
//  MLTPagerViewDelegate.h
//  MLTPagerView
//
//  Created by jinzi on 16/9/1.
//  Copyright © 2016年 MLT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MLTPagerViewDelegate <NSObject>

/**
 *  当用户上拉刷新、下拉加载更多，或者直接调用loadFirstPage(loadNextPage)时，该方法被回调
 *
 *  @param scrollView
 *  @param page
 *  @param success(list:数据列表 page:要加载的页码 hasMore:是否还有更多数据)
 *  @param failed
 */
- (void)mltPagerView:(UIScrollView *)scrollView
            loadPage:(NSInteger)page
             success:(void (^)(NSArray *list, NSInteger page, BOOL hasMore))success
              failed:(void (^)(NSError *))failed;

@end
