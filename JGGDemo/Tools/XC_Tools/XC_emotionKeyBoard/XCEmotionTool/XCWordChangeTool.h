//
//  XCWordChangeTool.h
//  JGGDemo
//
//  Created by gao bin on 2018/2/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XCWordChangeTool : NSObject

/**
 *  普通文字 --> 属性文字
 *
 *  @param text 普通文字
 *
 *  @return 属性文字
 */
+(NSAttributedString *)attributedTextWithText:(NSString *)text;

/*  普通文字 计算高度  **/
+(CGFloat)autoHeightWithString:(NSString *)string Width:(CGFloat)width Font:(NSInteger)font ;

/**  富文本计算高度   */
+(CGFloat )autoHeightWithAttrebutString:(NSAttributedString *)attributStr AndscreenWidth:(CGFloat)screenWidth;


@end
