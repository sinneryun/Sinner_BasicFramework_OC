//
//  WDLoadFirstClass.m
//  liudaliuda
//
//  Created by 同砚四驱-iOS-云 on 2017/5/4.
//  Copyright © 2017年 4WheelDrive-iOS. All rights reserved.
//

#import "WDLoadFirstClass.h"
#import "AppDelegate.h"
#import "WDTabbar.h"


@implementation WDLoadFirstClass

+(void)loadRootControl
{
        [WDTabbar sharedMyTabbar];
}

+ (UIWindow *)getAppWindow
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.window;
}

@end
