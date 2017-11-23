//
//  BTDiscoverService.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTDiscoverService.h"
#import "BTDiscoverEntity.h"

@implementation BTDiscoverService

// 分页查询首页已关注图片资源列表接口
- (void)loadqueryDiscoverResource:(NSInteger)pageIndex pageAssistParam:(NSString *)pageAssistParam completion:(void(^)(BOOL isSuccess, NSString *message, NSString *pageAssistParam))completion{
    
    NSString *urlString = [NSString stringWithFormat:@"%@?pageIndex=%ld&pageAssistParam=%@",BTqueryDiscoverResourceByPage,pageIndex,pageAssistParam];
    NSLog(@"%@",urlString);
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
        if ([pageAssistParam isEqualToString:@""]) {
            [_arrDiscoverResource removeAllObjects];
        }
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"code"] integerValue] == 0) {
                NSDictionary *dicData = responseObject[@"data"];
                if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
                    NSArray *resDetailVoList = dicData[@"resourceVoList"];
                    _pageAssistParam = dicData[@"pageAssistParam"];
                    for (NSDictionary *dic in resDetailVoList) {
                        BTDiscoverEntity *pageEntity = [BTDiscoverEntity yy_modelWithDictionary:dic];
                        [self.arrDiscoverResource addObject:pageEntity];
                    }
                    completion(YES,responseObject[@"msg"],_pageAssistParam);
                }else{
                    completion(NO,@"错误的返回类型", _pageAssistParam);
                }
            }else{
                completion(NO,responseObject[@"msg"], _pageAssistParam);
            }
            
        }else{
            completion(NO,@"错误的返回类型", _pageAssistParam);
        }
    } failure:^(NSError *error) {
        completion(NO,@"请求失败", _pageAssistParam);
    }];
    
}


- (NSMutableArray *)arrDiscoverResource{
    if (!_arrDiscoverResource) {
        _arrDiscoverResource = [[NSMutableArray alloc]init];
    }
    return _arrDiscoverResource;
}


@end
