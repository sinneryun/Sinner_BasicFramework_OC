//
//  WDNavigationController.m
//  liudaliuda
//
//  Created by 同砚四驱-iOS-云 on 2017/5/4.
//  Copyright © 2017年 4WheelDrive-iOS. All rights reserved.
//

#import "WDNavigationController.h"

@interface WDNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation WDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}

+ (void)initialize
{
    [self setupNavigationBar];
}

- (BOOL)shouldAutorotate{
    return YES;
}


//navBar_Background
+ (void)setupNavigationBar
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    //[appearance setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [appearance setShadowImage:UIImage.new];
    
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = WD_APP_BLACK;
    textAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:19];
    [appearance setTitleTextAttributes:textAttribute];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *backBtn = [[UIButton alloc]init];
        backBtn.frame = CGRectMake(0, 0, 40, 30);
        [backBtn setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
        [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
        [backBtn addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        viewController.navigationItem.leftBarButtonItem = leftItem;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popView
{
    [self popViewControllerAnimated:YES];
}

#pragma mark -- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}


@end
