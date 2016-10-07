//
//  ViewController.m
//  Animation
//
//  Created by SJ on 16/8/1.
//  Copyright © 2016年 SJ. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "ViewOne.h"
#import "ViewTwo.h"
#import "ViewFour.h"
#import "RootViewController.h"
@interface ViewController ()

@property (nonatomic, strong) NSArray<UIView *> *viewArray;
@property (nonatomic, strong) ViewOne *viewOne;
@property (nonatomic, strong) ViewTwo *viewTwo;
@property (nonatomic, strong) ViewFour *viewThree;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    NSLog(@"%f",20/(kScreenHeight-20));
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)createUI{
    [self createViewOne];
    [self createViewTwo];
    [self createViewFour];
    _viewArray = @[_viewOne,_viewTwo,_viewThree];
    [self createButton];


}

- (void)createViewOne{
    _viewOne = [[ViewOne alloc]init];
    [_viewOne createView];
    [self.view addSubview:_viewOne];
}

- (void)createViewTwo{
    _viewTwo = [[ViewTwo alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20)];
    [_viewTwo createView];
    _viewTwo.hidden = YES;
    [self.view addSubview:_viewTwo];
    
}

- (void)createViewFour{
    _viewThree = [[ViewFour alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20)];
    [_viewThree createView];
    _viewThree.hidden = YES;
    typeof(self)weakSelf = self;
    _viewThree.swipBlock = ^{
        [weakSelf.navigationController pushViewController:[RootViewController new] animated:YES];
        
    };
    _viewThree.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_viewThree];
}

- (void)createButton{
    NSArray *array = @[@" One",@" Two",@" Three"];
    for (int i = 0; i < array.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(-6, 100+40*i, 100, 30);
        btn.layer.cornerRadius = 6;
        btn.layer.masksToBounds = YES;
        btn.tag = 100+i;
        btn.backgroundColor = [UIColor colorWithRed:0  green:0 blue:0 alpha:0.5];
        btn.titleLabel.textColor = [UIColor whiteColor];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }


}



-(void)showView:(UIButton *)btn{
    for (int i = 0 ; i<_viewArray.count; i++) {
        if (btn.tag-100 == i) {
            _viewArray[i].hidden = NO;
        }else{
            _viewArray[i].hidden = YES;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
