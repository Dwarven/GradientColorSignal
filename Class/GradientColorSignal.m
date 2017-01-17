//
//  GradientColorSignal.m
//  GradientColorSignal
//
//  Created by Dwarven on 2017/1/17.
//  Copyright © 2017 Dwarven. All rights reserved.
//

#import "GradientColorSignal.h"

@interface GradientColorSignal () {
    CAShapeLayer *_progressLayer;
    CAGradientLayer *_gradientLayer;
    
    CALayer *_searchingLayer;
    CAGradientLayer *_gradientLayer1;
    CAGradientLayer *_gradientLayer2;
}

@end

@implementation GradientColorSignal

- (void)dealloc {
    [self cleanupLayers];
}

- (void)cleanupLayers {
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
    [_gradientLayer removeFromSuperlayer];
    _gradientLayer = nil;
    
    [_searchingLayer removeAnimationForKey:@"rotationAnimation"];
    [_gradientLayer1 removeFromSuperlayer];
    _gradientLayer1 = nil;
    [_gradientLayer2 removeFromSuperlayer];
    _gradientLayer2 = nil;
    [_searchingLayer removeFromSuperlayer];
    _searchingLayer = nil;
}

- (id)init {
    self = [super init];
    if (self) {
        [self setupForInitialization];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupForInitialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupForInitialization];
    }
    return self;
}

- (void)setupForInitialization {
    self.clockwise = YES;
    _startPoint = CGPointMake(0.5, 0.0);
    _endPoint = CGPointMake(0.5, 1.0);
    _lineCap = kCALineCapButt;
    _searchingLineWidth = @10.0;
    _searchingColor = [UIColor grayColor];
    _startAlpha = 1.0;
    _endAlpha = 0.1;
    _duration = 1.0;
    _gradientColors = @[(id)[[UIColor colorWithRed:119/255.0f green:234/255.0f blue:243/255.0f alpha:1.0f] CGColor],
                        (id)[[UIColor colorWithRed:129/255.0f green:179/255.0f blue:255/255.0f alpha:1.0f] CGColor]];
    if (!self.backgroundColor) {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)reload {
    [self cleanupLayers];
    if (SignalTypeDefault == _type) {
        CGFloat width = self.bounds.size.width;
        CGFloat radius = width / 2;
        BOOL lineWidthValid = _lineWidth && _lineWidth.floatValue > 0 && _lineWidth.floatValue < radius;
        CGFloat startAngle = _startAngle ? _startAngle.floatValue : 0;
        CGFloat endAngle = _clockwise?startAngle+M_PI*2:startAngle-M_PI*2;
        if (_endAngle) {
            endAngle = _endAngle.floatValue;
        }
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:lineWidthValid ? radius - _lineWidth.floatValue/2 : radius/2 startAngle:startAngle endAngle:endAngle clockwise:_clockwise];
        
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = self.bounds;
        _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
        _progressLayer.strokeColor  = [[UIColor whiteColor] CGColor];
        _progressLayer.lineCap = _lineCap;
        _progressLayer.lineWidth = lineWidthValid ? _lineWidth.floatValue : radius;
        _progressLayer.path = [path CGPath];
        _progressLayer.strokeEnd = 0;
        
        _gradientLayer =  [CAGradientLayer layer];
        _gradientLayer.frame = CGRectMake(0, 0, width, width);
        [_gradientLayer setColors:_gradientColors];
        if (_locations) {
            [_gradientLayer setLocations:_locations];
        }
        [_gradientLayer setStartPoint:_startPoint];
        [_gradientLayer setEndPoint:_endPoint];
        
        
        
        [_gradientLayer setMask:_progressLayer]; //用progressLayer来截取渐变层
        [self.layer addSublayer:_gradientLayer];
    } else {
        CGFloat width = self.bounds.size.width;
        CGFloat radius = width / 2;
        
        BOOL lineWidthValid = _searchingLineWidth && _searchingLineWidth.floatValue > 0 && _searchingLineWidth.floatValue < radius;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:lineWidthValid ? radius - _searchingLineWidth.floatValue/2 : radius/2 startAngle:0 endAngle:-M_PI*2 clockwise:NO];
        
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = self.bounds;
        _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
        _progressLayer.strokeColor  = [[UIColor whiteColor] CGColor];
        _progressLayer.lineCap = _lineCap;
        _progressLayer.lineWidth = lineWidthValid ? _searchingLineWidth.floatValue : radius;
        _progressLayer.path = [path CGPath];
        
        if (_startAlpha < 0.0 || _startAlpha > 1.0) {
            _startAlpha = 1.0;
        }
        if (_endAlpha < 0.0 || _endAlpha > _startAlpha) {
            _endAlpha = 0.1;
        }
        CGFloat middleAlpha = (_startAlpha + _endAlpha) / 2;
        CGFloat components[3];
        [self getRGBComponents:components forColor:_searchingColor];
        
        
        _searchingLayer = [CALayer layer];
        _searchingLayer.frame = CGRectMake(0, 0, width, width);
        _gradientLayer1 =  [CAGradientLayer layer];
        _gradientLayer1.frame = CGRectMake(0, 0, width, width/2);
        if (_clockwise) {
            [_gradientLayer1 setColors:@[(id)[[UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:_startAlpha] CGColor],
                                         (id)[[UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:middleAlpha] CGColor]]];
        } else {
            [_gradientLayer1 setColors:@[(id)[[UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:middleAlpha] CGColor],
                                         (id)[[UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:_startAlpha] CGColor]]];
        }
        [_gradientLayer1 setStartPoint:CGPointMake(1, 0.5)];
        [_gradientLayer1 setEndPoint:CGPointMake(0, 0.5)];
        [_searchingLayer addSublayer:_gradientLayer1];
        
        _gradientLayer2 =  [CAGradientLayer layer];
        _gradientLayer2.frame = CGRectMake(0, width/2, width, width/2);
        if (_clockwise) {
            [_gradientLayer2 setColors:@[(id)[[UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:middleAlpha] CGColor],
                                         (id)[[UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:_endAlpha] CGColor]]];
        } else {
            [_gradientLayer2 setColors:@[(id)[[UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:_endAlpha] CGColor],
                                         (id)[[UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:middleAlpha] CGColor]]];
        }
        [_gradientLayer2 setStartPoint:CGPointMake(0, 0.5)];
        [_gradientLayer2 setEndPoint:CGPointMake(1, 0.5)];
        [_searchingLayer addSublayer:_gradientLayer2];
        
        [_searchingLayer setMask:_progressLayer];
        [self.layer addSublayer:_searchingLayer];
        
        CABasicAnimation* animation;
        animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.duration = _duration;
        animation.toValue = [NSNumber numberWithFloat:_clockwise ? M_PI * 2.0 : -M_PI * 2.0];
        animation.cumulative = YES;
        animation.repeatCount = HUGE_VALF;
        [_searchingLayer addAnimation:animation forKey:@"rotationAnimation"];
    }
}

- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
}

- (void)animateToScale:(CGFloat)scale duration:(CGFloat)duration {
    [self animateToScale:scale duration:duration function:nil];
}

- (void)animateToScale:(CGFloat)scale duration:(CGFloat)duration function:(CAMediaTimingFunction *)function {
    if (SignalTypeDefault == _type) {
        [CATransaction begin];
        if (function) {
            [CATransaction setAnimationTimingFunction:function];
        }
        [CATransaction setAnimationDuration:duration];
        _progressLayer.strokeEnd = scale;
        [CATransaction commit];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self.layer setCornerRadius:self.bounds.size.width/2];
    [self.layer setMasksToBounds:YES];
}

@end
