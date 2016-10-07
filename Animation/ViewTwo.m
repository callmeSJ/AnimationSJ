//
//  ViewTwo.m
//  Animation
//
//  Created by SJ on 16/8/2.
//  Copyright © 2016年 SJ. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "ViewTwo.h"

@interface ViewTwo()

@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, strong)UIView *bullet;
@end


@implementation ViewTwo

- (void)createView{
    
    [self createCatapult];
    [self createBullet];
}

- (void)createCatapult{
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(70, 300, 30, 90)];
    _imgView.image = [UIImage imageNamed:@"catapult.jpg"];
    [_imgView setUserInteractionEnabled:YES];
    [self addSubview:_imgView];
   
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.lineWidth = 5;
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(0, 390)];
    [path addLineToPoint:CGPointMake(kScreenWidth, 390)];
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
    
}

#warning 弹弓这个，只能弄到这个样子了。。

- (void)bulletMove:(UIPanGestureRecognizer *)recognizer{
    CGPoint translation = [recognizer translationInView:self];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    NSLog(@"%f,%f",recognizer.view.center.x,recognizer.view.center.y);
    
    [recognizer setTranslation:CGPointZero inView:self];
    if(recognizer.state == UIGestureRecognizerStateEnded){
        CGPoint startPoint = CGPointMake(recognizer.view.center.x, recognizer.view.center.y);
        float length = sqrtf((recognizer.view.center.x- 80) * (recognizer.view.center.x - 80) + (recognizer.view.center.y - 290) * (recognizer.view.center.y - 290));
        NSLog(@"%f",length);
        NSLog(@"结束移动");
        NSInteger flag = 0;
        NSInteger xx = recognizer.view.center.x - 80;
        NSInteger yy = recognizer.view.center.y - 290;
        if(xx>= 0 && yy < 0){
            flag = 1;
        }else if(xx< 0 && yy < 0){
            flag = 2;
        }else if(xx < 0 && yy >= 0){
            flag = 3;
        }else if(xx >= 0 && yy >= 0){
            flag = 4;
        }
        
        [self bulletAnimationWithLength:length startPoint:startPoint flag:flag];
        recognizer.view.center = CGPointMake(85, 300);
    }
    
}



- (void)createBullet{
    _bullet = [[UIView alloc]initWithFrame:CGRectMake(80, 290, 15, 15)];
    _bullet.backgroundColor = [UIColor redColor];
    [self addSubview:_bullet];
    

    UIPanGestureRecognizer *panRec = [[UIPanGestureRecognizer alloc]
                                      initWithTarget:self
                                      action:@selector(bulletMove:)];
    [_bullet addGestureRecognizer:panRec];
    

    
}


   

- (void)bulletAnimationWithLength:(float)length startPoint:(CGPoint)startPoint flag:(NSInteger)flag{
    // x = length * t * fabs((startPoint.x - 80) / length)
    //y = -1/2*gt^2 +length*K(自己定义>0)*t*fabs((startPoint.y - 290) / length);
    //y方向 y = - 1/2gt^2;
    //x方向 x = V*t; v = length * k;
    //Vx = V初* cos((startPoint.x - 80)/length);
    //Vy = V初* sin((startPoint.y - 290)/length);
    //
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    //自定义k，设置初始速度
    float k = 2.0;
    //初始速度
    float vf = length * k;
    //x方向上速度
    float vx = vf * fabs((startPoint.x - 80) / length);
    //y方向上速度
    float vy = vf * fabs((startPoint.y - 290) / length);
    //到达最高点所需时间
    float ty1 = vy /30.0;
    //从最高点假设下落200所需时间
    float ty2 = sqrtf(2 * (390 - 290 + vx * ty1) / 30);
    //x方向运动的总距离
    float xd = vx * (ty1 + ty2);
    
    NSLog(@"vf:%f  vx:%f  vy:%f  ty1:%f  ty2:%f  xd:%f ",vf,vx,vy,ty1,ty2,xd);
    
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    
    if(flag == 1){
        ty2 = sqrtf(2 * (390 - startPoint.x)/40);
        xd = ty2 * vx;
        
        CGPathAddQuadCurveToPoint(path, NULL, (startPoint.x - xd)/2, startPoint.y + vy * ty2 / 2, startPoint.x - xd, 390 );
        NSLog(@"111");
    }else if(flag == 2){
        ty2 = sqrtf(2 * (390 - startPoint.x)/40);

        xd = ty2 * vx;

        CGPathAddQuadCurveToPoint(path, NULL, (startPoint.x + xd)/2, startPoint.y + vy * ty1 / 2, startPoint.x + xd, 390 );
        NSLog(@"222");
    }else if(flag == 3){
        CGPathAddQuadCurveToPoint(path, NULL, (startPoint.x + xd)/2 , startPoint.y - vy * ty1, startPoint.x + xd, 390 );
        NSLog(@"333");
    }else if(flag == 4){
        CGPathAddQuadCurveToPoint(path, NULL, (startPoint.x - xd)/2 , startPoint.y - vy * ty1, startPoint.x - xd, 390 );
        NSLog(@"444");
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.6];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1];
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    rotateAnimation.duration = 0.8;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.delegate = self;
    groupAnimation.repeatCount = 1;
    groupAnimation.duration = 5;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.animations = @[scaleAnimation,animation,rotateAnimation];
    
    [_bullet.layer addAnimation:groupAnimation forKey:nil];

}


@end
