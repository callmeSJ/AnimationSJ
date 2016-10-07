//
//  ViewOne.m
//  Animation
//
//  Created by SJ on 16/8/2.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import "ViewOne.h"

@interface ViewOne()

@property(nonatomic, strong)CAShapeLayer *layer2;
@property(nonatomic, strong)CAShapeLayer *layer3;
@property(nonatomic, strong)UIImage *penImg;
@end

@implementation ViewOne


-(void)createView{
    

    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    UIBezierPath *path = [UIBezierPath bezierPath];
    layer.lineWidth = 10;

    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    [path moveToPoint:CGPointMake(350, 100)];
    [path addLineToPoint:CGPointMake(325, 125)];
    
    float x = sqrtf(7200);
    [path addArcWithCenter:CGPointMake(265, 185) radius:x startAngle:-M_PI_4 endAngle:M_PI-M_PI_4 clockwise:0];
    
    x = sqrtf(4800);
    [path addArcWithCenter:CGPointMake(255, 197) radius:x startAngle:M_PI-M_PI_4 endAngle:-M_PI_4 clockwise:0];
    x = sqrtf(3200);
    [path addArcWithCenter:CGPointMake(263, 187) radius:x startAngle:-M_PI_4 endAngle:M_PI-M_PI_4 clockwise:0];
    x = sqrtf(800);
    [path addArcWithCenter:CGPointMake(243, 207) radius:x startAngle:M_PI-M_PI_4 endAngle:-(M_PI/3) clockwise:0];
    [path moveToPoint:CGPointMake(160, 290)];
    [path addLineToPoint:CGPointMake(180, 200)];
    
    [path moveToPoint:CGPointMake(160, 290)];
    [path addLineToPoint:CGPointMake(250, 266)];
    
    layer.lineCap = kCALineCapRound;
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
    
    
    CABasicAnimation *animation1 = [[CABasicAnimation alloc]init];
    animation1.keyPath = @"strokeEnd";
    animation1.fromValue = @(0.0);
    animation1.toValue = @(1.0);
    animation1.duration = 8;
    animation1.repeatCount = MAXFLOAT;
    animation1.removedOnCompletion = NO;
    animation1.fillMode = kCAFillModeForwards;
    [layer addAnimation:animation1 forKey:@"animation1"];

    

    
    //加图片动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.duration = 8;
    pathAnimation.repeatCount = MAXFLOAT;
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, 350, 60);
    CGPathAddLineToPoint(curvedPath, NULL, 325, 85);
     x = sqrtf(7200);
    CGPathAddArc(curvedPath, NULL, 265, 185, x, -M_PI_4, M_PI-M_PI_4, YES);
    x = sqrtf(4800);
    CGPathAddArc(curvedPath, NULL, 255, 197, x, M_PI-M_PI_4, -M_PI_4, YES);
    x = sqrtf(3200);
    CGPathAddArc(curvedPath, NULL, 263, 187, x, -M_PI_4, M_PI-M_PI_4, YES);
    x = sqrtf(800);
    CGPathAddArc(curvedPath, NULL, 243, 207, x, M_PI-M_PI_4, -(M_PI/3), YES);
    CGPathMoveToPoint(curvedPath, NULL, 160, 290);
    CGPathAddLineToPoint(curvedPath, NULL, 180, 200);
    CGPathMoveToPoint(curvedPath, NULL, 160, 290);
    CGPathAddLineToPoint(curvedPath, NULL, 250, 266);
    
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    UIImageView *penView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pen.png"]];
    penView.frame = CGRectMake(350, 60, 40, 40);
    penView.layer.position = CGPointMake(0, 0.5);
    [self addSubview:penView];
    
    [penView.layer addAnimation:pathAnimation forKey:@"move"];
    
}



@end
