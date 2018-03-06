//
//  XCEmotionTool.h
//  JGGDemo
//
//  Created by gao bin on 2018/2/9.
//  Copyright © 2018年 apple. All rights reserved.
// 这个工具主要是 管理表情数据源 根据模型获取表情
// 这个工具主要是 管理表情数据源 根据模型获取表情
// 这个工具主要是 管理表情数据源 根据模型获取表情
// 这个工具主要是 管理表情数据源 根据模型获取表情


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class XCEmotionModel;

@interface XCEmotionTool : NSObject

/**  最近使用的表情数据   */
+ (NSArray *)recentEmotions;

/*  默认表情模型   **/
+ (NSArray *)defaultEmotions;

/**  浪小花   */
+ (NSArray *)lxhEmtions;

/**  qq表情   */
+ (NSArray *)qqEmtions;

/**  根据模型获取到单独的某一个表情图片   */
+(UIImage *)getSelectEmtionImage:(XCEmotionModel *)emtionModel;

/**  插入此表情模型到沙盒里面   */
+ (void)addRecentEmotion:(XCEmotionModel *)emotion;

/**
 *  通过 表情描述找到对应的 表情模型
 *  @param chs 表情描述
 */
+ (XCEmotionModel *)emotionWithChs:(NSString *)chs;


@end


