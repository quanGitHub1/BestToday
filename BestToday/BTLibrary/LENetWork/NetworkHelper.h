//
//  NetworkHelper.h
//  Finance
//
//  Created by 周洪静 on 2017/4/17.
//  Copyright © 2017年 luluzhi. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, NetworkStatusType) {
    /** 未知网络*/
    NetworkStatusUnknown,
    /** 无网络*/
    NetworkStatusNotReachable,
    /** 手机网络*/
    NetworkStatusReachableViaWWAN,
    /** WIFI网络*/
    NetworkStatusReachableViaWiFi
};

typedef NS_ENUM(NSUInteger, RequestSerializer) {
    /** 设置请求数据为JSON格式*/
    RequestSerializerJSON,
    /** 设置请求数据为二进制格式*/
    RequestSerializerHTTP,
};

typedef NS_ENUM(NSUInteger, ResponseSerializer) {
    /** 设置响应数据为JSON格式*/
    ResponseSerializerJSON,
    /** 设置响应数据为二进制格式*/
    ResponseSerializerHTTP,
};
typedef NS_ENUM(NSUInteger, RequestMethod) {
    RequestMethodGet,
    RequestMethodPost
};

/** 缓存的Block */
typedef void(^HttpRequestCache)(id responseCache);

/** 请求成功的Block */
typedef void(^HttpRequestSuccess)(id responseObject);

/** 请求失败的Block */
typedef void(^HttpRequestFailed)(NSError *error);


/** 网络状态的Block*/
typedef void(^NetworkStatus)(NetworkStatusType status);


@class AFHTTPSessionManager;
@interface NetworkHelper : NSObject

/**
 有网YES, 无网:NO
 */
+ (BOOL)isNetwork;

/**
 手机网络:YES, 反之:NO
 */
+ (BOOL)isWWANNetwork;

/**
 WiFi网络:YES, 反之:NO
 */
+ (BOOL)isWiFiNetwork;

/**
 取消所有HTTP请求
 */
+ (void)cancelAllRequest;

/**
 实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
 */
+ (void)networkStatusWithBlock:(NetworkStatus)networkStatus;

/**
 取消指定URL的HTTP请求
 */
+ (void)cancelRequestWithURL:(NSString *)URL;

/**
 *  网络请求
 *
 *  @param method      请求类型 GET／POST
 *  @param URL         请求地址
 *  @param parmeters   请求参数
 *  @param completion  请求回调
 *  @return            返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)requestMethod:(RequestMethod)method
                          URLString:(NSString *)URL
                          parmeters:(NSDictionary *)parmeters
                         completion:(void(^)(id response, BOOL result))completion;


/**
 *  GET请求
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
                        parameters:(id)parameters
                           success:(HttpRequestSuccess)success
                           failure:(HttpRequestFailed)failure;



/**
 *  POST请求
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)POST:(NSString *)URL
                         parameters:(id)parameters
                            success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure;


/**
 *  GET请求,自动缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
                        parameters:(id)parameters
                     responseCache:(HttpRequestCache)responseCache
                           success:(HttpRequestSuccess)success
                           failure:(HttpRequestFailed)failure;

/**
 *  POST请求,自动缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)POST:(NSString *)URL
                         parameters:(id)parameters
                      responseCache:(HttpRequestCache)responseCache
                            success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure;

#pragma mark - 设置AFHTTPSessionManager相关属性
#pragma mark 注意: 因为全局只有一个AFHTTPSessionManager实例,所以以下设置方式全局生效
/**
 在开发中,如果以下的设置方式不满足项目的需求,就调用此方法获取AFHTTPSessionManager实例进行自定义设置
 (注意: 调用此方法时在要导入AFNetworking.h头文件,否则可能会报找不到AFHTTPSessionManager的❌)
 @param sessionManager AFHTTPSessionManager的实例
 */
+ (void)setAFHTTPSessionManagerProperty:(void(^)(AFHTTPSessionManager *sessionManager))sessionManager;

/**
 *  设置网络请求参数的格式:默认为二进制格式
 *
 *  @param requestSerializer PPRequestSerializerJSON(JSON格式),PPRequestSerializerHTTP(二进制格式),
 */
+ (void)setRequestSerializer:(RequestSerializer)requestSerializer;

/**
 *  设置服务器响应数据格式:默认为JSON格式
 *
 *  @param responseSerializer PPResponseSerializerJSON(JSON格式),PPResponseSerializerHTTP(二进制格式)
 */
+ (void)setResponseSerializer:(ResponseSerializer)responseSerializer;

/**
 *  设置请求超时时间:默认为30S
 *
 *  @param time 时长
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/**
 *  设置请求头
 */
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/**
 *  是否打开网络状态转圈菊花:默认打开
 *
 *  @param open YES(打开), NO(关闭)
 */
+ (void)openNetworkActivityIndicator:(BOOL)open;

@end
