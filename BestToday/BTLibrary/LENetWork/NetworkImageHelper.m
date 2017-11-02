//
//  NetworkImageHelper.m
//  Finance
//
//  Created by 周洪静 on 2017/4/17.
//  Copyright © 2017年 luluzhi. All rights reserved.
//

#import "NetworkImageHelper.h"
//#import "UIView+WebCache.h"
#import "AFNetworkReachabilityManager.h"

//xiugaihou
@implementation NetworkImageHelper

+ (void)downLoadImageForImageView:(UIImageView *)imageView
                        URLString:(nullable NSString *)urlString
{
    [imageView downloadImageWithURLString:urlString
                         placeholderImage:nil
                                  options:0
                                 progress:nil
                                completed:nil];
}

+ (void)downLoadImageForImageView:(nullable UIImageView *)imageView
                        URLString:(nullable NSString *)urlString
                 placeholderImage:(nullable UIImage *)placeholder
{
    [imageView downloadImageWithURLString:urlString
                         placeholderImage:placeholder
                                  options:0
                                 progress:nil
                                completed:nil];
}

+ (void)downLoadImageForImageView:(UIImageView *)imageView
                        URLString:(nullable NSString *)urlString
                 placeholderImage:(UIImage *)placeholder
                          options:(SDWebImageOptions)options
{
    [imageView downloadImageWithURLString:urlString
                         placeholderImage:placeholder
                                  options:options
                                 progress:nil
                                completed:nil];

}
+ (void)downLoadImageForImageView:(nullable UIImageView *)imageView
                        URLString:(nullable NSString *)urlString
                 placeholderImage:(nullable UIImage *)placeholder
                          options:(SDWebImageOptions)options
                         progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                        completed:(nullable SDWebImageCompletionBlock)completedBlock
{
    [imageView downloadImageWithURLString:urlString
                         placeholderImage:placeholder
                                  options:options
                                 progress:progressBlock
                                completed:completedBlock];


}
#pragma mark - 圆角
+ (void)downLoadCImageForImageView:(UIImageView *)imageView
                        URLString:(NSString *)urlString
                 placeholderImage:(UIImage *)placeholder
{
    [self downLoadCImageForImageView:imageView
                          URLString:urlString
                   placeholderImage:placeholder
                            options:0
                           progress:nil
                          completed:nil];
    
}

+ (void)downLoadCImageForImageView:(UIImageView *)imageView
                        URLString:(nullable NSString *)urlString
                placeholderImage:(UIImage *)placeholder
                          options:(SDWebImageOptions)options
                         progress:(SDWebImageDownloaderProgressBlock)progressBlock
                        completed:(SDWebImageCompletionBlock)completedBlock
{
    
    [imageView downloadCImageWithURLString:urlString
                          placeholderImage:placeholder
                                   options:options
                                  progress:progressBlock
                                 completed:completedBlock];
//    __weak typeof(imageView)weakImageView = imageView;
//    [imageView sd_internalSetImageWithURL:url
//                         placeholderImage:placeholder
//                                  options:options
//                             operationKey:nil
//                            setImageBlock:^(UIImage * _Nullable image, NSData * _Nullable imageData) {
//                                weakImageView.image = [image imageWithRoundingCorners:rectCornerType cornerRadius:cornerRadius size:weakImageView.bounds.size];
//                            } progress:progressBlock
//                                completed:completedBlock];
}


@end

@implementation UIImageView (Extension)
- (void)downLoadImageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholder {
    [self downloadImageWithURLString:urlString placeholderImage:placeholder options:0 progress:nil completed:nil];
}
- (void)downloadImageWithURLString:(NSString *)urlString
            placeholderImage:(UIImage *)placeholder
                     options:(SDWebImageOptions)options
                    progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                   completed:(nullable SDWebImageCompletionBlock)completedBlock
{

//    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:urlString];
//    if (originImage) {
//        self.image = originImage;
//    } else {
        if (kIsWiFiNetwork) {
            [self sd_setImageWithURL:[NSURL URLWithString:urlString]
                placeholderImage:placeholder
                          options:options
                         progress:progressBlock
                        completed:completedBlock];
        } else if (kIsWWANNetwork) {
            //此处if可再增加是否允许手机3/4G网络下载图片,或者下载不同的图片
            [self sd_setImageWithURL:[NSURL URLWithString:urlString]
                    placeholderImage:placeholder
                             options:options
                            progress:progressBlock
                           completed:completedBlock];
        } else {
            //没有网络
            self.image = placeholder;
        }
        
//    }
}

- (void)downloadCImageWithURLString:(NSString *)urlString
                   placeholderImage:(UIImage *)placeholder
                            options:(SDWebImageOptions)options
                           progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                          completed:(nullable SDWebImageCompletionBlock)completedBlock
{
    
//    UIImage *originImage = [[SDImageCache sharedImageCache]imageFromCacheForKey:urlString];
//    if (originImage) {
//        self.image = [originImage circleImage];;
//    } else {
//        __weak typeof(self)weakSelf = self;
//        if (kIsWiFiNetwork) {
//            [self sd_setImageWithURL:[NSURL URLWithString:urlString]
//                                 placeholderImage:placeholder
//                                          options:options
//                                     operationKey:nil
//                                    setImageBlock:^(UIImage * _Nullable image, NSData * _Nullable imageData) {
//                                        weakSelf.image = [image circleImage];
//                                    } progress:progressBlock
//                                        completed:completedBlock];
//
//        } else if (kIsWWANNetwork) {
//            //此处if可再增加是否允许手机3/4G网络下载图片,或者下载不同的图片
//            [self sd_internalSetImageWithURL:[NSURL URLWithString:urlString]
//                            placeholderImage:placeholder
//                                     options:options
//                                operationKey:nil
//                               setImageBlock:^(UIImage * _Nullable image, NSData * _Nullable imageData) {
//                                   weakSelf.image = [image circleImage];
//                               } progress:progressBlock
//                                   completed:completedBlock];
//        } else {
//            //没有网络
//            self.image = [placeholder circleImage];
//        }
    
//    }
}
@end
