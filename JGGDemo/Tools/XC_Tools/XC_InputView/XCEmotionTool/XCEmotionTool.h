//
//  XCEmotionTool.h
//  JGGDemo
//
//  Created by gao bin on 2018/2/9.
//  Copyright © 2018年 apple. All rights reserved.
// 这个工具主要是 管理表情数据源

#import <Foundation/Foundation.h>

@interface XCEmotionTool : NSObject


/*  默认表情模型   **/
+ (NSArray *)defaultEmotions;

/**  浪小花   */
+ (NSArray *)lxhEmtions;

/**  qq表情   */
+ (NSArray *)qqEmtions;

@end
