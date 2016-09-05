//
//  CircleLayer.m
//  LSLoadingAnimation
//
//  Created by Liusui on 16/9/2.
//  Copyright © 2016年 Liusui. All rights reserved.
//

#import "CircleLayer.h"
#import "UIColor+Hex.h"

@interface CircleLayer ()
@property (nonatomic, strong) UIBezierPath *circleSmallPath;
@property (nonatomic, strong) UIBezierPath *circleBigPath;
@property (nonatomic, strong) UIBezierPath *circleVerticalSquishPath;
@property (nonatomic, strong) UIBezierPath *circleHorizontalSquishPath;

@end

static NSTimeInterval const kAnimationDuration = 0.3;
static NSTimeInterval const kAnimationBeginTime = 0.0;

@implementation CircleLayer
- (instancetype)init{
    self = [super init];
    if (self) {
        self.fillColor = [UIColor colorWithHexString:@"#da70d6"].CGColor;
        self.path = self.circleSmallPath.CGPath;
    }
    return self;
}

- (UIBezierPath *)circleSmallPath{
    if (!_circleSmallPath) {
        _circleSmallPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50.0, 50.0, 0.0, 0.0)];
    }
    return _circleSmallPath;
}

- (UIBezierPath *)circleBigPath{
    if (!_circleBigPath) {
        _circleBigPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(2.5, 17.5, 95.0, 95.0)];
    }
    return _circleBigPath;
}

- (UIBezierPath *)circleVerticalSquishPath{
    if (!_circleVerticalSquishPath) {
        _circleVerticalSquishPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(2.5, 20, 95.0, 90)];
    }
    return _circleVerticalSquishPath;
}

- (UIBezierPath *)circleHorizontalSquishPath{
    if (!_circleHorizontalSquishPath) {
        _circleHorizontalSquishPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5.0, 20.0, 90.0, 90.0)];
    }
    return _circleHorizontalSquishPath;
}

- (void)wobbleAnimation{
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation1.fromValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    animation1.toValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation1.beginTime = kAnimationBeginTime;
    animation1.duration = kAnimationDuration;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation2.fromValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation2.toValue = (__bridge id _Nullable)(self.circleHorizontalSquishPath.CGPath);
    animation2.beginTime = animation1.beginTime + animation1.duration;
    animation2.duration = kAnimationDuration;
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation3.fromValue = (__bridge id _Nullable)(self.circleHorizontalSquishPath.CGPath);
    animation3.toValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation3.beginTime = animation2.beginTime + animation2.duration;
    animation3.duration = kAnimationDuration;
    
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation4.fromValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation4.toValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    animation4.beginTime = animation3.beginTime + animation3.duration;
    animation4.duration = kAnimationDuration;
    
    CAAnimationGroup *aniomationGroup = [CAAnimationGroup animation];
    aniomationGroup.animations = @[animation1, animation2, animation3, animation4];
    aniomationGroup.duration = 4 * kAnimationDuration;
    aniomationGroup.repeatCount = 2;
    [self addAnimation:aniomationGroup forKey:nil];
}

- (void)expand{
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    expandAnimation.duration = kAnimationDuration;
    expandAnimation.fromValue = (__bridge id _Nullable)(self.circleSmallPath.CGPath);
    expandAnimation.toValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    expandAnimation.fillMode = kCAFillModeForwards;
    expandAnimation.removedOnCompletion = NO;
    [self addAnimation:expandAnimation forKey:nil];
}

- (void)contract {
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    expandAnimation.fromValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    expandAnimation.toValue = (__bridge id _Nullable)(self.circleSmallPath.CGPath);
    expandAnimation.duration = kAnimationDuration;
    expandAnimation.fillMode = kCAFillModeForwards;
    expandAnimation.removedOnCompletion = NO;
    [self addAnimation:expandAnimation forKey:nil];
}

@end
