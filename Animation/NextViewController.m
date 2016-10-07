//
//  NextViewController.m
//  Animation
//
//  Created by SJ on 16/8/5.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import "NextViewController.h"
#import "TransitionManager.h"
#import "PercentManager.h"
@interface NextViewController()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) PercentManager *gestureManager;
@property (nonatomic, assign) UINavigationControllerOperation operation;

@end

@implementation NextViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    _gestureManager = [PercentManager interactiveTransitionWithTransitionType:XWInteractiveTransitionTypePop             GestureDirection:XWInteractiveTransitionGestureDirectionOut];
    [_gestureManager addPinchGestureForViewController:self];
}


-(void)dealloc{
    NSLog(@"销毁");
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
       
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}


#pragma mark 导航代理
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    _operation = operation;
    return [TransitionManager transitionWithTransitionType:operation == UINavigationControllerOperationPush ? TransitionTypePush:TransitionTypePop];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    
//    return _gestureManager;
    if (_operation == UINavigationControllerOperationPush) {
        PercentManager *interactiveTransitionPush = [_delegate interactiveTransitionForPop];
        return interactiveTransitionPush.interation ? interactiveTransitionPush : nil;
    }else{
        return _gestureManager.interation ? _gestureManager : nil;
    }
}

@end
