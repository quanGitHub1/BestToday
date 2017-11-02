//
//  PageControl.m
//  PageControlDemo
//

#import "MLTPageControl.h"

@interface MLTPageControl ()

@property (nonatomic, strong) NSMutableDictionary *thumbImageForIndex;

@property (nonatomic, strong) NSMutableDictionary *selectedThumbImageForIndex;

@end

@implementation MLTPageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
	self=[super initWithCoder:aDecoder];
	if (self) {
		[self setup];
	}
	return self;
}

-(void)setup{
	[self setBackgroundColor:[UIColor clearColor]];
    
	_pageControlStyle = PageControlStyleDefault;

}

- (void)drawRect:(CGRect)rect{
    UIColor *coreNormalColor, *coreSelectedColor;
    
     coreNormalColor = self.currentPageDotColor;
    
     coreSelectedColor = self.otherPageDotColor;
    
    // Drawing code
    if (self.hidesForSinglePage && self.numberOfPages==1){
		return;
	}
	
	CGContextRef myContext = UIGraphicsGetCurrentContext();
	
	NSInteger gap = self.gapWidth;
    
    float diameter = self.diameter - 4;
    
    if (self.pageControlStyle == PageControlStyleThumb){
        if (self.thumbImage && self.selectedThumbImage){
            diameter = self.thumbImage.size.width;
        }
    }
	
	NSInteger total_width = self.numberOfPages * diameter + (self.numberOfPages - 1) * gap;
	
	if (total_width > self.frame.size.width){
		while (total_width > self.frame.size.width){
			diameter -= 2;
			gap = diameter + 2;
			while (total_width > self.frame.size.width){
				gap -= 1;
				total_width = self.numberOfPages * diameter + (self.numberOfPages - 1) * gap;
				
				if (gap == 2){
					break;
					total_width = self.numberOfPages * diameter + (self.numberOfPages - 1) * gap;
				}
			}
			
			if (diameter == 2){
				break;
				total_width = self.numberOfPages * diameter + (self.numberOfPages - 1) * gap;
			}
		}
    }
	
	int i;
	for (i = 0; i < self.numberOfPages; i++){
		int x = (self.frame.size.width - total_width)/2 + i * (diameter + gap);

        if (self.pageControlStyle == PageControlStyleDefault){
            if (i == self.currentPage){
                
                // 画圆并给填充色
                CGContextSetFillColorWithColor(myContext, [coreSelectedColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x, (self.frame.size.height - diameter)/2, diameter, diameter));
                CGContextSetStrokeColorWithColor(myContext, [coreSelectedColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height - diameter)/2, diameter, diameter));
            }
            else{
                
                // 画圆并给填充色
                CGContextSetFillColorWithColor(myContext, [coreNormalColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x, (self.frame.size.height - diameter)/2, diameter, diameter));
                CGContextSetStrokeColorWithColor(myContext, [coreNormalColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x, (self.frame.size.height - diameter)/2, diameter, diameter));
            }
        }
        
        else if (self.pageControlStyle==PageControlStyleThumb){
            UIImage* thumbImage = [self thumbImageForIndex:i];
            UIImage* selectedThumbImage = [self selectedThumbImageForIndex:i];
            
            if (thumbImage && selectedThumbImage){
                if (i == self.currentPage){
                    [selectedThumbImage drawInRect:CGRectMake(x, (self.frame.size.height - selectedThumbImage.size.height)/2, selectedThumbImage.size.width, selectedThumbImage.size.height)];
                }
                else{
                    [thumbImage drawInRect:CGRectMake(x, (self.frame.size.height - thumbImage.size.height)/2, thumbImage.size.width, thumbImage.size.height)];
                }
            }
        }
	}
}

- (void)setPageControlStyle:(PageControlStyle)style{
    _pageControlStyle = style;
    [self setNeedsDisplay];
}

- (void)setCurrentPage:(NSInteger)page{
    _currentPage = page;
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)numOfPages{
    _numberOfPages = numOfPages;
    [self setNeedsDisplay];
}

- (void)setThumbImage:(UIImage *)aThumbImage forIndex:(NSInteger)index {
    if (_thumbImageForIndex == nil) {
        [self setThumbImageForIndex:[NSMutableDictionary dictionary]];
    }
    
    if ((aThumbImage != nil))
        [_thumbImageForIndex setObject:aThumbImage forKey:@(index)];
    else
        [_thumbImageForIndex removeObjectForKey:@(index)];
    
    [self setNeedsDisplay];
}

- (UIImage *)thumbImageForIndex:(NSInteger)index {
    UIImage* aThumbImage = [_thumbImageForIndex objectForKey:@(index)];
    if (aThumbImage == nil)
        aThumbImage = self.thumbImage;
    
    return aThumbImage;
}

- (void)setSelectedThumbImage:(UIImage *)aSelectedThumbImage forIndex:(NSInteger)index {
    if (_selectedThumbImageForIndex == nil) {
        [self setSelectedThumbImageForIndex:[NSMutableDictionary dictionary]];
    }
    
    if ((aSelectedThumbImage != nil))
        [_selectedThumbImageForIndex setObject:aSelectedThumbImage forKey:@(index)];
    else
        [_selectedThumbImageForIndex removeObjectForKey:@(index)];
    
    [self setNeedsDisplay];
}

- (UIImage *)selectedThumbImageForIndex:(NSInteger)index {
    UIImage* aSelectedThumbImage = [_selectedThumbImageForIndex objectForKey:@(index)];
    if (aSelectedThumbImage == nil)
        aSelectedThumbImage = self.selectedThumbImage;
    
    return aSelectedThumbImage;
}

@end
