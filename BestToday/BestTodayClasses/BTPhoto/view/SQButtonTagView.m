//
//  SQButtonTagView.m
//  SQButtonTagView
//
//  Created by yangsq on 2017/9/26.
//  Copyright © 2017年 yangsq. All rights reserved.
//

#import "SQButtonTagView.h"

#import "BTPhotoEntity.h"

@interface SQButtonTagView ()

@property (assign, nonatomic) NSInteger totalTagsNum;
@property (assign, nonatomic) CGFloat hmargin;
@property (assign, nonatomic) CGFloat vmargin;
@property (assign, nonatomic) CGFloat viewWidth;
@property (assign, nonatomic) CGFloat tagHeight;
@property (strong, nonatomic) NSMutableArray *buttonTags;
@property (strong, nonatomic) UIFont *tagTextFont;
@property (strong, nonatomic) UIColor *tagTextColor;
@property (strong, nonatomic) UIColor *selectedTagTextColor;
@property (strong, nonatomic) UIColor *selectedBackgroundColor;

@property (strong, nonatomic) NSMutableArray *selectArray;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation SQButtonTagView

- (void)dealloc{
    _buttonTags = nil;
    _tagTextFont = nil;
    _selectedTagTextColor = nil;
    _selectArray = nil;
}


- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = @[].mutableCopy;
    }
    return _selectArray;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (id)initWithTotalTagsNum:(NSInteger)totalTagsNum
                 viewWidth:(CGFloat)viewWidth
                   eachNum:(NSInteger)eachNum
                   Hmargin:(CGFloat)hmargin
                   Vmargin:(CGFloat)vmargin
                 tagHeight:(CGFloat)tagHeight
               tagTextFont:(UIFont *)tagTextFont
              tagTextColor:(nonnull UIColor *)tagTextColor
      selectedTagTextColor:(nonnull UIColor *)selectedTagTextColor
   selectedBackgroundColor:(UIColor *)selectedBackgroundColor{
    
    if (self = [super init]) {
        self.totalTagsNum = totalTagsNum;
        self.eachNum = eachNum;
        self.hmargin = hmargin;
        self.vmargin = vmargin;
        self.viewWidth = viewWidth;
        self.tagHeight = tagHeight;
        self.tagTextFont = tagTextFont;
        self.buttonTags = @[].mutableCopy;
        self.tagTextColor = tagTextColor;
        self.selectedTagTextColor = selectedTagTextColor;
        self.selectedBackgroundColor = selectedBackgroundColor;
       
        for (NSInteger i=0; i<totalTagsNum; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.layer.cornerRadius = 2.5;
            button.layer.borderColor = tagTextColor.CGColor;
            button.layer.borderWidth = 0.5;
            [button setTitleColor:tagTextColor forState:UIControlStateNormal];
            button.titleLabel.font = tagTextFont;
            [self addSubview:button];
            [self.buttonTags addObject:button];
            button.tag = 101+i;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        }

    }
    
    return self;
}

+ (CGFloat)returnViewHeightWithTagTexts:(NSArray *)tagTexts viewWidth:(CGFloat)viewWidth eachNum:(NSInteger)eachNum Hmargin:(CGFloat)hmargin Vmargin:(CGFloat)vmargin tagHeight:(CGFloat)tagHeight tagTextFont:(UIFont *)tagTextFont{
    CGFloat Height = 0;
    if (eachNum>0) {
        if (tagTexts.count>0) {
            NSInteger a = tagTexts.count/eachNum;
            NSInteger b = tagTexts.count%eachNum;
            if (b>0&&a>=0) {
                a+=1;
            }
            Height = a*tagHeight + (a-1)*vmargin;
        }
        
    }else{
        CGFloat totalWith = 0;
        NSInteger row = 0;
        for (NSInteger i=0; i<tagTexts.count; i++) {
            NSString *tempString = tagTexts[i];
            CGFloat itemWidth = [[self alloc]sizeForText:tempString Font:tagTextFont size:CGSizeMake(MAXFLOAT, tagHeight) mode:NSLineBreakByWordWrapping].width+20;
            totalWith +=itemWidth+hmargin;
            if (totalWith-hmargin>viewWidth) {
                totalWith = itemWidth+hmargin;
                row+=1;
            }
        }
        
        Height = tagHeight*(row+1)+row*vmargin;
    }
    
    return Height;
}


- (void)setTagTexts:(NSArray *)tagTexts{
    self.dataArray = tagTexts;
    if (self.eachNum>0) {
        
        CGFloat with = (self.viewWidth-(self.eachNum-1)*self.hmargin)/self.eachNum;
        
        
        for (NSInteger i=0; i<self.buttonTags.count; i++) {
            UIButton *button = self.buttonTags[i];
            if (i<tagTexts.count) {
                BTPhotoEntity *entity = tagTexts[i];
                [button setTitle:tagTexts[i] forState:UIControlStateNormal];
                NSInteger a = i/self.eachNum;
                NSInteger b = i%self.eachNum;
                button.frame = (CGRect){b*(with+self.hmargin),a*(self.tagHeight+self.vmargin),with,self.tagHeight};
                [button setHidden:NO];
                [button setTitle:entity.categoryName forState:UIControlStateNormal];
                
                
            }else{
                [button setHidden:YES];
            }
        }
    }else{
        
        __block CGFloat totalWidth = 0;
        __block NSInteger row = 0;
        [self.buttonTags enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx<tagTexts.count) {
                BTPhotoEntity *entity = tagTexts[idx];
                [button setTitle:entity.categoryName forState:UIControlStateNormal];
                CGFloat itemWidth = [self sizeForText:entity.categoryName Font:self.tagTextFont size:CGSizeMake(MAXFLOAT, self.tagHeight) mode:NSLineBreakByWordWrapping].width+20;
              
                totalWidth+=itemWidth+self.hmargin;
                if (totalWidth-self.hmargin>self.viewWidth) {
                    totalWidth = itemWidth+self.hmargin;
                    row+=1;
                    button.frame = CGRectMake(0, row*(self.tagHeight+self.vmargin), itemWidth, self.tagHeight);
                }else{
                    button.frame = CGRectMake(totalWidth-itemWidth-self.hmargin, row*(self.tagHeight+self.vmargin), itemWidth, self.tagHeight);
                }
                [button setHidden:NO];
                [button setTitle:entity.categoryName forState:UIControlStateNormal];
                
            }else{
                [button setHidden:YES];
                
            }
            
            
        }];
        
    }

}



- (void)buttonAction:(UIButton *)button{
    
   
    NSInteger tag = button.tag-101;
    BTPhotoEntity * entity = self.dataArray[tag];
    BOOL isCancle = NO;
    for (BTPhotoEntity *enty in self.selectArray) {
        if ([enty.categoryName isEqualToString:entity.categoryName]) {
            [self.selectArray removeObject:enty];
            isCancle = YES;
            break;
        }
    }
    if (isCancle) {
        [self.selectArray removeObject:entity];
    }else{
        if (self.selectArray.count==self.maxSelectNum&&self.maxSelectNum>0) {
            NSLog(@"最多选择%@",[NSString stringWithFormat:@"%ld个",self.maxSelectNum]);
        }else{
            [self.selectArray addObject:entity];
        }
    }
    
    if (self.selectBlock) {
        self.selectBlock(self, self.selectArray.copy);
    }
    
    [self refreshView];
}


- (void)selectAction:(void (^)(SQButtonTagView * _Nonnull, NSArray * _Nonnull))block{
    self.selectBlock = block;
}


- (void)refreshView{
    
    for (UIButton *buttonTag in self.buttonTags) {
         BTPhotoEntity * entity = self.dataArray[buttonTag.tag-101];
        BOOL isExist = NO;
        for (BTPhotoEntity *enty in self.selectArray) {
            if ([enty.categoryName isEqualToString:entity.categoryName]) {
                isExist = YES;
                break;
            }
        }
        if (isExist) {
            [buttonTag setBackgroundColor:self.selectedBackgroundColor];
            [buttonTag setTitleColor:self.selectedTagTextColor forState:UIControlStateNormal];
            buttonTag.layer.borderColor = self.selectedBackgroundColor.CGColor;
        }else{
            [buttonTag setBackgroundColor:nil];
            [buttonTag setTitleColor:self.tagTextColor forState:UIControlStateNormal];
            buttonTag.layer.borderColor = self.tagTextColor.CGColor;
        }
    }
}

- (void)refreshViewWith:(NSArray *)dataArray{
    if (dataArray.count <= 0) {
        return;
    }
    NSMutableArray *tagsArray = [NSMutableArray array];
    for (int i = 0; i<dataArray.count; i++) {
        BTPhotoEntity * entity = dataArray[i];
        [self.selectArray addObject:entity];
        for (int j = 0; j<self.dataArray.count; j++) {
            BTPhotoEntity *allEntity = self.dataArray[j];
            if ([entity.categoryName isEqualToString:allEntity.categoryName]) {
                [tagsArray addObject:@(j)];
                break;
            }
        }
    }
    NSLog(@"%@",tagsArray);
    for (int index = 0; index < tagsArray.count; index ++) {
        NSInteger tag = [tagsArray[index] integerValue];
        UIButton *button = self.buttonTags[tag];
        [button setBackgroundColor:self.selectedBackgroundColor];
        [button setTitleColor:self.selectedTagTextColor forState:UIControlStateNormal];
        button.layer.borderColor = self.selectedBackgroundColor.CGColor;
        
    }
}

- (CGSize)sizeForText:(NSString *)text Font:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [text boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [text sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
