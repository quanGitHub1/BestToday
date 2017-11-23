//
//  OpenDetailsView.m
//  点击展开详情
//
//  Created by 苗建浩 on 2017/6/6.
//  Copyright © 2017年 苗建浩. All rights reserved.
//

#import "OpenDetailsView.h"
#import "OpenDetailsView.h"
#import "Header.h"
#import "CoreText/CoreText.h"
#import "BTHomeOpenHander.h"
#import "BTHomeComment.h"


@interface OpenDetailsView()
@property (nonatomic, assign) CGRect detaFrame;
@property (nonatomic, strong) NSArray *textArr;
@property (nonatomic, assign) int font;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, copy) NSString *textStr;
@property (nonatomic, assign) NSInteger indexpath;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, strong) NSArray *commentArry;

@property (nonatomic, strong) NSString *totalCommentMsg;



@end

@implementation OpenDetailsView

+ (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text totalCommentMsg:(NSString *)totalCommentMsg comment:(NSArray *)commentArr font:(int)font numberOfRow:(int)row indexPath:(NSInteger)indexpath block:(void (^)(CGFloat, NSInteger))block{
    OpenDetailsView *detailsView = [[OpenDetailsView alloc] initWithFrame:frame];
    detailsView.detaFrame = frame;
    detailsView.textStr = text;
    detailsView.commentArry = commentArr;
    detailsView.totalCommentMsg = totalCommentMsg;
    detailsView.font = font;
    detailsView.sendHeightBlock = block;
    [detailsView frame:frame text:text font:font numberOfRow:row indexpath:indexpath];
    return detailsView;
}


- (void)frame:(CGRect)frame text:(NSString *)text font:(int)font numberOfRow:(int)row indexpath:(NSInteger)indexpath{
    
        CGFloat height = [text heightWithText:text font:font width:screenWidth - 20];
        if (height > font * row) {
            height = font * row;
        }
        
        _indexpath = indexpath;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, height)];
        textLabel.backgroundColor = [UIColor whiteColor];
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        textLabel.font = [UIFont systemFontOfSize:font];
        self.textLabel = textLabel;
        textLabel.textColor = [UIColor colorWithHexString:@"#616161"];
        [self addSubview:textLabel];
        
        _textArr = [self getSeparatedLinesFromLabel:textLabel];
    
        if (_textArr.count >= 2) {
            
            
            NSString *str = [NSString stringWithFormat:@"%@",_textArr[row - 2]];
            int number = (int)str.length;
            str = [str substringToIndex:number - 8];
            
            NSString *showStr1 = [NSString stringWithFormat:@"%@...",str];
            CGFloat width = showStr1.length * 16;
            
            _width = width;
            
            NSString *showStr = [NSString stringWithFormat:@"%@%@%@...",_textArr[0],_textArr[1],str];
            
            textLabel.text = showStr;
            
        }
        
        // 设置label的行间距
        NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle  setLineSpacing:8];
        
        
        NSMutableAttributedString  *setString;
        
        if (textLabel.text > 0) {
            
            setString = [[NSMutableAttributedString alloc] initWithString:textLabel.text];
            
            [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, textLabel.text.length)];
            
        }
        
        textLabel.attributedText = setString;
        
        [textLabel sizeToFit];
    
    if ([[BTHomeOpenHander shareHomeOpenHander].arrydata containsObject:[NSString stringWithFormat:@"%ld",_indexpath]]) {
        
        // 设置label的行间距
        NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle  setLineSpacing:8];
        
        
        NSMutableAttributedString  *setString;
        
        
        setString = [[NSMutableAttributedString alloc] initWithString:text];
        
        [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
        
        
        _textLabel.attributedText = setString;
        
        [_textLabel sizeToFit];
        
        _heightLabTwo = _textLabel.bottom;
        
        [self creatLabData:@"YES"];

        
        return;

     }

    if (_textArr.count >= 2) {
        
        UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        openBtn.frame = CGRectMake(_width - 20, font * 3 + 8, screenWidth - _width - 10, font );
        openBtn.backgroundColor = [UIColor whiteColor];
        [openBtn setTitle:@"更多" forState:0];
        openBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [openBtn setTitleColor:[UIColor colorWithHexString:@"#616161"] forState:UIControlStateNormal];
        
        [openBtn addTarget:self action:@selector(openBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:openBtn];
    }

    _heightLabTwo = _textLabel.height;

    [self creatLabData:@"YES"];

}


- (NSArray *)getSeparatedLinesFromLabel:(UILabel *)label
{
    NSString *text = [label text];
    UIFont *font = [label font];
    CGRect rect = [label frame];
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines){
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return linesArray;
}

- (void)creatLabData:(NSString *)isAdd{
    
    UIView *viewLine;
    
    if (_textStr.length == 0) {
        
       viewLine = [[UIView alloc] initWithFrame:CGRectMake(0,  _textLabel.bottom , FULL_WIDTH - 20, 0.6)];

    }else {
        viewLine = [[UIView alloc] initWithFrame:CGRectMake(0,  _textLabel.bottom + 13, FULL_WIDTH - 20, 0.6)];

    }
    
    viewLine.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    [self addSubview:viewLine];

    CGFloat heightLab = 0.0;
    
    for (int i = 0; i < _commentArry.count; i++) {
        
        BTHomeComment *comment = [_commentArry objectAtIndex:i];
        
        UILabel *labComment;
        
        // 如果没有描述 评论重0开始添加
        if (_textLabel.text.length == 0) {
            
            labComment = [[UILabel alloc] initWithFrame:CGRectMake(0, heightLab + _textLabel.bottom + 13.6 , FULL_WIDTH - 30, 0)];
        }else {
        
             labComment = [[UILabel alloc] initWithFrame:CGRectMake(0, heightLab + _textLabel.bottom + 26, FULL_WIDTH - 30, 0)];
        }

        labComment.textColor = [UIColor colorWithHexString:@"#616161"];
        
        labComment.font = [UIFont systemFontOfSize:15];

        
        // 把名字和评论拼接上
        NSString *strComment = [NSString stringWithFormat:@"%@： %@", comment.commentNickName, comment.content];
        
        // 设置label的行间距
        NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle  setLineSpacing:8];
        
        NSMutableAttributedString  *setString;
        
        NSRange range = NSMakeRange(0, comment.commentNickName.length + 1);

        setString = [[NSMutableAttributedString alloc] initWithString:strComment];
        
        [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [strComment length])];
        
        // 设置颜色
        [setString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#212121"] range:range];
        
        [setString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:range];


        
        labComment.attributedText = setString;
        
        labComment.numberOfLines = 3;
        
        [labComment sizeToFit];
        
        heightLab += labComment.height + 10;
        
        _heightLabTwo = labComment.bottom;
        
        if ([isAdd isEqualToString:@"YES"]) {
            
            [self addSubview:labComment];
        }
        
    }
    
    UIButton *btnComment = [[UIButton alloc] initWithFrame:CGRectMake(0, _heightLabTwo + 4, FULL_WIDTH - 20, 20)];
    
    [btnComment setTitle:_totalCommentMsg forState:UIControlStateNormal];
    
    [btnComment setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];
    
    btnComment.titleLabel.font = [UIFont systemFontOfSize:14];
    
    if (_commentArry.count == 0) {
        
        return;
    }
    
    _heightLabTwo = btnComment.bottom;
    
    btnComment.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    [self addSubview:btnComment];

}

- (void)openBtnClick:(UIButton *)sender{
    
    if (![[BTHomeOpenHander shareHomeOpenHander].arrydata containsObject:[NSString stringWithFormat:@"%ld",_indexpath]]) {
        [[BTHomeOpenHander shareHomeOpenHander].arrydata addObject:[NSString stringWithFormat:@"%ld",_indexpath]];
    }
    
    // 设置label的行间距
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

    [paragraphStyle  setLineSpacing:8];

    NSMutableAttributedString  *setString;

    setString = [[NSMutableAttributedString alloc] initWithString:_textStr];

    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _textStr.length)];

    _textLabel.attributedText = setString;
    
    [_textLabel sizeToFit];
    
    _heightLabTwo = _textLabel.bottom;
    
    [self creatLabData:@"NO"];
    
    sender.hidden = YES;
    
    if (self.sendHeightBlock) {
        
        self.sendHeightBlock(_heightLabTwo, _indexpath);
        
    }
}

@end
