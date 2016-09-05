//
//  RectangleLayer.m
//  LSLoadingAnimation
//
//  Created by Liusui on 16/9/5.
//  Copyright © 2016年 Liusui. All rights reserved.
//

#import "RectangleLayer.h"

@interface RectangleLayer ()
@property (nonatomic, strong) UIBezierPath *fullPath;

@end

static const CGFloat KLineWidth = 5.0;

@implementation RectangleLayer

- (instancetype)init{
    if (self == [super init]) {
        self.fillColor = [UIColor clearColor].CGColor;
        self.lineWidth = KLineWidth;
        self.path = self.fullPath.CGPath;
    }
    return self;
}

- (UIBezierPath *)fullPath{
    if (!_fullPath) {
        _fullPath = [[UIBezierPath alloc]init];
        [_fullPath moveToPoint:CGPointMake(0.0, 100)];
        [_fullPath addLineToPoint:CGPointMake(0.0, -KLineWidth)];
        [_fullPath addLineToPoint:CGPointMake(100.0, -KLineWidth)];
        [_fullPath addLineToPoint:CGPointMake(100.0, 100.0)];
        [_fullPath addLineToPoint:CGPointMake(-KLineWidth / 2, 100.0)];
        [_fullPath closePath];
    }
    return _fullPath;
}

- (void)strokeChangeWithColor:(UIColor *)color {
    self.strokeColor = color.CGColor;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = 0.4;
    [self addAnimation:animation forKey:nil];
}

@end
