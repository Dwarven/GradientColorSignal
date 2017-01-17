//
//  GradientColorSignal.h
//  GradientColorSignal
//
//  Created by Dwarven on 2017/1/17.
//  Copyright © 2017 Dwarven. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SignalType) {
    SignalTypeUnknown = 0,
    SignalTypeDefault,
    SignalTypeSearching,
};

@interface GradientColorSignal : UIView

/**
 *  The kind of GradientColorSignal.
 */
@property (nonatomic) SignalType type;

/**
 *  The direction in which to draw the arc.
 */
@property (nonatomic) BOOL clockwise;

- (void)reload;

#pragma mark - Signal Type Default

/**
 *  The cap style used when stroking the path. Options are `butt', `round' and `square'.
 *  Defaults to `butt'.
 */
@property (copy) NSString *lineCap;

/**
 *  An optional array of NSNumber objects defining the location of each
 *  gradient stop as a value in the range [0,1]. The values must be
 *  monotonically increasing. If a nil array is given, the stops are
 *  assumed to spread uniformly across the [0,1] range. When rendered,
 *  the colors are mapped to the output colorspace before being
 *  interpolated. Defaults to nil.
 */
@property (copy) NSArray<NSNumber *> *locations;

/**
 *  The start point of the gradient when drawn in the layer’s coordinate space.
 *  The start point corresponds to the first stop of the gradient. The point is defined in the unit coordinate space and is then mapped to the layer’s bounds rectangle when drawn.
 *  Default value is (0.5,0.0)
 */
@property CGPoint startPoint;

/**
 *  The end point of the gradient when drawn in the layer’s coordinate space.
 *  The end point corresponds to the last stop of the gradient. The point is defined in the unit coordinate space and is then mapped to the layer’s bounds rectangle when drawn.
 *  Default value is (0.5,1.0).
 */
@property CGPoint endPoint;

/**
 *  An array of CGColorRef objects defining the color of each gradient stop.
 *  Defaults to nil.
 */
@property (nonatomic) NSArray* gradientColors;

/**
 *  Specifies the starting angle of the arc (measured in radians).
 */
@property (nonatomic) NSNumber* startAngle;

/**
 *  Specifies the end angle of the arc (measured in radians).
 */
@property (nonatomic) NSNumber* endAngle;

/**
 *  The line width used when stroking the path.
 *  Valid condition: 0 < lineWidth < radius.
 *  Defaults to nil.
 */
@property (nonatomic) NSNumber * lineWidth;

- (void)animateToScale:(CGFloat)scale duration:(CGFloat)duration;
- (void)animateToScale:(CGFloat)scale duration:(CGFloat)duration function:(CAMediaTimingFunction *)function;

#pragma mark - Signal Type Searching

/**
 *  The line width for SignalTypeSearching used when stroking the path.
 *  Valid condition: 0 < lineWidth < radius.
 *  Defaults to 10.0.
 */
@property (nonatomic) NSNumber * searchingLineWidth;

/**
 *  The color of gradient stop.
 *  Defaults to gray.
 */
@property (nonatomic) UIColor* searchingColor;

/**
 *  The start opacity value of the searchingColor object, specified as a value from 0.0 to 1.0.
 *  Default value is 1.0.
 */
@property (nonatomic) CGFloat startAlpha;

/**
 *  The end opacity value of the searchingColor object, specified as a value from 0.0 to 1.0.
 *  Valid condition: endAlpha < startAlpha.
 *  Default value is 0.1.
 */
@property (nonatomic) CGFloat endAlpha;


/**
 *  The duration for rotation animation.
 *  Default value is 1.0.
 */
@property CFTimeInterval duration;

@end
