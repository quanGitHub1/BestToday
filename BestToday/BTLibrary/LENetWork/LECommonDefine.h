//
//  LECommonDefine.h
//  LEFinanceNewsIphone
//
//  Created by wangfaquan on 17/5/9.
//  Copyright © 2017年 wangfaquan. All rights reserved.
//

#ifndef LECommonDefine_h
#define LECommonDefine_h

typedef NS_ENUM (NSInteger , HttpResponseCode)
{
    HttpResponseOk = 0,
    HttpResponseError,
    HttpResponseLoginError,
    HttpResponseCnout
};


#define URL_BASE          @"http://v.juhe.cn/"


//http后缀
typedef NS_ENUM(NSInteger,HTTP_COMMAND_LIST){
    //获取新闻头条
    HTTP_NEWS_TOP,
    //上传头像接口
    HTTP_UPDATE_AVATA,
    
    
    /*******************/
    HTTP_METHOD_RESERVE,
    HTTP_METHOD_COUNT
};

//#ifdef __ONLY_FOR_HTTP_COMMUNICATE__
//****************************************************************************/

static char cHttpMethod[HTTP_METHOD_COUNT][64] = {
    
    "toutiao/index",
    "toutiao/avatar",
};

/*****************************************************************************/

typedef NS_ENUM(NSUInteger,ServiceStatusTypeDefine){
    
    ServiceStatusTypeWaitingDefine = 1,
    ServiceStatusTypeWorkingDefine,
    ServiceStatusTypeFinishedDefine,
    ServiceStatusTypeDefineCount,
};
#endif /* LECommonDefine_h */
