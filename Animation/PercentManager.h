//
//  PercentManager.h
//  Animation
//
//  Created by SJ on 16/8/6.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureConfig)();
//手势的方向
typedef NS_ENUM(NSUInteger, InteractiveTransitionGestureDirection) {
    XWInteractiveTransitionGestureDirectionOut = 0,
    XWInteractiveTransitionGestureDirectionIn,
    };

//手势转场
typedef NS_ENUM(NSUInteger, InteractiveTransitionType) {
    XWInteractiveTransitionTypePush = 0,
    XWInteractiveTransitionTypePop,
};

@interface PercentManager : UIPercentDrivenInteractiveTransition

@property(nonatomic, assign)BOOL interation;

@property(nonatomic, copy)GestureConfig pushConfig;

+ (instancetype)interactiveTransitionWithTransitionType:(InteractiveTransitionType)type GestureDirection:(InteractiveTransitionGestureDirection)direction;

- (instancetype)initWithTransitionType:(InteractiveTransitionType)type GestureDirection:(InteractiveTransitionGestureDirection)direction;

- (void)addPinchGestureForViewController:(UIViewController *)viewController;


@end
