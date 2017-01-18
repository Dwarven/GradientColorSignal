# GradientColorSignal

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/GradientColorSignal.svg)](https://img.shields.io/cocoapods/v/GradientColorSignal.svg)
[![Platform](https://img.shields.io/cocoapods/p/GradientColorSignal.svg)](http://cocoadocs.org/docsets/GradientColorSignal)
[![Twitter](https://img.shields.io/badge/twitter-@DwarvenYang-blue.svg)](http://twitter.com/DwarvenYang)
[![License](https://img.shields.io/github/license/Dwarven/GradientColorSignal.svg)](https://img.shields.io/github/license/Dwarven/GradientColorSignal.svg)

Animated Gradient Color Signal.

# Podfile
To integrate GradientColorSignal into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'GradientColorSignal'
```
#Preview
##full
![Demo Gif](https://raw.githubusercontent.com/Dwarven/GradientColorSignal/master/demo1.gif)

##hollow
![Demo Gif](https://raw.githubusercontent.com/Dwarven/GradientColorSignal/master/demo2.gif)

# How to use
## Signal Type Default:

```obj-c
#import "GradientColorSignal.h"

#pragma mark - init and setup GradientColorSignal

_signal = [[GradientColorSignal alloc] init];
[_signal setType: SignalTypeDefault];
[_signal setStartAngle: @(-M_PI/2)];
//[_signal setEndAngle: @(M_PI/2)];
[_signal setStartPoint: CGPointMake(0, 0.5)];
[_signal setEndPoint: CGPointMake(1, 0.5)];
[_signal setLineWidth: @10];
[_signal setClockwise: NO];
[_signal setLineCap: kCALineCapRound];
        
[_signal reload];

#pragma mark - animations
//type 1:
[_signal animateToScale: 0.33 duration: 0.3];
//type 2:
[_signal animateToScale: 0.33 duration: 0.3 function:[CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]];
```

## Signal Type Searching:

```obj-c
#import "GradientColorSignal.h"

_signal = [[GradientColorSignal alloc] init];
[_signal setType: SignalTypeSearching];
[_signal setSearchingColor: [UIColor grayColor]];
[_signal setStartAlpha: 1.0];
[_signal setEndAlpha: 0.1];
[_signal setClockwise: YES];
[_signal setSearchingLineWidth: @10];
[_signal setDuration: 1.0];

[_signal reload]; //Auto-rotate when loaded
```

## Stop Animation:

```obj-c
[_signal stop];
```
