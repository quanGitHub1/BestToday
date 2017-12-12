//
//  BTPublishViewController.m
//  BestToday
//
//  Created by 王卓 on 2017/11/28.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTPublishViewController.h"
#import "SQButtonTagView.h"
#import "BTPhotoService.h"
#import "BTPhotoEntity.h"
#import "XXTextView.h"

@interface BTPublishViewController ()

@property (nonatomic, strong) NSString *uploadCategoryId;
@property (nonatomic, strong) NSString *uploadtagId;
@property (nonatomic, strong) NSString *uploadtagName;

@property (nonatomic, strong) UIImageView *submitImageView;
@property (nonatomic, strong) XXTextView *contentTextView;
@property (nonatomic, strong) SQButtonTagView * classTagView;
@property (nonatomic, strong) SQButtonTagView * subClassTagView;
@property (nonatomic, strong) BTPhotoService * photoService;
@property (nonatomic, strong) NSMutableArray * categoryArray;// 一级列表分类
@property (nonatomic, strong) NSMutableArray * tagsArray;
@end

@implementation BTPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setLeftBarButton:[UIButton mlt_leftBarButtonWithImage:[UIImage imageNamed:@"info_backs"] highlightedImage:nil target:self action:@selector(navigationBackButtonClicked) forControlEvents:UIControlEventTouchUpInside]];
    UIButton *rightBarButton = [UIButton mlt_buttonWithTitle:@"发布" image:nil highlightedImage:nil backgroundImage:nil highlightedBackgroundImage:nil target:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBarButton setTitleColor:[UIColor colorWithHexString:@"#fd8671"] forState:UIControlStateNormal];
    [self.navigationBar setRightBarButton:rightBarButton];
    
    _categoryArray = [NSMutableArray array];
    _tagsArray = [NSMutableArray array];
    [self setUpUI];
    [self setUpDataForTagView];
}

- (void)navigationBackButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
    UINavigationController *navC = (UINavigationController *)AppWindow.rootViewController;
    MLTTabBarController *tabBarVC = navC.viewControllers[0];
    [tabBarVC selectAtIndex:0];
}


- (void)submitAction{
    
    if ([_contentTextView.text isEqualToString:@"添加照片说明"]) {
        return;
    }

    __weak __typeof(self)weakSelf = self;
    [self.photoService uploadImage:_imageSource text:_contentTextView.text categoryId:_uploadCategoryId tagIdList:self.uploadtagId tagName:self.uploadtagName completion:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            [weakSelf navigationBackButtonClicked];
        }else{
            NSLog(@"%@",message);
        }
    }];
}

- (void)setUpUI{
    _submitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 80, 80)];
    _submitImageView.image = _imageSource;
    [self.view addSubview:_submitImageView];
    
    _contentTextView = [[XXTextView alloc] initWithFrame:CGRectMake(120, 80, screenWidth-140, 120)];
    _contentTextView.xx_placeholder = @"添加照片说明";
    [self.view addSubview:_contentTextView];
   
}

- (void)setUpClassView{
    _classTagView = [[SQButtonTagView alloc] initWithTotalTagsNum:self.categoryArray.count viewWidth:screenWidth-20 eachNum:0 Hmargin:10 Vmargin:10 tagHeight:30 tagTextFont:[UIFont systemFontOfSize:14.f] tagTextColor:[[UIColor redColor] colorWithAlphaComponent:0.5] selectedTagTextColor:[UIColor whiteColor] selectedBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.5]];
    _classTagView.frame = CGRectMake(10, 210, screenWidth-20, 200);
    _classTagView.maxSelectNum = 1;
    __weak __typeof(self)weakSelf = self;
    _classTagView.selectBlock = ^(SQButtonTagView * _Nonnull tagView, NSArray * _Nonnull selectArray) {
        int index = [selectArray[0] intValue];
        BTPhotoEntity *entity = weakSelf.photoService.categoryArray[index];
        weakSelf.uploadCategoryId = entity.categoryId;
        [weakSelf setUpDataForCatogryTagViewWithCategoryid:weakSelf.uploadCategoryId categoryName:entity.categoryName];
    };
    
    [self.view addSubview:_classTagView];
}

- (void)setUpSubClassTagView{
    if (!_subClassTagView) {
        CGFloat height = [SQButtonTagView returnViewHeightWithTagTexts:_categoryArray viewWidth:screenWidth-20 eachNum:0 Hmargin:10 Vmargin:10 tagHeight:30 tagTextFont:[UIFont systemFontOfSize:14.f]];
        _subClassTagView = [[SQButtonTagView alloc] initWithTotalTagsNum:_tagsArray.count viewWidth:screenWidth-20 eachNum:0 Hmargin:10 Vmargin:10 tagHeight:30 tagTextFont:[UIFont systemFontOfSize:14.f] tagTextColor:[[UIColor redColor] colorWithAlphaComponent:0.5] selectedTagTextColor:[UIColor whiteColor] selectedBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.5]];
        _subClassTagView.frame = CGRectMake(10, 220+height, screenWidth-20, 200);
        _subClassTagView.maxSelectNum = 1;
        __weak __typeof(self)weakSelf = self;
        _subClassTagView.selectBlock = ^(SQButtonTagView * _Nonnull tagView, NSArray * _Nonnull selectArray) {
            int index = [selectArray[0] intValue];
            BTPhotoEntity *entity = weakSelf.photoService.tagsArray[index];
            weakSelf.uploadtagId = entity.tagId;
            weakSelf.uploadtagName = entity.tagName;
        };
        [self.view addSubview:_subClassTagView];
    }
}

- (void)setUpClassViewFrame{
    CGFloat height = [SQButtonTagView returnViewHeightWithTagTexts:_categoryArray viewWidth:screenWidth-20 eachNum:0 Hmargin:10 Vmargin:10 tagHeight:30 tagTextFont:[UIFont systemFontOfSize:14.f]];
    CGRect frame = self.classTagView.frame;
    frame.size.height = height;
    self.classTagView.frame = frame;
}

- (void)setUpSubClassViewFrame{
    CGFloat height = [SQButtonTagView returnViewHeightWithTagTexts:_tagsArray viewWidth:screenWidth-20 eachNum:0 Hmargin:10 Vmargin:10 tagHeight:30 tagTextFont:[UIFont systemFontOfSize:14.f]];
    CGRect frame = self.subClassTagView.frame;
    frame.size.height = height;
    self.subClassTagView.frame = frame;
}

- (void)setUpDataForTagView{
    // 一级分类
    __weak __typeof(self)weakSelf = self;
    [self.photoService getUploadPictureTagscompletion:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            for (int i = 0 ; i<weakSelf.photoService.categoryArray.count; i++) {
                BTPhotoEntity *entity = weakSelf.photoService.categoryArray[i];
                [_categoryArray addObject:entity.categoryName];
            }
            [weakSelf setUpClassView];
            weakSelf.classTagView.tagTexts = _categoryArray;
            [weakSelf setUpClassViewFrame];
        }else{
            NSLog(@"%@",message);
        }
    }];
}

- (void)setUpDataForCatogryTagViewWithCategoryid:(NSString *)categoryid categoryName:(NSString *)categoryName{
    // 二级分类
    __weak __typeof(self)weakSelf = self;
    [self.photoService getUploadPictureTagsByCategoryId:categoryid categoryName:categoryName Cacompletion:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            for (int i = 0 ; i<weakSelf.photoService.tagsArray.count; i++) {
                BTPhotoEntity *entity = weakSelf.photoService.tagsArray[i];
                [_tagsArray addObject:entity.tagName];
            }
            [weakSelf setUpSubClassTagView];
            weakSelf.subClassTagView.tagTexts = _tagsArray;
            [weakSelf setUpSubClassViewFrame];
        }else{
            NSLog(@"%@",message);
        }
    }];
    
}



- (BTPhotoService *)photoService {
    if (!_photoService) {
        _photoService = [[BTPhotoService alloc] init];
    }
    return _photoService;
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
