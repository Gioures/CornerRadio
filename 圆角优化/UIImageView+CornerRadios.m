// 消耗内存，没有离屏渲染
//imageView.layer.cornerRadius = 5;
//imageView.layer.masksToBounds = YES;
//上面这种方式也可以 ， iOS 9 之后专门针对UIImageView做了圆角优化设置，layer.masksToBounds 不再莉萍渲染， 但是其他View不行
#import "UIImageView+CornerRadios.h"
#import <objc/runtime.h>


@implementation UIImageView (CornerRadios)
@dynamic cornerRadius;

-(void)setCornerRadius:(CGFloat)cornerRadius{
    objc_setAssociatedObject(self, @selector(cornerRadius), @(cornerRadius), OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIImage *showImage = self.image;
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius] addClip];
    [showImage drawInRect:self.bounds];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(CGFloat)cornerRadius{
     return [objc_getAssociatedObject(self, @selector(cornerRadius)) floatValue];
}
@end
