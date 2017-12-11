//
//  NetURL.h
//  Finance
//
//  Created by 周洪静 on 2017/5/11.
//  Copyright © 2017年 luluzhi. All rights reserved.
//

#ifndef NetURL_h
#define NetURL_h

//#ifdef DEBUG    //// 测试环境

// 用户登录
#define BTUserLogin   @"http://zuijia365.com/todayHot/app/user/wxAppUserLogin.json"

// 推荐用户
#define BTQueryMyFollowedUsers   @"http://zuijia365.com/todayHot/app/user/queryMyFollowedUsers.json"

//  首页关注
#define BTqueryFollowedResource   @"http://zuijia365.com/todayHot/app/resource/queryFollowedResource.json"

// 置顶用户/取消置顶接口
#define BTquerySetTopUser   @"http://zuijia365.com/todayHot/app/user/setTopUser.json"

// 取消关注接口
#define BTqueryUnFollowUser   @"http://zuijia365.com/todayHot/app/user/unFollowUser.json"

// 关注接口
#define BTqueryFollowUser   @"http://zuijia365.com/todayHot/app/user/followUser.json"

// 详情页随便看看
#define BTqueryRecommendResourceByPage   @"http://zuijia365.com/todayHot/app/recommend/recommendResourceByPage.json"

// 喜欢
#define BTquerySaveLikeResource  @"http://zuijia365.com/todayHot/app/comment/saveLikeResource.json"

// 取消喜欢
#define BTqueryDelLikeResource  @"http://zuijia365.com/todayHot/app/comment/delLikeResource.json"

// 评论列表
#define BTqueryCommentList  @"http://zuijia365.com/todayHot/app/comment/queryCommentByPage.json"

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

// 编辑用户信息接口
#define BTqueryUpdateUser  @"http://zuijia365.com/todayHot/app/user/updateUser.json"

// 发现
#define BTqueryDiscoverResourceByPage   @"http://zuijia365.com/todayHot/app/resource/queryForDetection.json"

// 查询系统消息
#define BTquerySystemMessage   @"http://zuijia365.com/todayHot/app/message/querySystemMessages.json"
// 查询个人消息
#define BTqueryMeMessage   @"http://zuijia365.com/todayHot/app/message/queryMyMessages.json"
// 反馈消息
#define BTFeedBackInfo    @"http://zuijia365.com/todayHot/app/message/saveFeedBackInfo.json"

// 上传图片

#define BTUploadPicture   @"http://zuijia365.com/todayHot/app/resource/uploadResource.json"

// 获取分类
#define BTGetTagsList   @"http://zuijia365.com/todayHot/app/tag/queryCategorys.json"
// 获取二级分类
#define BTGetTagsCategory   @"http://zuijia365.com/todayHot/app/tag/queryTagsByCategory.json"

//#else         //////// 线上环境
//
//
//
//#endif


#endif /* NetURL_h */
