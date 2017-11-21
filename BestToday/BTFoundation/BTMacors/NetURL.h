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

#define BTQueryMyFollowedUsers   @"http://zuijia365.com/todayHot/app/user/queryMyFollowedUsers.json"


#else         //////// 线上环境



#endif


#endif /* NetURL_h */
