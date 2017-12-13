//
//  BTMeEditInforViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/10.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTMeEditInforViewController.h"
#import "BTMeEditInforService.h"
#import "SQButtonTagView.h"
#import "BTPhotoService.h"
#import "BTPhotoEntity.h"

@interface BTMeEditInforViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>


@property (nonatomic, strong) UILabel *labName;

@property (nonatomic, strong) UILabel *labProduct;

@property (nonatomic, strong) UILabel *labTag;

@property (nonatomic, strong) UITextField *textViewName;

@property (nonatomic, strong) UITextView *textProduct;

@property (nonatomic, strong)  UIImageView *imageView;

@property (nonatomic, strong)  BTMeEditInforService *editService;

@property (nonatomic, strong) SQButtonTagView * classTagView;

@property (nonatomic, strong) SQButtonTagView * subClassTagView;

@property (nonatomic, strong) BTPhotoService * photoService;

@property (nonatomic, strong) NSMutableArray * categoryArray;// 一级列表分类
@property (nonatomic, strong) NSMutableArray * tagsArray;

@end

@implementation BTMeEditInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgationBar];
    
    _categoryArray = [NSMutableArray array];
    _tagsArray = [NSMutableArray array];
    
    UIView *viewHeader = [self createView:CGRectMake(0, 64, FULL_WIDTH, FULL_HEIGHT - NAVBAR_HEIGHT)];
    
    [self.view addSubview:viewHeader];
    
    [self setUpDataForTagView];
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
    
    btnLeft.titleLabel.backgroundColor = [UIColor redColor];
    
    btnLeft.backgroundColor = [UIColor redColor];

     [self.navigationBar setLeftBarButton:[UIButton mlt_rightBarButtonWithImage:[UIImage imageNamed:@"info_backs"] highlightedImage:nil target:self action:@selector(navigationBackButtonClicked:) forControlEvents:UIControlEventTouchUpInside]];
    
    UIButton *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(FULL_WIDTH - 55, 35, 50, 30)];
    
    [btnRight setTitle:@"完成" forState:UIControlStateNormal];
    
    [btnRight addTarget:self action:@selector(onclickBtnSure:) forControlEvents:UIControlEventTouchUpInside];

    btnRight.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [btnRight setTitleColor:[UIColor colorWithHexString:@"#fd8671" alpha:1] forState:UIControlStateNormal];
    
    [self.navigationBar addSubview:btnRight];
    
}


- (UIView *)createView:(CGRect)frame{
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((FULL_WIDTH - ScaleWidth(81))/2, 32, ScaleWidth(81), ScaleWidth(81))];
    
    _imageView.backgroundColor = [UIColor whiteColor];
    
//    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _imageView.layer.cornerRadius = ScaleWidth(81/2);
    
    _imageView.clipsToBounds = YES;
    
    [_imageView setImage:_picAvtar];
    
    /**
     *  添加手势：也就是当用户点击头像了之后，对这个操作进行反应
     */
    //允许用户交互
    _imageView.userInteractionEnabled = YES;
    //初始化一个手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                               action:@selector(alterHeadPortrait:)];
    //给ImageView添加手势
    [_imageView addGestureRecognizer:singleTap];
        
    
    UILabel *labChange = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageView.bottom + 7, FULL_WIDTH, 16)];
    
    labChange.text = @"更换头像";
    
    labChange.textColor = [UIColor colorWithHexString:@"#fd8671"];
    
    labChange.textAlignment = NSTextAlignmentCenter;
    
    _labName = [[UILabel alloc] initWithFrame:CGRectMake(15, labChange.bottom + 50, 40, 16)];
    
    _labName = [UILabel mlt_labelWithText:@"昵称" color:[UIColor mlt_colorWithHexString:@"#969696" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:15] bkColor:nil frame:CGRectMake(15, labChange.bottom + 50, 40, 16)];
    
    _labProduct = [UILabel mlt_labelWithText:@"简介" color:[UIColor mlt_colorWithHexString:@"#969696" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:15] bkColor:nil frame:CGRectMake(15, _labName.bottom + 50, 40, 16)];
    
    _textViewName = [[UITextField alloc] initWithFrame:CGRectMake(_labName.right + 30, _labName.top - 8, FULL_WIDTH - _labName.right - 45, 40)];
    
    _textViewName.text = self.nikeName;
        
    _textViewName.font = [UIFont systemFontOfSize:15];
    
    _textViewName.textColor = [UIColor colorWithHexString:@"#212121"];
    
    
    _textProduct = [[UITextView alloc] initWithFrame:CGRectMake(_labProduct.right + 30, _labProduct.top - 15, FULL_WIDTH - _labProduct.right - 45, 70)];
    
    _textProduct.textColor = [UIColor colorWithHexString:@"#212121"];

    _textProduct.text = self.introduction;
    
    _textProduct.font = [UIFont systemFontOfSize:15];
    

    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(_labName.right + 15, _labName.bottom + 15, FULL_WIDTH - _labName.right - 30, 1)];
    
    viewLine.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    
    UIView *viewLineTwo = [[UIView alloc] initWithFrame:CGRectMake(_labProduct.right + 15, _textProduct.bottom + 1, FULL_WIDTH - _labProduct.right - 30, 1)];
    
    viewLineTwo.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    _labTag = [UILabel mlt_labelWithText:@"标签" color:[UIColor mlt_colorWithHexString:@"#969696" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:15] bkColor:nil frame:CGRectMake(_labName.left, viewLineTwo.bottom + 30, _labProduct.width, _labProduct.height)];

    
    [view addSubview:viewLineTwo];
    
    [view addSubview:viewLine];
    
    [view addSubview:_labName];
    [view addSubview:_labProduct];
    
    [view addSubview:_textProduct];
    
    [view addSubview:_textViewName];
   
    [view addSubview:labChange];
    [view addSubview:_imageView];
    
    [view addSubview:_labTag];
    
    return view;
}

- (void)setUpClassView{
    _classTagView = [[SQButtonTagView alloc] initWithTotalTagsNum:self.categoryArray.count viewWidth:screenWidth - 30 - _labTag.right eachNum:0 Hmargin:10 Vmargin:10 tagHeight:30 tagTextFont:[UIFont systemFontOfSize:14.f] tagTextColor:[[UIColor redColor] colorWithAlphaComponent:0.5] selectedTagTextColor:[UIColor whiteColor] selectedBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.5]];
    _classTagView.frame = CGRectMake(_labTag.right + 20, _labTag.bottom + 40, screenWidth - _labTag.right - 30, 200);
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

- (void)setUpClassViewFrame{
    CGFloat height = [SQButtonTagView returnViewHeightWithTagTexts:_categoryArray viewWidth:screenWidth - 30 - _labTag.right eachNum:0 Hmargin:10 Vmargin:10 tagHeight:30 tagTextFont:[UIFont systemFontOfSize:14.f]];
    CGRect frame = self.classTagView.frame;
    frame.size.height = height;
    self.classTagView.frame = frame;
}

- (void)setUpSubClassViewFrame{
    CGFloat height = [SQButtonTagView returnViewHeightWithTagTexts:_tagsArray viewWidth:screenWidth - 30 - _labTag.right eachNum:0 Hmargin:10 Vmargin:10 tagHeight:30 tagTextFont:[UIFont systemFontOfSize:14.f]];
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

- (void)setUpSubClassTagView{
    if (!_subClassTagView) {
        CGFloat height = [SQButtonTagView returnViewHeightWithTagTexts:_categoryArray viewWidth:screenWidth - 30 - _labTag.right eachNum:0 Hmargin:10 Vmargin:10 tagHeight:30 tagTextFont:[UIFont systemFontOfSize:14.f]];
        _subClassTagView = [[SQButtonTagView alloc] initWithTotalTagsNum:_tagsArray.count viewWidth:screenWidth-20 eachNum:0 Hmargin:10 Vmargin:10 tagHeight:30 tagTextFont:[UIFont systemFontOfSize:14.f] tagTextColor:[[UIColor redColor] colorWithAlphaComponent:0.5] selectedTagTextColor:[UIColor whiteColor] selectedBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.5]];
        _subClassTagView.frame = CGRectMake(_labTag.right + 20, _labTag.top + 62 + height, screenWidth - 30 - _labTag.right, 200);
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


- (void)loadData{
    [self requestUpdateAvtar];
}

- (void)requestUpdateAvtar{

    [self.editService loadqueryUpdateAvatar:_imageView.image completion:^(BOOL isSuccess, BOOL isCache) {
        
    }];
    
}

//  方法：alterHeadPortrait
-(void)alterHeadPortrait:(UITapGestureRecognizer *)gesture{
   
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    _imageView.image = newPhoto;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self loadData];
}

- (void)navigationBackButtonClicked:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onclickBtnCancel:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)onclickBtnSure:(UIButton *)btn{
    
    NSArray *arr = @[@"美术"];
    
    [self.editService loadqueryUpdateUserwithName:_textViewName.text introduction:_textProduct.text personalTags:arr completion:^(BOOL isSuccess, BOOL isCache) {
            
        self.updateInforBlock(_textViewName.text, _textProduct.text, _imageView.image);
        
        [self.navigationController popViewControllerAnimated:YES];

        
    }];
}

#pragma mark - lazy
- (BTMeEditInforService *)editService {
    if (!_editService) {
        _editService = [[BTMeEditInforService alloc] init];
    }
    return _editService;
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


@end
