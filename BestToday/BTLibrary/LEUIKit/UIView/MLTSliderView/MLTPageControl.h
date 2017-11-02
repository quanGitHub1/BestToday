

#import <UIKit/UIKit.h>

/**
  * 创建一个pageControl主要是给MLTSliderView用的
  * 这个pageControl
 */

typedef enum{
    PageControlStyleDefault = 0,     // 默认的样式圆圈
    PageControlStyleThumb = 1,      // 特殊样式用图片来显示
} PageControlStyle;

@interface MLTPageControl : UIControl

/**
 *  当前dot颜色
 */
@property (nonatomic, strong) UIColor *currentPageDotColor;


/**
 * 其它dot颜色
 */
@property (nonatomic, strong) UIColor *otherPageDotColor;


/**
 * 当前选中的dot
 */
@property (nonatomic) NSInteger currentPage;

/**
 * 一共有多少页
 */
@property (nonatomic) NSInteger numberOfPages;

/**
 * 样式
 */
@property (nonatomic, assign) PageControlStyle pageControlStyle;

/**
 *  设置当总页数为1时，是否自动隐藏控制器
 */
@property (nonatomic, assign) BOOL hidesForSinglePage;

/**
 *  dot 的直径
*/
@property (nonatomic, assign) NSInteger diameter;

/**
 *  相邻dot之间的间距
 */
@property (nonatomic, assign) NSInteger gapWidth;


/**
 *  未选中dot图片
 */
@property (nonatomic, strong) UIImage *thumbImage;


/**
  * 选中dot图片
 */
@property (nonatomic, strong) UIImage *selectedThumbImage;

@end
