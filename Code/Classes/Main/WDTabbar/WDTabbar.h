//
//  WDTabbar.h
//  liudaliuda
//
//  Created by 同砚四驱-iOS-云 on 2017/5/4.
//  Copyright © 2017年 4WheelDrive-iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDTabbar : UIView<UITabBarControllerDelegate>

@property(nonatomic,strong)UITabBarController *tabBarController;

+(WDTabbar *)sharedMyTabbar;

@end
