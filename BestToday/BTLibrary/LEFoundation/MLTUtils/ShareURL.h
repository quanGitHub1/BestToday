//
//  ShareURL.h
//  Finance
//
//  Created by 周洪静 on 2017/5/21.
//  Copyright © 2017年 luluzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShareURLModel;

@interface ShareURL : NSObject<NSCoding>

@property (nonatomic, copy)NSString *StockMarketH5;//大盘行情H5页
@property (nonatomic, copy)NSString *ImageNewH5;//图片新闻H5页
@property (nonatomic, copy)NSString *TextNewH5;//图文详情页
@property (nonatomic, copy)NSString *VDNewH5;//视频详情
@property (nonatomic, copy)NSString *ShareDetailH5;//股票详情
@property (nonatomic, copy)NSString *SpecialNewsH5;//专题界面
@property (nonatomic, copy)NSString *RealTimeNewH5;
@property (nonatomic, copy)NSString *ExchangeDetailH5;//外汇详情
@property (nonatomic, copy)NSString *FocusNewsH5;//图文直播
@property (nonatomic, copy)NSString *DirectSeedingH5;
@property (nonatomic, copy)NSString *WealthPassH5;//财富通地址
@property (nonatomic, strong)NSArray<ShareURLModel *> *links;

+ (instancetype)getShareURL;

@end

@interface ShareURLModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, assign) BOOL setUrl;
@property (nonatomic, assign) BOOL setName;
@property (nonatomic, assign) BOOL setOrder;
@end
