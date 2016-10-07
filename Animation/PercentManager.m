//
//  PercentManager.m
//  Animation
//
//  Created by SJ on 16/8/6.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import "PercentManager.h"

@interface PercentManager()

@property (nonatomic, weak) UIViewController *vc;
@property (nonatomic, assign) InteractiveTransitionGestureDirection direction;
@property (nonatomic, assign) InteractiveTransitionType type;

@end



@implementation PercentManager

+ (instancetype)interactiveTransitionWithTransitionType:(InteractiveTransitionType)type GestureDirection:(InteractiveTransitionGestureDirection)direction{
    return [[PercentManager alloc]initWithTransitionType:type GestureDirection:direction];
    
}

- (instancetype)initWithTransitionType:(InteractiveTransitionType)type GestureDirection:(InteractiveTransitionGestureDirection)direction{
    self = [super init];
    if(self){
        _direction = direction;
        _type = type;
    }
    return self;
}

- (void)addPinchGestureForViewController:(UIViewController *)viewController{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGestureAction:)];
    _vc = viewController;
    [viewController.view addGestureRecognizer:pinch];
}

- (void)pinchGestureAction:(UIPinchGestureRecognizer *)pinchGesture{
    CGFloat persent = 0;
    switch (_direction) {
        case XWInteractiveTransitionGestureDirectionOut:{
            CGFloat scale = pinchGesture.scale;
            NSLog(@"%f",scale);
            persent = (scale - 1) / 1.0;

        }
            break;
        case XWInteractiveTransitionGestureDirectionIn:{
            CGFloat scale = pinchGesture.scale;
            NSLog(@"%f",scale);
            persent = (1 - scale) / 1.0;
            
        }
            break;
       
    }
    switch (pinchGesture.state) {
        case UIGestureRecognizerStateBegan:
            self.interation = YES;
            [self startGesture];
            break;
        case UIGestureRecognizerStateChanged:{
            [self updateInteractiveTransition:persent];
            NSLog(@"percent:%f",persent);
            break;
        }
        case UIGestureRecognizerStateEnded:{
            self.interation = NO;
            NSLog(@"endPercent:%f",persent);
            if (persent > 0.3) {
                [self finishInteractiveTransition];
                NSLog(@"Percent Finish");
            }else{
                [self cancelInteractiveTransition];
                NSLog(@"Percent cancel");
            }
            break;
        }
        default:
            break;
    }

    

}

- (void)startGesture{
    switch (_type) {
        case XWInteractiveTransitionTypePush:{
            if (_pushConfig) {
                _pushConfig();
            }
        }
            break;
        case XWInteractiveTransitionTypePop:
            [_vc.navigationController popViewControllerAnimated:YES];
            break;
    }
}

@end
