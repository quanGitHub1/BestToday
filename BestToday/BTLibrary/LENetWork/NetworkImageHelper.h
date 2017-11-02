//
//  NetworkImageHelper.h
//  Finance
//
//  Created by 周洪静 on 2017/4/17.
//  Copyright © 2017年 luluzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"

@interface NetworkImageHelper : NSObject

/**
 加载网络图片
 
 @param imageView 要加载图片的UIImageView
 @param urlString 图片地址
 */
+ (void)downLoadImageForImageView:(nullable UIImageView *)imageView
                        URLString:(nullable NSString *)urlString;


/**
 加载网络图片
 
 @param imageView 要加载图片的UIImageView
 @param urlString 图片地址
 @param placeholder 占位图片
 */
+ (void)downLoadImageForImageView:(nullable UIImageView *)imageView
                        URLString:(nullable NSString *)urlString
                 placeholderImage:(nullable UIImage *)placeholder;


/**
 加载网络图片
 
 @param imageView 要加载图片的UIImageView
 @param urlString 图片地址
 @param placeholder 占位图片
 @param options 请求策略
 */
+ (void)downLoadImageForImageView:(nullable UIImageView *)imageView
                        URLString:(nullable NSString *)urlString
                 placeholderImage:(nullable UIImage *)placeholder
                          options:(SDWebImageOptions)options;





/**
 加载网络图片
 
 @param imageView 要加载图片的UIImageView
 @param urlString 图片地址
 @param placeholder 占位图片
 @param options 请求策略
 @param progressBlock 进度回调
 @param completedBlock 完成回调
 */
+ (void)downLoadImageForImageView:(nullable UIImageView *)imageView
                        URLString:(nullable NSString *)urlString
                 placeholderImage:(nullable UIImage *)placeholder
                          options:(SDWebImageOptions)options
                         progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                        completed:(nullable SDWebImageCompletionBlock)completedBlock;


#pragma mark - 圆角

/**
 加载圆角网络图片
 
 @param imageView 要加载图片的UIImageView
 @param urlString 图片地址
 @param placeholder 占位图片
 */
+ (void)downLoadCImageForImageView:(nullable UIImageView *)imageView
                        URLString:(nullable NSString *)urlString
                 placeholderImage:(nullable UIImage *)placeholder
              cornerRadiusAdvance:(CGFloat)cornerRadius
                   rectCornerType:(UIRectCorner)rectCornerType;


/**
 加载圆角网络图片
 
 @param imageView 要加载图片的UIImageView
 @param urlString 图片地址
 @param placeholder 占位图片
 @param options 请求策略
 @param progressBlock 进度回调
 @param completedBlock 完成回调
 */
+ (void)downLoadCImageForImageView:(nullable UIImageView *)imageView
                        URLString:(nullable NSString *)urlString
                 placeholderImage:(nullable UIImage *)placeholder
                          options:(SDWebImageOptions)options
                         progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                        completed:(nullable SDWebImageCompletionBlock)completedBlock;



@end

@interface UIImageView (Extension)

- (void)downLoadImageWithURLString:(nullable NSString *)urlString
                  placeholderImage:(nullable UIImage *)placeholder;

/**
 下载图片（带网络判断）

 @param urlString 图片地址
 @param placeholder 占位图片
 @param options 请求策略
 @param progressBlock 进度回调
 @param completedBlock 完成回调
 */
- (void)downloadImageWithURLString:(nullable NSString *)urlString
                  placeholderImage:(UIImage *_Nullable)placeholder
                           options:(SDWebImageOptions)options
                          progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                         completed:(nullable SDWebImageCompletionBlock)completedBlock;


/**
 下载圆角图片（带网络判断）

 @param urlString 图片地址
 @param placeholder 占位图片
 @param options 请求策略
 @param progressBlock 进度回调
 @param completedBlock 完成回调
 */
- (void)downloadCImageWithURLString:(nullable NSString *)urlString
                  placeholderImage:(UIImage *_Nullable)placeholder
                           options:(SDWebImageOptions)options
                          progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                         completed:(nullable SDWebImageCompletionBlock)completedBlock;
@end
