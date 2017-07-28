//
//  WDMJRefresh.m
//  liudaliuda
//
//  Created by 同砚四驱-iOS-云 on 2017/5/5.
//  Copyright © 2017年 4WheelDrive-iOS. All rights reserved.
//

#import "WDMJRefresh.h"

@implementation WDMJRefresh

+(void)refreshWithScrollView:(UIScrollView *)scrollView header:(WDHeaderBlock)refreshHeaderBlock;
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (refreshHeaderBlock) {
            refreshHeaderBlock();
        }
    }];
    header.arrowView.image = [UIImage imageNamed:@"logo_icon"];
    
    //    [header setImages:[self loadImageS] duration:.5f forState:MJRefreshStateRefreshing];
    //    [header setImages:[self loadImageS] forState:MJRefreshStateIdle];
    //
    scrollView.mj_header = header;
}
+(void)refreshWithScrollView:(UIScrollView *)scrollView header:(WDHeaderBlock)refreshHeaderBlock footer:(WDFooterBlock)refreshFooterBlock
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (refreshHeaderBlock) {
            refreshHeaderBlock();
        }
    }];
    header.arrowView.image = [UIImage imageNamed:@"logo_icon"];
    //    [header setImages:[self loadImageS] duration:.5f forState:MJRefreshStateRefreshing];
    //    [header setImages:[self loadImageS] forState:MJRefreshStateIdle];
    
    scrollView.mj_header = header;
    
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (refreshFooterBlock) {
            refreshFooterBlock();
        }
    }];
    footer.arrowView.image = nil;
    //    [footer setImages:[self loadImageS] duration:.5f forState:MJRefreshStateRefreshing];
    //    [header setImages:[self loadImageS] forState:MJRefreshStateIdle];
    
    scrollView.mj_footer = footer;
}
+(void)beginRefreshingScrollView:(UIScrollView *)scrollView withHeader:(BOOL)isHeader
{
    [self endRefreshingScrollView:scrollView];
    
    if (isHeader)[scrollView.mj_header beginRefreshing];
    else [scrollView.mj_footer beginRefreshing];
}
+(void)endRefreshingScrollView:(UIScrollView *)scrollView
{
    if (scrollView.mj_header.isRefreshing)[scrollView.mj_header endRefreshing];
    if (scrollView.mj_footer.isRefreshing)[scrollView.mj_footer endRefreshing];
    
}
+(NSArray *)loadImageS
{
    NSMutableArray *imgMutArr = [NSMutableArray new];
    for (int i = 0; i<5; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"loading_0%d",i]];
        [imgMutArr addObject:img];
    }
    return imgMutArr;
}

@end

