//
//  XC_EmotionTextView.h
//  JGGDemo
//
//  Created by gao bin on 2018/2/11.
//  Copyright © 2018年 apple. All rights reserved.
//  继承 XC_TextView ,给他增加一个模型属性。便于传值


#import "XC_TextView.h"
#import "XCEmotionModel.h"

@interface XC_EmotionTextView : XC_TextView

//把模型插入某个指定的点
-(void)insertEmotion:(XCEmotionModel *)emotion;


@end
