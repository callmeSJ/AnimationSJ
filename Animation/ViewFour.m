//
//  ViewFour.m
//  Animation
//
//  Created by SJ on 16/8/5.
//  Copyright © 2016年 SJ. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#import "ViewFour.h"

@implementation ViewFour

- (void)createView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(150, 200, 120, 40);
    btn.layer.borderWidth = 0.5;
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"转场" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(transition:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];

}

- (void)transition:(id)sender{
    NSLog(@"转");
    if (_swipBlock) {
        NSLog(@"rootVC");
        _swipBlock();
    }
}
@end
