//CAShapeLayer 会有离屏渲染

#import "UIView+CornerRadio.h"
#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>


@implementation UIView (CornerRadio)
@dynamic cornerRadius;

-(void)setCornerRadius:(CGFloat)cornerRadius{
    objc_setAssociatedObject(self, @selector(cornerRadius), @(cornerRadius), OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.bounds.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

-(CGFloat)cornerRadius{
    return [objc_getAssociatedObject(self, @selector(cornerRadius)) floatValue];
}
@end
