//
//  XCEmotionTool.h
//  JGGDemo
//
//  Created by gao bin on 2018/2/9.
//  Copyright © 2018年 apple. All rights reserved.
// 这个工具主要是 全局公用使用

// 通知
// 表情选中的通知
extern NSString * const XC_EmotionDidSelectNotification;

// 删除文字的通知
extern NSString * const XC_EmotionDidDeleteNotification;


// 选中表情发出的通知
extern NSString * const XC_SelectEmotionNotification;

/**  选中某个表情的Key   */
extern NSString * const XC_SelectEmotionKey;

extern CGFloat inputHeight ;//输入框的默认高度
extern CGFloat keyboardHeight ; //默认的键盘的高度


/***********屏幕适配*************/
#define KmainScreenWidth [UIScreen mainScreen].bounds.size.width
#define KmainScreenHeiht [UIScreen mainScreen].bounds.size.height

#import "UIView+XCFrame.h"
#import "Masonry.h"
#import <UIKit/UIKit.h>

/**  表情底部tabbar 选中的颜色   */
#define EmtionTabarSelectColor [UIColor orangeColor]
/**  表情底部tabbar 未选中选中的颜色   */
#define EmtionTabarncheckColor [[UIColor lightGrayColor] colorWithAlphaComponent:0.4f]
/**  通知中心   */
#define XCNotificationCenter  [NSNotificationCenter defaultCenter]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self


//////////////////////////////获取指定NSBundle下面的图片文件\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//////////////////////////////获取指定NSBundle下面的图片文件\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//////////////////////////////获取指定NSBundle下面的图片文件\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
/** 找到指定的bunlde    */
#define FindeNSBunld(s) [[NSBundle mainBundle] pathForResource:(s) ofType:@"bundle"]

/**  找到bunlde 文件夹下面对应的子文件   */
#define NSBunldInFile(s,f) [NSString stringWithFormat:@"%@/%@",(s),(f)]

/**  获取指定路径图片文件   */
#define GetNSbunldImImage(path,image_name)  [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",(path),(image_name)]]

/**
 获取某个NSbunled 的某个子文件下，的某个图片的宏
 
 @param bunle_name NSbundle 文件名字
 @param bunlde_subFile NSBunlde 的子目录的文件夹
 @param file_subimageName 我们对应子目录文件夹下面的图片名字
 @return 一个图片
 */
#define GETNSbunldINImage(bunle_name,bunlde_subFile,file_subimageName) GetNSbunldImImage(NSBunldInFile(FindeNSBunld(bunle_name), (bunlde_subFile)), (file_subimageName));



/**  自定义打印打印   */
/**  自定义打印打印   */
/**  自定义打印打印   */
#ifdef DEBUG
#define XCLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define XCLog(format, ...)
#endif
