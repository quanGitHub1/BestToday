//
//  BTPublishViewController.m
//  BestToday
//
//  Created by 王卓 on 2017/11/28.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTPublishViewController.h"
#import "TTTagView.h"
#import "BTPhotoService.h"
#import "BTPhotoEntity.h"
#import "XXTextView.h"
#import "UIImage+Compression.h"

@interface BTPublishViewController ()<TTTagViewDelegate>
{
    UIButton *rightBarButton;
}
@property (nonatomic, strong) NSString *uploadCategoryId;
@property (nonatomic, strong) NSString *uploadtagId;
@property (nonatomic, strong) NSString *uploadtagName;

@property (nonatomic, strong) UIImageView *submitImageView;
@property (nonatomic, strong) XXTextView *contentTextView;
@property (nonatomic, strong) TTTagView * classTagView;
@property (nonatomic, strong) TTTagView * subClassTagView;
@property (nonatomic, strong) BTPhotoService * photoService;
@property (nonatomic, strong) NSMutableArray * categoryArray;// 一级列表分类
@property (nonatomic, strong) NSMutableArray * tagsArray;
@end

@implementation BTPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setLeftBarButton:[UIButton mlt_leftBarButtonWithImage:[UIImage imageNamed:@"info_backs"] highlightedImage:nil target:self action:@selector(navigationBackButtonClicked) forControlEvents:UIControlEventTouchUpInside]];
    rightBarButton = [UIButton mlt_buttonWithTitle:@"发布" image:nil highlightedImage:nil backgroundImage:nil highlightedBackgroundImage:nil target:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBarButton setTitleColor:[UIColor colorWithHexString:@"#fd8671"] forState:UIControlStateNormal];
    [self.navigationBar setRightBarButton:rightBarButton];
    
    _categoryArray = [NSMutableArray array];
    _tagsArray = [NSMutableArray array];
    [self setUpUI];
    [self setUpDataForTagView];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [super viewWillDisappear:animated];
}

- (void)navigationBackButtonClicked {
    [self.navigationController popToRootViewControllerAnimated:YES];
    UINavigationController *navC = (UINavigationController *)AppWindow.rootViewController;
    MLTTabBarController *tabBarVC = navC.viewControllers[0];
    [tabBarVC selectAtIndex:0];
}


- (void)submitAction{
    rightBarButton.enabled = NO;
    if ([_contentTextView.text isEqualToString:@"添加照片说明"]) {
        [SVProgressHUD showErrorWithStatus:@"请添加照片说明"];
        return;
    }

    __weak __typeof(self)weakSelf = self;

    [SVProgressHUD showWithStatus:@"正在上传!"];
    [self.photoService uploadImage:_imageSource text:_contentTextView.text categoryId:_uploadCategoryId tagIdList:self.uploadtagId tagName:self.uploadtagName completion:^(BOOL isSuccess, NSString *message) {
        [SVProgressHUD dismiss];
        rightBarButton.enabled = YES;
        if (isSuccess) {
            [weakSelf navigationBackButtonClicked];
        }else{
            NSLog(@"%@",message);
        }
    }];
}

- (void)setUpUI{
    _submitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 90, 120, 100)];
    UIImage * newImage =[UIImage imageCompressed:_imageSource withdefineWidth:240];
    _submitImageView.image = newImage;
    _submitImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_submitImageView];
    
    _contentTextView = [[XXTextView alloc] initWithFrame:CGRectMake(140, 80, screenWidth-160, 120)];
    _contentTextView.xx_placeholder = @"添加照片说明";
    [self.view addSubview:_contentTextView];
   
}

- (void)setUpClassView{
    _classTagView = [[TTTagView alloc] initWithFrame:CGRectMake(0, 220,self.view.width ,200)];
    _classTagView.translatesAutoresizingMaskIntoConstraints=YES;
    _classTagView.delegate = self;
    _classTagView.selBgColor = HEX(@"fd8670");
    _classTagView.selTextColor = [UIColor whiteColor];
    _classTagView.selBorderColor = HEX(@"fd8670");
    _classTagView.bgColor = [UIColor whiteColor];
    _classTagView.textColor = HEX(@"fd8670");
    _classTagView.borderColor = HEX(@"fd8670");
    _classTagView.type = TTTagView_Type_Selected;
    
    [self.view addSubview:_classTagView];
}

- (void)setUpSubClassTagView{
    if (!_subClassTagView) {
        _subClassTagView = [[TTTagView alloc] initWithFrame:CGRectMake(0, _classTagView.changeHeight +220,self.view.width ,200)];
        _subClassTagView.translatesAutoresizingMaskIntoConstraints=YES;
        _subClassTagView.delegate = self;
        _subClassTagView.bgColor = HEX(@"f5f5f5");
        _subClassTagView.textColor = HEX(@"666666");
        _subClassTagView.borderColor = HEX(@"f5f5f5");
        _subClassTagView.selBgColor = HEX(@"fd8670");
        _subClassTagView.selTextColor = [UIColor whiteColor];
        _subClassTagView.selBorderColor = HEX(@"fd8670");
        _subClassTagView.type = TTTagView_Type_Selected;
        
        [self.view addSubview:_subClassTagView];
    }
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
            [weakSelf.classTagView addTags:_categoryArray];
            [weakSelf setUpSubClassTagView];
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
            [_tagsArray removeAllObjects];
            for (int i = 0 ; i<weakSelf.photoService.tagsArray.count; i++) {
                BTPhotoEntity *entity = weakSelf.photoService.tagsArray[i];
                [_tagsArray addObject:entity.tagName];
            }
            if (_tagsArray.count > 0) {
                [weakSelf.subClassTagView addTags:_tagsArray];
            }
        }else{
            [_tagsArray removeAllObjects];
            NSLog(@"%@",message);
        }
    }];
    
}

- (void)selectButtonWith:(id)tagView Title:(NSString *)string{
    if (tagView == _classTagView) {
        BTPhotoEntity *entity = [self.photoService getEntityWithTitle:string];
        self.uploadCategoryId = entity.categoryId;
        if (_tagsArray.count > 0) {
            [self.subClassTagView removeTags:_tagsArray];
        }
        [self setUpDataForCatogryTagViewWithCategoryid:self.uploadCategoryId categoryName:entity.categoryName];
    }else{
        BTPhotoEntity *entity = [self.photoService getTagCatgoryEntityWithTitle:string];
        self.uploadtagId = entity.tagId;
        self.uploadtagName = entity.tagName;
    }
   
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
