//
//  BTPublishViewController.m
//  BestToday
//
//  Created by 王卓 on 2017/11/28.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTPublishViewController.h"
#import "SQButtonTagView.h"

@interface BTPublishViewController ()

@property (nonatomic, strong) UIImageView *submitImageView;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) SQButtonTagView * classTagView;
@property (nonatomic, strong) SQButtonTagView * subClassTagView;

@end

@implementation BTPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setLeftBarButton:[UIButton mlt_rightBarButtonWithImage:[UIImage imageNamed:@"info_backs"] highlightedImage:nil target:self action:@selector(navigationBackButtonClicked:) forControlEvents:UIControlEventTouchUpInside]];
    UIButton *rightBarButton = [UIButton mlt_buttonWithTitle:@"发布" image:nil highlightedImage:nil target:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBarButton setTitleColor:[UIColor colorWithHexString:@"#fd8671"] forState:UIControlStateNormal];
    [self.navigationBar setRightBarButton:rightBarButton];

    [self setUpUI];
}

- (void)navigationBackButtonClicked:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submitAction{
    
}

- (void)setUpUI{
    _submitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 80, 80)];
    
    [self.view addSubview:_submitImageView];
    
    _contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(120, 80, screenWidth-140, 120)];
    [self.view addSubview:_contentTextView];
    
    _classTagView = [[SQButtonTagView alloc] initWithTotalTagsNum:30 viewWidth:screenWidth-20 eachNum:0 Hmargin:10 Vmargin:10 tagHeight:30 tagTextFont:[UIFont systemFontOfSize:14.f] tagTextColor:[[UIColor redColor] colorWithAlphaComponent:0.5] selectedTagTextColor:[UIColor whiteColor] selectedBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.5]];
    _classTagView.frame = CGRectMake(10, 210, screenWidth-20, 200);
    _classTagView.tagTexts = @[@"meishi",@"meishi",@"meishi",@"meishi",@"meishi",@"meishi",@"meishi"];
    [self.view addSubview:_classTagView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
