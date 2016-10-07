//
//  TransitionManager.m
//  Animation
//
//  Created by SJ on 16/8/5.
//  Copyright © 2016年 SJ. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#import "TransitionManager.h"

@implementation TransitionManager

+ (instancetype)transitionWithTransitionType:(TransitionType)type{
    TransitionManager *manager = [[TransitionManager alloc] initWithTransitionType:type];
    return manager;
}

- (instancetype)initWithTransitionType:(TransitionType)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{

    switch (_type) {
        case TransitionTypePush:
            [self pushAnimation:transitionContext];
            break;
        case TransitionTypePop:
            [self popAnimation:transitionContext];
            break;
        default:
            break;
    }
}


- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
//    UIView *tempView = containerView.subviews.lastObject;
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    fromVC.view.hidden = YES;    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.transform = CGAffineTransformMakeScale(1, 0.030912);
        
    } completion:^(BOOL finished) {
        NSLog(@"完成1");
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
        if ([transitionContext transitionWasCancelled]) {
            
            [tempView removeFromSuperview];
            fromVC.view.hidden = NO;
            NSLog(@"Transition PushCancel");
        }else{
            NSLog(@"Transition Push NotCalcel");
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            tempView.transform = CGAffineTransformTranslate(tempView.transform, -kScreenWidth, 0);
            
        } completion:^(BOOL finished) {
            NSLog(@"完成2");
            //                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            //                if ([transitionContext transitionWasCancelled]) {
            //                    [tempView removeFromSuperview];
            //                     fromVC.view.hidden = NO;
            //                }
        }];
        }
    }];

    
}



- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
    [containerView addSubview:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.transform = CGAffineTransformTranslate(tempView.transform, kScreenWidth, 0);
        
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            NSLog(@"Pop Calcel");
        }else{
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                tempView.transform = CGAffineTransformScale(tempView.transform, 1, 32.3498965);
            } completion:^(BOOL finished) {
                NSLog(@"Pop Finish");
                [transitionContext completeTransition:YES];
                [tempView removeFromSuperview];
                toVC.view.hidden = NO;
            }];
            
            
        }
    }];

    
    
    
}


@end
