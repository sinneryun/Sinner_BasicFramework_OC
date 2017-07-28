//
//  WDGlobalDefine.h
//  liudaliuda
//
//  Created by 同砚四驱-iOS-云 on 2017/5/10.
//  Copyright © 2017年 4WheelDrive-iOS. All rights reserved.
//
//



#pragma mark ------------------------- UI ---------------------------
/*** RGB */
#define WD_RGB(r,g,b) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1]



#define APP_WIDTH   [UIScreen mainScreen].bounds.size.width
#define APP_HEIGHT   [UIScreen mainScreen].bounds.size.height

#define WD_APP_BACKGROUND [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f] //app背景色


#define WD_APP_BLACK  WD_RGB(51,51,51)    //黑色字体

/// RGB(黑灰)
#define MAIN_COLOR_102 WD_RGB(102, 102, 102)





#pragma mark -----------------------  iPhone Model  -------------------------

/*** iPhone 5 / SE */
#define WD_IS_IPHONE_SE SCREEN_WIDTH == 320
/*** iPhone 6 / 6s / 7 / 7s  */
#define WD_IS_IPHONE_7  SCREEN_WIDTH == 375
/*** iPhone 6p / 7p */
#define WD_IS_IPHONE_7P SCREEN_WIDTH == 414





#pragma mark -----------------------  Other  -------------------------

#define iOS10 ([[UIDevice currentDevice] systemVersion] >= 10)


/*** 自定义log **/
#ifdef DEBUG
#define WDLog(...) YYCLog(__VA_ARGS__)
#else
#define WDLog(...)
#endif

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif
/*** iOS10 自定义log **/
#define YYCLog(format, ...) printf("\n [%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

/*** 弱引用 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif
/*** 强引用 */
#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif
/*** 单例 */
#define singleton_h(name) + (instancetype)shared##name;

#if __has_feature(objc_arc)

#define singleton_m(name) \
static id _instance; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
});\
return _instance; \
} \
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instance; \
}

#else

#define singleton_m(name) \
static id _instance; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (oneway void)release \
{ \
\
} \
\
- (id)autorelease \
{ \
return _instance; \
} \
\
- (id)retain \
{ \
return _instance; \
} \
\
- (NSUInteger)retainCount \
{ \
return 1; \
} \
\
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instance; \
}


#endif /* WDGlobalDefine_h */
