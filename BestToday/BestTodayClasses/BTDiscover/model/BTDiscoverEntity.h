//
//  BTDiscoverEntity.h
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTDiscoverEntity : NSObject

@property (nonatomic, strong) NSString *resourceId;  // 资源id
@property (nonatomic, strong) NSString *userId;  // 用户id
@property (nonatomic, strong) NSString *category;  // 分类名称
@property (nonatomic, strong) NSString *topicName;  // 话题名称
@property (nonatomic, strong) NSString *smallPicUrl;  // 缩略图
@property (nonatomic, strong) NSString *backgroundColor;  // 背景色

@end
