//
//  XC_EmotionsView.h
//  JGGDemo
//
//  Created by gao bin on 2018/3/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XC_EmotionToolTabbar.h"

@interface XC_EmotionsView : UIView

-(instancetype)initWithFrame:(CGRect)frame;

/**    设置frame      ****/
@property (nonatomic)CGRect rectFrame;


/**  获得输入的文字   */
-(NSString *)getInputWord;

@end
