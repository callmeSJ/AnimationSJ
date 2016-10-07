//
//  RootViewController.m
//  Animation
//
//  Created by SJ on 16/8/5.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import "RootViewController.h"
#import "NextViewController.h"
#import "PercentManager.h"
@interface RootViewController()<NextControllerDelegate>

@property (nonatomic, strong) PercentManager *gestureManager;
@end


@implementation RootViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    self.navigationItem.title = @"自定义转场";

    [self createBtn];
}

- (void)createBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(150, 200, 120, 40);
    btn.layer.borderWidth = 0.5;
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitleColor:[UIColor  blueColor] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"转场" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(transition) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    _gestureManager = [PercentManager interactiveTransitionWithTransitionType:XWInteractiveTransitionTypePush GestureDirection:XWInteractiveTransitionGestureDirectionIn];
    typeof(self)weakSelf = self;
    _gestureManager.pushConfig = ^(){
        [weakSelf transition];
    };
    [_gestureManager addPinchGestureForViewController:self];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}



- (void)transition{
    NextViewController *ctrl = [[NextViewController alloc] init];
    self.navigationController.delegate = ctrl;
    ctrl.delegate = self;
    [self.navigationController pushViewController:ctrl animated:YES];
    
}

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPop{
    return _gestureManager;
}


- (void)dealloc{
    NSLog(@"销毁1");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
