//
//  NetURL.h
//  Finance
//
//  Created by 周洪静 on 2017/5/11.
//  Copyright © 2017年 luluzhi. All rights reserved.
//

#ifndef NetURL_h
#define NetURL_h

#ifdef DEBUG    //// 测试环境

// 用户登录
#define BTUserLogin   @"http://zuijia365.com/todayHot/app/user/wxAppUserLogin.json"

// 推荐用户
#define BTQueryMyFollowedUsers   @"http://zuijia365.com/todayHot/app/user/queryMyFollowedUsers.json"

//  首页关注
#define BTqueryFollowedResource   @"http://zuijia365.com/todayHot/app/resource/queryFollowedResource.json"

// 详情页随便看看
#define BTqueryRecommendResourceByPage   @"http://zuijia365.com/todayHot/app/recommend/recommendResourceByPage.json"

// 喜欢
#define BTquerySaveLikeResource  @"http://zuijia365.com/todayHot/app/comment/saveLikeResource.json"

// 取消喜欢
#define BTqueryDelLikeResource  @"http://zuijia365.com/todayHot/app/comment/delLikeResource.json"

// 用户信息
#define BTqueryUserById  @"http://zuijia365.com/todayHot/app/user/queryUserById.json"

// 查询图片详情接口
#define BTqueryResourceDetail  @"http://zuijia365.com/todayHot/app/resource/queryResourceDetail.json"

// 我发表的图片资源接口
#define BTqueryMyResourceByPage  @"http://zuijia365.com/todayHot/app/resource/queryMyResourceByPage.json"

// 查询关注我的用户(粉丝)列表接口
#define BTqueryMyFansUsers   @"http://zuijia365.com/todayHot/app/user/queryMyFansUsers.json"


// 我点赞过的图片资源接口
#define BTqueryCommentResourceByPage  @"http://zuijia365.com/todayHot/app/resource/queryCommentResourceByPage.json"

// 更换头像接口
#define BTqueryUpdateAvatar  @"http://zuijia365.com/todayHot/app/user/updateAvatar.json"

// 发现
#define BTqueryDiscoverResourceByPage   @"http://zuijia365.com/todayHot/app/resource/queryForDetection.json"

#else         //////// 线上环境



#endif


#endif /* NetURL_h */
