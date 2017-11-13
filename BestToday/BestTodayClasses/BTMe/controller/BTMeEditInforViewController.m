//
//  BTMeEditInforViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/10.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTMeEditInforViewController.h"

@interface BTMeEditInforViewController ()

@property (nonatomic, strong) UILabel *labName;

@property (nonatomic, strong) UILabel *labProduct;

@property (nonatomic, strong) UITextField *textViewName;

@property (nonatomic, strong) UITextField *textProduct;


@end

@implementation BTMeEditInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgationBar];
    
    UIView *viewHeader = [self createView:CGRectMake(0, 64, FULL_WIDTH, FULL_HEIGHT - NAVBAR_HEIGHT)];
    
    [self.view addSubview:viewHeader];
}

-(void)setNavgationBar{
    
    self.navigationBar.title = @"编辑个人资料";
    // 添加右上角按钮
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 50, 30)];
    
    [btnLeft setTitle:@"取消" forState:UIControlStateNormal];
    
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [btnLeft addTarget:self action:@selector(onclickBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnLeft setTitleColor:[UIColor colorWithHexString:@"#212121" alpha:1] forState:UIControlStateNormal];
    
    [self.navigationBar.leftBarButton addSubview:btnLeft];
    
    UIButton *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(FULL_WIDTH - 55, 35, 50, 30)];
    
    [btnRight setTitle:@"完成" forState:UIControlStateNormal];
    
    [btnLeft addTarget:self action:@selector(onclickBtnSure:) forControlEvents:UIControlEventTouchUpInside];

    btnRight.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [btnRight setTitleColor:[UIColor colorWithHexString:@"#fd8671" alpha:1] forState:UIControlStateNormal];
    
    [self.navigationBar addSubview:btnRight];
    
}


- (UIView *)createView:(CGRect)frame{
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((FULL_WIDTH - ScaleWidth(81))/2, 32, ScaleWidth(81), ScaleWidth(81))];
    
    imageView.backgroundColor = [UIColor redColor];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    imageView.layer.cornerRadius = ScaleWidth(81/2);
    
    imageView.clipsToBounds = YES;
    
    UILabel *labChange = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom + 7, FULL_WIDTH, 16)];
    
    labChange.text = @"更换头像";
    
    labChange.textColor = [UIColor colorWithHexString:@"#fd8671"];
    
    labChange.textAlignment = NSTextAlignmentCenter;
    
    _labName = [[UILabel alloc] initWithFrame:CGRectMake(15, labChange.bottom + 50, 40, 16)];
    
    _labName = [UILabel mlt_labelWithText:@"昵称" color:[UIColor mlt_colorWithHexString:@"#969696" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:15] bkColor:nil frame:CGRectMake(15, labChange.bottom + 50, 40, 16)];
    
    _labProduct = [UILabel mlt_labelWithText:@"简介" color:[UIColor mlt_colorWithHexString:@"#969696" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:15] bkColor:nil frame:CGRectMake(15, _labName.bottom + 30, 40, 16)];
    
    _textViewName = [[UITextField alloc] initWithFrame:CGRectMake(_labName.right + 30, _labName.top, FULL_WIDTH - _labName.right - 45, 30)];
    
    _textViewName.text = @"北冥有鱼";
    
    _textViewName.font = [UIFont systemFontOfSize:15];
    
    _textViewName.textColor = [UIColor colorWithHexString:@"#212121"];

    
    _textProduct = [[UITextField alloc] initWithFrame:CGRectMake(_labProduct.right + 30, _labProduct.top, FULL_WIDTH - _labProduct.right - 45, 30)];
    
    _textProduct.textColor = [UIColor colorWithHexString:@"#212121"];

    _textProduct.text = @"dsfksdl;fksa;kfsa;'ka";
    
    _textProduct.font = [UIFont systemFontOfSize:15];
    

    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(_labName.right + 15, _labName.bottom + 15, FULL_WIDTH - _labName.right - 30, 1)];
    
    viewLine.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    
    UIView *viewLineTwo = [[UIView alloc] initWithFrame:CGRectMake(_labProduct.right + 15, _labProduct.bottom + 15, FULL_WIDTH - _labProduct.right - 30, 1)];
    
    viewLineTwo.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    [view addSubview:viewLineTwo];
    
    [view addSubview:viewLine];
    
    [view addSubview:_labName];
    [view addSubview:_labProduct];
    
    [view addSubview:_textProduct];
    
    [view addSubview:_textViewName];
   
    [view addSubview:labChange];
    [view addSubview:imageView];
    
    return view;
}

- (void)onclickBtnCancel:(UIButton *)btn{
    

}

- (void)onclickBtnSure:(UIButton *)btn{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
