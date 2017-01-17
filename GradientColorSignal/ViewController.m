//
//  ViewController.m
//  GradientColorSignal
//
//  Created by Dwarven on 2017/1/17.
//  Copyright © 2017 Dwarven. All rights reserved.
//

#import "ViewController.h"
#import "GradientColorSignal.h"

@interface ViewController () {
    NSInteger _index;
    GradientColorSignal * _signal;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _signal = [[GradientColorSignal alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [_signal setCenter:self.view.center];
    [self.view addSubview:_signal];
}

- (void)loadSignalDefault {
    if (SignalTypeDefault != _signal.type) {
        [_signal setType:SignalTypeDefault];
        [_signal setStartAngle:@(-M_PI/2)];
//        [_signal setEndAngle:@(M_PI/2)];
        [_signal setStartPoint:CGPointMake(0, 0.5)];
        [_signal setEndPoint:CGPointMake(1, 0.5)];
        [_signal setLineWidth:@10];
        [_signal setClockwise:NO];
        [_signal setLineCap:kCALineCapRound];
        
        [_signal reload];
    }
}

- (void)loadSignalSearching {
    if (SignalTypeSearching != _signal.type) {
        [_signal setType:SignalTypeSearching];
        [_signal setClockwise:YES];
//        [_signal setSearchingLineWidth:@20];
//        [_signal setDuration:20];
        
        [_signal reload];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    switch (_index) {
        case 0:
            [self loadSignalDefault];
            [_signal animateToScale:0.0 duration:0.3];
            _index++;
            break;
        case 1:
            [self loadSignalDefault];
            [_signal animateToScale:0.33 duration:0.3];
            _index++;
            break;
        case 2:
            [self loadSignalDefault];
            [_signal animateToScale:0.66 duration:0.3];
            _index++;
            break;
        case 3:
            [self loadSignalDefault];
            [_signal animateToScale:1 duration:0.3];
            _index++;
            break;
            
        default:
            [self loadSignalSearching];
            _index = 0;
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
