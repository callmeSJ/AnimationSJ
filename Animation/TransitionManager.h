//
//  TransitionManager.h
//  Animation
//
//  Created by SJ on 16/8/5.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum{
    TransitionTypePush,
    TransitionTypePop
}TransitionType;
@interface TransitionManager : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) TransitionType type;


+ (instancetype)transitionWithTransitionType:(TransitionType)type;
- (instancetype)initWithTransitionType:(TransitionType)type;

@end
