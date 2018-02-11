//
//  XC_EmotionTextView.h
//  JGGDemo
//
//  Created by gao bin on 2018/2/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XC_TextView.h"
#import "XCEmotionModel.h"

@interface XC_EmotionTextView : XC_TextView

//把模型插入某个指定的点
-(void)insertEmotion:(XCEmotionModel *)emotion;


@end
