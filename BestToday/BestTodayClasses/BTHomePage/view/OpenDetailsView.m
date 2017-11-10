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


@interface OpenDetailsView()
@property (nonatomic, assign) CGRect detaFrame;
@property (nonatomic, strong) NSArray *textArr;
@property (nonatomic, assign) int font;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, copy) NSString *textStr;
@property (nonatomic, assign) NSInteger indexpath;

@end

@implementation OpenDetailsView

+ (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text font:(int)font numberOfRow:(int)row indexPath:(NSInteger)indexpath block:(void (^)(CGFloat, NSInteger))block{
    OpenDetailsView *detailsView = [[OpenDetailsView alloc] initWithFrame:frame];
    detailsView.detaFrame = frame;
    detailsView.textStr = text;
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


    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    openBtn.frame = CGRectMake(width - 20, font * 3 + 8, screenWidth - width - 10, font );
    openBtn.backgroundColor = [UIColor whiteColor];
    [openBtn setTitle:@"更多" forState:0];
    openBtn.titleLabel.font = [UIFont systemFontOfSize:15];

    [openBtn setTitleColor:[UIColor colorWithHexString:@"#616161"] forState:UIControlStateNormal];
    
    [openBtn addTarget:self action:@selector(openBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:openBtn];
    
  

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

    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0,  _textLabel.bottom + 13, FULL_WIDTH - 20, 0.6)];
    
    viewLine.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    [self addSubview:viewLine];
    
    NSArray *arrData = @[@"阿加阿达科技大厦空军啊空军打卡多久啊开始搭建啊看来大家啊看来大家啊可怜的", @"阿加阿达科技大厦空军啊空军打卡多久啊开始搭建啊看来大家啊看来大家啊可怜的符合双方就开始恢复健康顺利返回就开始了复活节凯撒绿肥红瘦开发和科技阿里复活节卡洛斯复活节卡什莱夫", @"小阿联军啊jlksjfklsajfl;kasfjkls;afjas;l"];
    
    CGFloat heightLab = 0.0;
    
    for (int i = 0; i < arrData.count; i++) {
        
        UILabel *labComment = [[UILabel alloc] initWithFrame:CGRectMake(0, heightLab + _textLabel.bottom + 26, FULL_WIDTH - 30, 0)];
        
        labComment.textColor = [UIColor colorWithHexString:@"#616161"];
        
        // 设置label的行间距
        NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle  setLineSpacing:8];
        
        NSMutableAttributedString  *setString;
        
        setString = [[NSMutableAttributedString alloc] initWithString:arrData[i]];
        
        [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [arrData[i] length])];
        
        labComment.attributedText = setString;
        
        labComment.numberOfLines = 3;
        
        labComment.font = [UIFont systemFontOfSize:15];
        
        [labComment sizeToFit];
        
        heightLab += labComment.height + 10;
        
        _heightLabTwo = labComment.bottom;
        
        if ([isAdd isEqualToString:@"YES"]) {
            
            [self addSubview:labComment];
        }
        
    }
    
    UIButton *btnComment = [[UIButton alloc] initWithFrame:CGRectMake(0, _heightLabTwo, FULL_WIDTH - 20, 20)];
    
    [btnComment setTitle:@"全部三条评论" forState:UIControlStateNormal];
    
    [btnComment setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];
    
    btnComment.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _heightLabTwo = btnComment.bottom;

//    btnComment.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    btnComment.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    
//    btnComment.backgroundColor = [UIColor redColor];
    
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
