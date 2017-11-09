//
//  BTHomeCommentView.h
//  BestToday
//
//  Created by leeco on 2017/11/8.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTHomeCommentView : UIView

@property (nonatomic, copy) void (^CommentHeightBlock)(CGFloat);


- (instancetype)initWithFrame:(CGRect)frame  block:(void (^)(CGFloat))block;

- (void)getCommentCellHeight;

@end
