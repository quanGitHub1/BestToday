//
//  MLTFullImageView.m
//  AMCustomer
//
//  Created by WangFaquan on 16/9/5.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "MLTFullImageView.h"
#import "UIImageView+WebCache.h"

#define kBarHeight 40

@implementation MLTFullImageView{
    UIScrollView *_showScrollImage;
    NSInteger _index;
    UILabel *_labNum;
    NSArray *_imagePicArry;
}

-(id)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        _imagePicArry = [NSArray array];
        
        _labNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, FULL_WIDTH, kBarHeight)];
        _labNum.textAlignment = NSTextAlignmentCenter;
        _labNum.backgroundColor = [UIColor clearColor];
        _labNum.font = [UIFont boldSystemFontOfSize:18];
        _labNum.textColor = [UIColor whiteColor];
        [self addSubview:_labNum];
        
        _showScrollImage = [[UIScrollView alloc] initWithFrame:frame];
        _showScrollImage.userInteractionEnabled = YES;
        _showScrollImage.backgroundColor = [UIColor blackColor];
        _showScrollImage.delegate = self;
        _showScrollImage.pagingEnabled = YES;
        _showScrollImage.bounces = NO;
        [self addSubview:_showScrollImage];
        [self sendSubviewToBack:_showScrollImage];
    }
    return self;
}

/**
 *  支持URL显示大图和图片显示大图
 *  如果 isUrl为yes 就是URL
 */
- (void)clickShowFullImageView:(NSArray *)imageArr Index:(NSInteger)index isUrl:(BOOL)isUrl{
    
    _imagePicArry = imageArr;
    
    for (UIView * view in _showScrollImage.subviews) {
        [view removeFromSuperview];
    }
    _labNum.text = [NSString stringWithFormat:@"%d/%d",(int)(index + 1),(int)(imageArr.count)];
    
    for (int i=0; i <imageArr.count; i++) {
        CGRect Frame = _showScrollImage.frame;
        UIScrollView * scv = [[UIScrollView alloc]initWithFrame:CGRectMake(FULL_WIDTH * i, 0, Frame.size.width, Frame.size.height)];
        scv.backgroundColor = [UIColor clearColor];
        scv.minimumZoomScale = 1.0;
        scv.maximumZoomScale = 3.0;
        scv.delegate = self;
        scv.tag = i + 1111;
        scv.userInteractionEnabled = YES;
        [_showScrollImage addSubview:scv];
        
        
        NSString * imageUrl = [imageArr objectAtIndex:i];
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, FULL_WIDTH, FULL_HEIGHT)];
        
        //isUrl 为yes 就会处理URL
        if(isUrl == YES){
            
            [imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
//            [imgView mlt_setImageWithSourceString:imageUrl placeHolder:nil];
            
        }else {
            
            UIImage * image = [imageArr objectAtIndex:i];
            
            [imgView setImage:image];
            
            [imgView setFrame:[self setImageViewRectWithImage:image]];
            
        }
        
        imgView.backgroundColor = [UIColor clearColor];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.tag = i + 2222;
        imgView.userInteractionEnabled = YES;
        [scv addSubview:imgView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(showViewDismiss)];
        [scv addGestureRecognizer:tap];
        
    }
    
    // 设置大小
    _showScrollImage.contentSize = CGSizeMake(FULL_WIDTH * imageArr.count, _showScrollImage.height);
    _showScrollImage.contentOffset = CGPointMake(index * FULL_WIDTH, 0);

}

// 数组中如果不是URL需要用到这个
-(CGRect)setImageViewRectWithImage:(UIImage *)img{
    
    CGRect imgRect;
    float w = img.size.width;
    float h = img.size.height;
    float rat ;//缩放比例
    if (w <= FULL_WIDTH) {
        if (h <= FULL_HEIGHT)
        {
            rat = 1;
        }else{
            rat = h/FULL_HEIGHT;
        }
    }else {
        if (h <= FULL_HEIGHT) {
            rat = FULL_WIDTH/w;
        }else{
            float rat1 = FULL_WIDTH/w;
            float rat2 = FULL_HEIGHT/h;
            rat = rat1<rat2?rat1:rat2;
        }
    }
    w = w*rat;
    h = h*rat;
    NSLog(@"%f,%f",w,h);
    imgRect = CGRectMake((FULL_WIDTH-w)/2.0, (FULL_HEIGHT-h)/2.0, w, h);
    return imgRect;
}

// 视图出现与隐藏
-(void)showViewDismiss{

    if (_delegate && [_delegate respondsToSelector:@selector(clickImageViewDismiss)]) {
        
        [_delegate clickImageViewDismiss];
    }
    
}

#pragma mark UISCrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint p = _showScrollImage.contentOffset;
    int n = p.x/FULL_WIDTH;
    NSLog(@"%d",n);
    _index = n;
    _labNum.text = [NSString stringWithFormat:@"%d/%d",(int)(n+1),(int)(_imagePicArry.count)];
}


// 对应的界面
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    int indexs = (int)(scrollView.tag - 1111);
    UIView *subView = [scrollView viewWithTag:2222 + indexs];
    return subView;
    
}

- (void)showFullImageView:(UIView *)view{
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
}

- (void)hideFullImageView:(UIView *)view{
    
    [UIView animateWithDuration:1.0 animations:^{
        
        [[UIApplication sharedApplication].keyWindow sendSubviewToBack:view];
        
    } completion:^(BOOL finished) {
        view.hidden = YES;
    }];
}

@end
