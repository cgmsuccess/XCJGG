//
//  XCWordChangeTool.h
//  JGGDemo
//
//  Created by gao bin on 2018/2/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCWordChangeTool : NSObject

/**
 *  普通文字 --> 属性文字
 *
 *  @param text 普通文字
 *
 *  @return 属性文字
 */
+(NSAttributedString *)attributedTextWithText:(NSString *)text;

@end
