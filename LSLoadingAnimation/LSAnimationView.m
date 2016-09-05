//
//  LSAnimationView.m
//  LSLoadingAnimation
//
//  Created by Liusui on 16/9/2.
//  Copyright © 2016年 Liusui. All rights reserved.
//

#import "LSAnimationView.h"
#import "CircleLayer.h"
#import "TriangleLayer.h"
#import "RectangleLayer.h"
#import "WaveLayer.h"

@interface LSAnimationView ()
@property (nonatomic, strong) CircleLayer *circleLayer;
@property (nonatomic, strong) TriangleLayer *angleLayer;
@property (nonatomic, strong) RectangleLayer *redlayer;
@property (nonatomic, strong) RectangleLayer *blueLayer;
@property (nonatomic, strong) WaveLayer *waveLayer;

@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation LSAnimationView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    [self addCirclelayer];
}

- (CircleLayer *)circleLayer{
    if (!_circleLayer) {
        _circleLayer = [[CircleLayer alloc]init];
    }
    return _circleLayer;
}

- (TriangleLayer *)angleLayer{
    if (!_angleLayer) {
        _angleLayer = [[TriangleLayer alloc]init];
    }
    return _angleLayer;
}

- (RectangleLayer *)redlayer{
    if (!_redlayer) {
        _redlayer = [[RectangleLayer alloc]init];
    }
    return _redlayer;
}

- (RectangleLayer *)blueLayer{
    if (!_blueLayer) {
        _blueLayer = [[RectangleLayer alloc]init];
    }
    return _blueLayer;
}

- (WaveLayer *)waveLayer{
    if (!_waveLayer) {
        _waveLayer = [[WaveLayer alloc]init];
    }
    return _waveLayer;
}

- (void)addCirclelayer{
    [self.layer addSublayer:self.circleLayer];
    [self.circleLayer expand];
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(wobbleCircleLayer) userInfo:nil repeats:NO];
}

- (void)wobbleCircleLayer{
    [_circleLayer wobbleAnimation];
    [self.layer addSublayer:self.angleLayer];
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(showTriangleAnimation) userInfo:nil repeats:NO];
}

- (void)showTriangleAnimation{
    [self.angleLayer triangleAnimation];
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(transformRotationZ) userInfo:nil repeats:NO];
}

- (void)transformRotationZ{
    [self.circleLayer contract];
    self.layer.anchorPoint = CGPointMake(0.5, 0.65);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = @(M_PI * 2);
    animation.duration = 0.45;
    animation.removedOnCompletion = true;
    [self.layer addAnimation:animation forKey:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(drawRedRectangleAnimation) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(drawBlueRectangleAnimation) userInfo:nil repeats:NO];
}

- (void)drawRedRectangleAnimation{
    [self.layer addSublayer:self.redlayer];
    [self.redlayer strokeChangeWithColor:[UIColor colorWithHexString:@"#da70d6"]];
}

- (void)drawBlueRectangleAnimation{
    [self.layer addSublayer:self.blueLayer];
    [self.blueLayer strokeChangeWithColor:[UIColor colorWithHexString:@"#40e0b0"]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.layer addSublayer:self.waveLayer];
        [self.waveLayer waveAnimate];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self expandView];
    });
}

- (void)expandView {
    self.backgroundColor = [UIColor colorWithHexString:@"#40e0b0"];
    self.frame = CGRectMake(kScreenWidth / 2 - 50, kScreenHeight / 2 - 50, 100, 100);
    self.layer.sublayers = nil;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    } completion:^(BOOL finished) {
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
