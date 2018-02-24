//
//  UITextView+XCextention.h
//  JGGDemo
//
//  Created by gao bin on 2018/2/24.
//  Copyright © 2018年 apple. All rights reserved.
/**  插入文字到指定的光标位置   */
/**  插入文字到指定的光标位置   */
/**  插入文字到指定的光标位置   */
/**  插入文字到指定的光标位置   */

#import <UIKit/UIKit.h>

@interface UITextView (XCextention)

- (void)insertAttributedText:(NSAttributedString *)text;

- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;

@end
