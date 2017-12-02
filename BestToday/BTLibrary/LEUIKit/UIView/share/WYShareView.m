//
//  WYShareView.m
//  Finance
//
//  Created by 王艳 on 2017/5/8.
//  Copyright © 2017年 luluzhi. All rights reserved.
//

#import "WYShareView.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

static id _publishContent;
static WYShareView *shareView = nil;

@interface WYShareView(){
    NSMutableArray *_titleArray;
    NSMutableArray *_imageArray;
    NSMutableArray *_typeArray;
}

@end

@implementation WYShareView

/**
 *  分享
 *
 *  @param content     内容
 *  @param resultBlock 结果
 */
+ (void)showShareViewWithPublishContent:(id)content
                                 Result:(ShareResultBlock)resultBlock{
    _publishContent = content;
    [[self alloc] initPublishContent:content
                              Result:resultBlock];
}
/**
 *  分享
 *
 *  @param content     内容
 *  @param resultBlock 结果
 */
- (void)initPublishContent:(id)content
                    Result:(ShareResultBlock)resultBlock{
    if (!shareView) {
        shareView = [[WYShareView alloc] init];
    }
    [self initData];
    [self initShareUI];
    
}

- (void)initData{
    _titleArray = [[NSMutableArray alloc]init];
    _imageArray = [[NSMutableArray alloc]init];
    _typeArray = [[NSMutableArray alloc]init];
    //    if ([WXApi isWXAppInstalled]) {
    [_titleArray addObject:@"微信"];
    [_imageArray addObject:@"share_wechat.png"];
    [_typeArray addObject:@(SSDKPlatformTypeWechat)];
    [_titleArray addObject:@"朋友圈"];
    [_imageArray addObject:@"share_wechatTimeline.png"];
    [_typeArray addObject:@(SSDKPlatformSubTypeWechatTimeline)];
    //    }
    //    if ([QQApiInterface isQQInstalled]) {
    [_titleArray addObject:@"QQ"];
    [_imageArray addObject:@"share_QQ.png"];
    [_typeArray addObject:@(SSDKPlatformTypeQQ)];
    //        [_typeArray addObject:[NSString stringWithFormat:@"%ld",(long)DefaultCShareViewTypeQQ]];
    //    }
    [_titleArray addObject:@"新浪微博"];
    [_imageArray addObject:@"share_sinaweibo.png"];
    [_typeArray addObject:@(SSDKPlatformTypeSinaWeibo)];
}


-(void)initShareUI{
    
    UIWindow *window  = [UIApplication sharedApplication].keyWindow;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
    bgView.tag = 24444;
    [window addSubview:bgView];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:shareView action:@selector(dismissShareView)];
    [bgView addGestureRecognizer:tap1];
    
    /***************************** 添加分享shareBGView ***************************************/
    
    UIView *shareBGView = [[UIView alloc] init];
    shareBGView.frame = CGRectMake(0, kSCREEN_HEIGHT-280, kSCREEN_WIDTH, 280);
    shareBGView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:shareBGView];

    UIView *shareMainView = [[UIView alloc] init];
    shareMainView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 240);
    shareMainView.backgroundColor = [UIColor whiteColor];
    [shareBGView addSubview:shareMainView];
    
    for (int i = 0; i< _titleArray.count; i++) {
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        shareButton.frame = CGRectMake(i%3*kSCREEN_WIDTH/3,20+i/3*110, kSCREEN_WIDTH/3, 110);
        shareButton.backgroundColor = [UIColor clearColor];
        shareButton.tag = i;
        [shareButton addTarget:shareView action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
        [shareMainView addSubview:shareButton];
        
        UIImageView *shareIV = [[UIImageView alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH/3-50)/2, 10, 50, 50)];
        shareIV.image = [UIImage imageNamed:_imageArray[i]];
        [shareButton addSubview:shareIV];
        
        UILabel *shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(shareIV.frame), CGRectGetWidth(shareButton.frame), 30)];
        shareLabel.text = [_titleArray objectAtIndex:i];
        shareLabel.textAlignment = NSTextAlignmentCenter;
        shareLabel.textColor = kExcerptColor;
        shareLabel.font = [UIFont systemFontOfSize:14];
        [shareButton addSubview:shareLabel];
    }
    
    /****************************** 取消 ********************************************/
    UIView *lineLabel = [[UIView alloc]initWithFrame:CGRectMake(0, shareBGView.height-41, kSCREEN_WIDTH, 1)];
    lineLabel.backgroundColor = kLineColor;
    [shareBGView addSubview:lineLabel];
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(0, shareBGView.height-40, shareBGView.width, 40);
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    cancleButton.backgroundColor = [UIColor whiteColor];
    [cancleButton setTitleColor:kExcerptColor forState:UIControlStateNormal];
    [cancleButton addTarget:shareView action:@selector(dismissShareView) forControlEvents:UIControlEventTouchUpInside];
    [shareBGView addSubview:cancleButton];
}

- (void)clickShareButton:(UIButton *)sender{
    
//    if (sender.tag == 0) {
//        if (![WXApi isWXAppInstalled]) {
//            [SVProgressHUD showInfoWithStatus:@"请安装微信"];
//            return;
//        }
//    }else if(sender.tag == 3){
//        if (![QQApiInterface isQQInstalled]) {
//            [SVProgressHUD showInfoWithStatus:@"请安装QQ"];
//            return;
//        }
//    }
    
    [self initData];
    SSDKPlatformType ssdkType;
    ssdkType = [[_typeArray objectAtIndex:sender.tag] unsignedIntegerValue];
    NSDictionary *shareContent = (NSDictionary *)_publishContent;
    NSString *text             = shareContent[@"text"];
    NSArray *imageArray             = shareContent[@"image"];
    NSString *url              = shareContent[@"url"];
    NSString *desc = shareContent[@"desc"];
    if (imageArray) {
        //创建分享参数
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        
        [shareParams SSDKEnableUseClientShare];
        //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
        
        desc = desc.length >200?[desc substringToIndex:200]:desc;

        [shareParams SSDKSetupShareParamsByText:desc
                                         images:imageArray
                                            url:[NSURL URLWithString:url]
                                          title:text
                                           type:SSDKContentTypeAuto];
        
        if (ssdkType == SSDKPlatformTypeSinaWeibo) {
            NSString *messgeS = [NSString stringWithFormat:@"%@ %@",text,url];
            if (messgeS.length > 200) {
                //截取
                NSString *subStr = [text substringToIndex:200 - url.length];
                messgeS = [NSString stringWithFormat:@"%@ %@",subStr,url];
            }else{
                messgeS = [NSString stringWithFormat:@"%@ %@",text,url];
            }
            
            [shareParams SSDKEnableAdvancedInterfaceShare];
            [shareParams SSDKSetupSinaWeiboShareParamsByText:messgeS
                                                       title:nil
                                                       image:imageArray
                                                         url:nil
                                                    latitude:0
                                                   longitude:0
                                                    objectID:nil
                                                        type:SSDKContentTypeAuto];
        }else if(ssdkType == SSDKPlatformTypeWechat){
            NSString *imageStr = @"";
            if ([imageArray isKindOfClass:[NSArray class]]) {
                imageStr = imageArray[0];
            }else {
                imageStr = imageArray;
            }
            [shareParams SSDKSetupWeChatParamsByText:desc title:text url:[NSURL URLWithString:url] thumbImage:imageStr image:imageStr musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatSession];
        }else{
            [shareParams SSDKSetupShareParamsByText:desc
                                             images:imageArray
                                                url:[NSURL URLWithString:url]
                                              title:text
                                               type:SSDKContentTypeAuto];
        }

        //进行分享
        [ShareSDK share:ssdkType
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     
                     [SVProgressHUD showSuccessWithStatus:@"分享成功~"];
                     
                 }
                     break;
                 case SSDKResponseStateFail:
                 {
                     [SVProgressHUD showErrorWithStatus:@"分享失败~"];
                 }
                     break;
                 case SSDKResponseStateCancel:
                 {
                 }
                     break;
                 default:
                     break;
             }
         }];
    }
    [self dismissShareView];
}

- (void)dismissShareView{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [window viewWithTag:24444];
    [UIView animateWithDuration:0.3 animations:^{
        blackView.alpha = 0;
    }completion:^(BOOL finished) {
        [blackView removeFromSuperview];
    }];
}
@end
