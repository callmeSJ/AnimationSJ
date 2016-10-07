//
//  NextViewController.h
//  Animation
//
//  Created by SJ on 16/8/5.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NextControllerDelegate <NSObject>

- (void)presentedOneControllerPressedDissmiss;
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPop;

@end

@interface NextViewController : UIViewController<UINavigationControllerDelegate>
@property (nonatomic, weak) id<NextControllerDelegate> delegate;

@end
