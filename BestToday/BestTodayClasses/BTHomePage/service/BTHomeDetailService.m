//
//  BTHomeDetailService.m
//  BestToday
//
//  Created by leeco on 2017/11/22.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomeDetailService.h"
#import "BTHomeDetailLookEntity.h"

@implementation BTHomeDetailService

- (void)loadRecommendResourceByPage:(NSInteger)pageIndex pageAssistParam:(NSString *)pageAssistParam resourceIds:(NSString *)resourceIds completion:(void(^)(BOOL isSuccess, BOOL isCache, NSString* pageAssistParam))completion{

    NSString *urlString = [NSString stringWithFormat:@"%@?pageIndex=%ld&pageAssistParam=%@&resourceIds=%@",BTqueryRecommendResourceByPage,pageIndex,pageAssistParam,resourceIds];

    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        [self handleListData:responseObject];
        
        completion(YES,NO,_pageAssistParam);
        
    } failure:^(NSError *error) {
        completion(NO,NO, _pageAssistParam);
    }];
}

/** 查询我的关注用户列表数据 */
- (BOOL)handleListData:(id)respones {
    
    if (respones && [respones isKindOfClass:[NSDictionary class]]) {
        if (!([respones[@"code"] integerValue] == 0)) {
            return NO;
        }
        
        NSDictionary *dicData = respones[@"data"];
        
        if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
            
            NSArray *datas = dicData[@"resourceVoList"];
            
            for (NSDictionary *dic in datas) {
                
                BTHomeDetailLookEntity *lookEntity = [BTHomeDetailLookEntity yy_modelWithDictionary:dic];
                
                [self.arrDetailResourceByPage addObject:lookEntity];
            }
            
            return YES;
            
        }
    }
    
    return NO;
    
}

- (NSMutableArray *)arrDetailResourceByPage{
    if (!_arrDetailResourceByPage) {
        _arrDetailResourceByPage = [[NSMutableArray alloc]init];
    }
    return _arrDetailResourceByPage;
}

@end
