//
//  WDMJRefresh.h
//  liudaliuda
//
//  Created by 同砚四驱-iOS-云 on 2017/5/5.
//  Copyright © 2017年 4WheelDrive-iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^WDHeaderBlock)();
typedef void (^WDFooterBlock)();
@interface WDMJRefresh : NSObject

//下拉刷新
+(void)refreshWithScrollView:(UIScrollView *)scrollView header:(WDHeaderBlock)refreshHeaderBlock;
//上拉刷新   下拉加载
+(void)refreshWithScrollView:(UIScrollView *)scrollView header:(WDHeaderBlock)refreshHeaderBlock footer:(WDFooterBlock)refreshFooterBlock;
//停止刷新
+(void)endRefreshingScrollView:(UIScrollView *)scrollView;
//开始刷新
+(void)beginRefreshingScrollView:(UIScrollView *)scrollView withHeader:(BOOL)isHeader;
@end
