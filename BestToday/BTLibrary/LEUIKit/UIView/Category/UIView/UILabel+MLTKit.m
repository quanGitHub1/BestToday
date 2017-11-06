//
//  UILabel+MLTKit.m
//  AMCustomer
//
//  Created by fuyao on 16/9/5.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "UILabel+MLTKit.h"
#import <YYText.h>

@implementation UILabel (MLTKit)

+ (UILabel *)mlt_labelWithText:(NSString *)text color:(UIColor *)color align:(NSTextAlignment)align font:(UIFont *)font bkColor:(UIColor *)backgroundColor frame:(CGRect)frame {
    
    UILabel *label = [[UILabel alloc] init];
    
    if (!backgroundColor) {
        label.backgroundColor = [UIColor clearColor];
    }else {
        label.backgroundColor = backgroundColor;
    }
    
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.textAlignment = align;
    label.frame = frame;
    return label;
}

- (void)mlt_labelTextWithString:(NSString *)string LineSpace:(CGFloat)lineSpace textColor:(UIColor *)color {
    NSRange range = NSMakeRange(0, 0);
    [self mlt_labelTextWithString:string LineSpace:lineSpace textColor:color colorRange:range];
}

- (void)mlt_labelTextWithString:(NSString *)string LineSpace:(CGFloat)lineSpace textColor:(UIColor *)color colorRange:(NSRange)range {
    if (string && string.length > 0) {
        //段落属性
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = lineSpace;
        style.lineBreakMode = NSLineBreakByTruncatingTail;
        
        //带属性的文字
        NSDictionary *attriDict = @{NSParagraphStyleAttributeName :  style,
                                    NSForegroundColorAttributeName : color,
                                    NSFontAttributeName : self.font ? : [UIFont systemFontOfSize:12]
                                    };
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:string attributes:attriDict];
        
        if (range.length>0) {
            [attributeStr yy_setColor:color range:range];
        }
        
        self.attributedText = attributeStr;
    }
}

#pragma mark - Frame

- (CGFloat)mlt_flexibleHeight {
    CGSize maxSize = CGSizeMake(self.frame.size.width, MAXFLOAT);
    CGRect rect = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil];
    return rect.size.height;
}

- (CGFloat)mlt_flexibleWidth {
    CGSize maxSize = CGSizeMake(MAXFLOAT, self.frame.size.height);
    CGRect rect = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil];
    return rect.size.width;
}

- (CGSize)mlt_contentSize {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = self.lineBreakMode;
    style.alignment = self.textAlignment;
    
    NSDictionary *attributes = @{NSFontAttributeName : self.font,
                                 NSParagraphStyleAttributeName : style
                                 };
    
    CGSize contentSize = [self.text boundingRectWithSize:self.frame.size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    
    return contentSize;
}

- (void)mlt_adjustSizeWithWidth:(CGFloat)width {
    CGSize adjustSize = CGSizeZero;
    if (!self.font) {
        adjustSize = CGSizeZero;
    }else {
        adjustSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    }
    
    if (adjustSize.width > width) {
        adjustSize.width = width;
    }
    
    CGRect rect = self.frame;
    rect.size = adjustSize;
    self.frame = rect;
}

#pragma mark - Action

- (void)mlt_addTarget:(id)target action:(SEL)selector {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
}

#pragma mark -- 删除线 ---

-(void ) mlt_addStrikethroughWithColor:(UIColor *)color{
    [self mlt_addStrikethroughWithColor:color range:NSMakeRange(0, self.text.length)];
}

-(void ) mlt_addStrikethroughWithColor:(UIColor *)color range:(NSRange )range{
    [self mlt_addStrikethroughWithColor:color range:range height:1];
}

-(void ) mlt_addStrikethroughWithColor:(UIColor *)color range:(NSRange )range height:(CGFloat )height{
    
    if (!self.attributedText) self.attributedText = [[NSAttributedString alloc] initWithString:self.text];
    if (!color) color = [UIColor blackColor];
    
    NSMutableAttributedString *attrString = [self.attributedText mutableCopy];
    [attrString addAttribute:NSStrikethroughColorAttributeName value:color range:range];
    [attrString addAttribute:NSStrikethroughStyleAttributeName
                       value:@(height)
                       range:range];
    self.attributedText = attrString;
    
}

#pragma mark -- 下划线 ---

-(void ) mlt_addSUnderlineWithColor:(UIColor *)color{
    [self mlt_addSUnderlineWithColor:color range:NSMakeRange(0, self.text.length)];
}

-(void ) mlt_addSUnderlineWithColor:(UIColor *)color range:(NSRange )range{
    [self mlt_addSUnderlineWithColor:color range:range style:NSUnderlineStyleSingle];
}

-(void ) mlt_addSUnderlineWithColor:(UIColor *)color range:(NSRange )range style:(NSInteger )style{
    
    if (!self.attributedText) self.attributedText = [[NSAttributedString alloc] initWithString:self.text];
    if (!color) color = [UIColor blackColor];
    
    NSMutableAttributedString *attrString = [self.attributedText mutableCopy];
    [attrString addAttribute:NSUnderlineStyleAttributeName
                       value:[NSNumber numberWithInt:(NSUnderlineStyle )style]
                       range:range];
    [attrString addAttribute:NSUnderlineColorAttributeName value:color range:range];
    self.attributedText = attrString;
    
}

- (void)mlt_addSUnderlineWithColor:(UIColor *)color range:(NSRange )range style:(NSInteger )style spacing:(CGFloat )spacing{
    
    
    
}

@end
