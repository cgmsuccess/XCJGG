//
//  XCtextExchangeAttachModel.h
//  JGGDemo
//
//  Created by gao bin on 2018/2/26.
//  Copyright © 2018年 apple. All rights reserved.
//  普通字符串，转属性字符串 模型

#import <Foundation/Foundation.h>

@interface XCtextExchangeAttachModel : NSObject


/** 这段文字的内容 */
@property (nonatomic, copy) NSString *text;
/** 这段文字的范围 */
@property (nonatomic, assign) NSRange range;
/** 是否为特殊文字 */
@property (nonatomic, assign, getter = isSpecical) BOOL special;
/** 是否为表情 */
@property (nonatomic, assign, getter = isEmotion) BOOL emotion;

@end
