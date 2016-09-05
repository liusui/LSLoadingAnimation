//
//  TriangleLayer.m
//  LSLoadingAnimation
//
//  Created by Liusui on 16/9/5.
//  Copyright © 2016年 Liusui. All rights reserved.
//

#import "TriangleLayer.h"
#import "UIColor+Hex.h"

@interface TriangleLayer ()
@property (nonatomic, strong) UIBezierPath *trianglePath;
@property (nonatomic, strong) UIBezierPath *leftAnglePath;
@property (nonatomic, strong) UIBezierPath *rightAnglePath;
@property (nonatomic, strong) UIBezierPath *topAnglepath;

@end

static CGFloat const paddingSpace = 30.0;

@implementation TriangleLayer
- (instancetype)init{
    if (self == [super init]) {
        self.fillColor = [UIColor colorWithHexString:@"#da70d6"].CGColor;
        self.strokeColor = [UIColor colorWithHexString:@"#da70d6"].CGColor;
        self.lineWidth = 7.0;
        self.lineCap = kCALineCapRound;
        self.lineJoin = kCALineJoinRound;
        self.path = self.trianglePath.CGPath;
    }
    return self;
}

- (UIBezierPath *)trianglePath{
    if (!_trianglePath) {
        _trianglePath = [[UIBezierPath alloc]init];
        [_trianglePath moveToPoint:CGPointMake(5.0 + paddingSpace, 95.0)];
        [_trianglePath addLineToPoint:CGPointMake(50.0 , 12.5 + paddingSpace)];
        [_trianglePath addLineToPoint:CGPointMake(95.0 - paddingSpace, 95.0)];
        [_trianglePath closePath];
    }
    return _trianglePath;
}

- (UIBezierPath *)leftAnglePath{
    if (!_leftAnglePath) {
        _leftAnglePath = [[UIBezierPath alloc]init];
        [_leftAnglePath moveToPoint:CGPointMake(5.0, 95.0)];
        [_leftAnglePath addLineToPoint:CGPointMake(50.0, 12.5 + paddingSpace)];
        [_leftAnglePath addLineToPoint:CGPointMake(95 - paddingSpace, 95.0)];
        [_leftAnglePath closePath];
    }
    return _leftAnglePath;
}

- (UIBezierPath *)rightAnglePath{
    if (!_rightAnglePath) {
        _rightAnglePath = [[UIBezierPath alloc]init];
        [_rightAnglePath moveToPoint:CGPointMake(5.0, 95.0)];
        [_rightAnglePath addLineToPoint:CGPointMake(50.0, 12.5 + paddingSpace)];
        [_rightAnglePath addLineToPoint:CGPointMake(95, 95.0)];
        [_rightAnglePath closePath];
    }
    return _rightAnglePath;
}

- (UIBezierPath *)topAnglepath{
    if (!_topAnglepath) {
        _topAnglepath = [[UIBezierPath alloc]init];
        [_topAnglepath moveToPoint:CGPointMake(5.0, 95.0)];
        [_topAnglepath addLineToPoint:CGPointMake(50.0, 12.5)];
        [_topAnglepath addLineToPoint:CGPointMake(95, 95.0)];
        [_topAnglepath closePath];
    }
    return _topAnglepath;
}

- (void)triangleAnimation{
    CABasicAnimation *animaitionLeft = [CABasicAnimation animationWithKeyPath:@"path"];
    animaitionLeft.fromValue = (__bridge id _Nullable)(self.trianglePath.CGPath);
    animaitionLeft.toValue = (__bridge id _Nullable)(self.leftAnglePath.CGPath);
    animaitionLeft.duration = 0.3;
    animaitionLeft.beginTime = 0.0;
    
    CABasicAnimation *animationRight = [CABasicAnimation animationWithKeyPath:@"path"];
    animationRight.fromValue = (__bridge id _Nullable)(self.leftAnglePath.CGPath);
    animationRight.toValue = (__bridge id _Nullable)(self.rightAnglePath.CGPath);
    animationRight.duration = 0.3;
    animationRight.beginTime = 0.3;
    
    CABasicAnimation *animationTop = [CABasicAnimation animationWithKeyPath:@"path"];
    animationTop.fromValue = (__bridge id _Nullable)(self.rightAnglePath.CGPath);
    animationTop.toValue = (__bridge id _Nullable)(self.topAnglepath.CGPath);
    animationTop.duration = 0.3;
    animationTop.beginTime = 0.6;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[animaitionLeft, animationRight, animationTop];
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.duration = 0.9;
    animationGroup.removedOnCompletion = NO;
    [self addAnimation:animationGroup forKey:nil];
}

@end
