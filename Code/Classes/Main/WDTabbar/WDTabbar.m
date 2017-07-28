//
//  WDTabbar.m
//  liudaliuda
//
//  Created by 同砚四驱-iOS-云 on 2017/5/4.
//  Copyright © 2017年 4WheelDrive-iOS. All rights reserved.
//

#import "WDTabbar.h"

#import "WDFirstViewController.h"
#import "WDSecondViewController.h"
#import "WDThirdViewController.h"
#import "WDFourthViewController.h"

#import "WDNavigationController.h"
#import "AppDelegate.h"


@implementation WDTabbar
{
    UIButton *_selectedButton;
    UILabel *_selectedLabel;
    NSInteger tab_sel_index;
}


static  WDTabbar *_sharedMyTabbar;
+ (WDTabbar *)sharedMyTabbar
{
    if (!_sharedMyTabbar) {
        _sharedMyTabbar = [[WDTabbar alloc] init];
    }
    return _sharedMyTabbar;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createTabbarController];
    }
    return self;
}


#pragma mark - mainFunc

//创建系统tabbar
-(void)createTabbarController
{
    NSMutableArray *tabbarArr = [[NSMutableArray alloc]init];
    
    WDFirstViewController   *firstVC  = [[WDFirstViewController alloc]init];
    WDSecondViewController  *secondVC = [[WDSecondViewController alloc]init];
    WDThirdViewController   *thirdVC  = [[WDThirdViewController alloc]init];
    WDFourthViewController  *fourthVC = [[WDFourthViewController alloc]init];
    
    NSMutableArray *vcs = [[NSMutableArray alloc]initWithObjects:firstVC,secondVC,thirdVC,fourthVC, nil];
    NSDictionary *plistDict = [self loadTabbarPlist];
    NSArray *arr =  [plistDict objectForKey:@"items"];
    
    for (int i = 0; i<vcs.count; i++) {
        WDNavigationController *nav = [[WDNavigationController alloc]initWithRootViewController:[vcs objectAtIndex:i]];
        
        //图片防止被渲染
        nav.tabBarItem.image = [UIImage imageNamed:[[arr objectAtIndex:i]objectForKey:@"imgN"]];
        UIImage *image = [UIImage imageNamed:[[arr objectAtIndex:i]objectForKey:@"sel_imgN"]];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = image;
        
        
        //文字颜色
        nav.tabBarItem.title  =  [[arr objectAtIndex:i]objectForKey:@"title"];
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        [nav.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
        NSMutableDictionary *attrs1 = [NSMutableDictionary dictionary];
        attrs1[NSForegroundColorAttributeName] = [UIColor orangeColor];
        [nav.tabBarItem setTitleTextAttributes:attrs1 forState:UIControlStateSelected];
        
        [tabbarArr addObject:nav];
        
    }

    _tabBarController = [[UITabBarController alloc]init];
    _tabBarController.viewControllers = tabbarArr;
    _tabBarController.selectedIndex = 0;
    tab_sel_index = 0;
    _tabBarController.delegate = self;
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    app.window.rootViewController = _tabBarController;
    
    
}

#pragma mark - subFunc
- (NSDictionary *)loadTabbarPlist
{
    NSString *path = [NSString stringWithFormat:@"%@/WDTabbar.plist",[[NSBundle mainBundle] resourcePath]];
    NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    return plistDict;
}


- (void)createBgImageWithImageName:(NSString *)bgImageName;
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    imageView.frame = _tabBarController.tabBar.bounds;
    [_tabBarController.tabBar addSubview:imageView];
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
     // NSLog(@"点击了第%ld个item",tabBarController.selectedIndex + 1);
    
    if (tab_sel_index == tabBarController.selectedIndex) {
        //发送通知
        switch (tab_sel_index) {
            case 0:
                [[NSNotificationCenter defaultCenter] postNotificationName:
                 fir_scr_top_define object:nil];
                break;
            case 1:
                [[NSNotificationCenter defaultCenter] postNotificationName:
                 sed_scr_top_define object:nil];
                break;
            case 2:
                [[NSNotificationCenter defaultCenter] postNotificationName:
                 thr_scr_top_define object:nil];
                break;
            case 3:
                [[NSNotificationCenter defaultCenter] postNotificationName:
                 for_scr_top_define object:nil];
                break;
                
            default:
                break;
        }
    }
    tab_sel_index = tabBarController.selectedIndex;
}



@end
