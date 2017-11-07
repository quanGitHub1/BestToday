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


@interface OpenDetailsView()
@property (nonatomic, assign) CGRect detaFrame;
@property (nonatomic, strong) NSArray *textArr;
@property (nonatomic, assign) int font;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, copy) NSString *textStr;

@end

@implementation OpenDetailsView

+ (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text font:(int)font numberOfRow:(int)row block:(void (^)(CGFloat))block{
    OpenDetailsView *detailsView = [[OpenDetailsView alloc] initWithFrame:frame];
    detailsView.detaFrame = frame;
    detailsView.textStr = text;
    detailsView.font = font;
    detailsView.sendHeightBlock = block;
    [detailsView frame:frame text:text font:font numberOfRow:row];
    return detailsView;
}


- (void)frame:(CGRect)frame text:(NSString *)text font:(int)font numberOfRow:(int)row{
    
    CGFloat height = [text heightWithText:text font:font width:screenWidth - 20];
    if (height > font * row) {
        height = font * row;
    }
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, height)];
    textLabel.backgroundColor = [UIColor whiteColor];
    textLabel.text = text;
    textLabel.numberOfLines = 0;
    textLabel.font = [UIFont systemFontOfSize:font];
    self.textLabel = textLabel;
    textLabel.textColor = [UIColor colorWithHexString:@"#616161"];
    [self addSubview:textLabel];
    
    _textArr = [self getSeparatedLinesFromLabel:textLabel];
    
    NSString *str = [NSString stringWithFormat:@"%@",_textArr[row - 2]];
    int number = (int)str.length;
    str = [str substringToIndex:number - 8];
    
    
    NSString *showStr1 = [NSString stringWithFormat:@"%@...",str];
    CGFloat width = showStr1.length * 16;
    
    NSString *showStr = [NSString stringWithFormat:@"%@%@%@...",_textArr[0],_textArr[1],str];
    textLabel.text = showStr;
    
        // 设置label的行间距
        NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
        [paragraphStyle  setLineSpacing:8];
    
    
        NSMutableAttributedString  *setString;
    
        if (showStr.length > 0) {
    
            setString = [[NSMutableAttributedString alloc] initWithString:showStr];
    
            [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, showStr.length)];
    
        }
        
        textLabel.attributedText = setString;
    
    [textLabel sizeToFit];
  
    
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    openBtn.frame = CGRectMake(width - 20, font * 3 + 8, screenWidth - width - 10, font );
    openBtn.backgroundColor = [UIColor whiteColor];
    [openBtn setTitle:@"更多" forState:0];
    openBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    
    [openBtn setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];
    
    [openBtn addTarget:self action:@selector(openBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:openBtn];
    
    
    
//    // 设置label的行间距
//    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    
//    [paragraphStyle  setLineSpacing:8];
//    
//    
//    NSMutableAttributedString  *setString;
//    
//    if (text.length > 0) {
//        
//        setString = [[NSMutableAttributedString alloc] initWithString:text];
//        
//        [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
//        
//    }
//    
//    textLabel.attributedText = setString;
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

- (void)openBtnClick:(UIButton *)sender{
    
    CGFloat height = [_textStr heightWithText:_textStr font:_font width:_textLabel.bounds.size.width] + _font / 2;
    _textLabel.frame = CGRectMake(0, 0, _detaFrame.size.width, height);
    _textLabel.text = _textStr;
    sender.hidden = YES;
    
    if (self.sendHeightBlock) {
        self.sendHeightBlock(height);
    }
}


@end
