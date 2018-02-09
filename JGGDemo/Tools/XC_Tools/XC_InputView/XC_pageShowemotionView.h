//
//  XC_pageShowemotionView.h
//  JGGDemo
//
//  Created by gao bin on 2018/2/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

// 一页中最多3行
#define XC_EmotionMaxRows 3
// 一行中最多7列
#define XC_EmotionMaxCols 7
// 每一页的表情个数
#define XC_EmotionPageSize ((XC_EmotionMaxRows * XC_EmotionMaxCols) - 1)


@interface XC_pageShowemotionView : UIView


/**    装 表情模型     ****/
@property (nonatomic, strong) NSArray *emotions;

@end
